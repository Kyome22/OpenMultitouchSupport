//
//  OpenMTManager.m
//  OpenMultitouchSupport
//
//  Created by Takuto Nakamura on 2019/07/11.
//  Copyright © 2019 Takuto Nakamura. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "OpenMTManagerInternal.h"
#import "OpenMTListenerInternal.h"
#import "OpenMTTouchInternal.h"
#import "OpenMTEventInternal.h"
#import "OpenMTInternal.h"

@interface OpenMTManager()

@property (strong, readwrite) NSMutableArray *listeners;
@property (assign, readwrite) MTDeviceRef device;

@end

@implementation OpenMTManager

+ (BOOL)systemSupportsMultitouch {
    return MTDeviceIsAvailable();
}

+ (OpenMTManager *)sharedManager {
    static OpenMTManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = self.new;
    });
    return sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.listeners = NSMutableArray.new;
        
        [NSWorkspace.sharedWorkspace.notificationCenter addObserver:self selector:@selector(willSleep:) name:NSWorkspaceWillSleepNotification object:nil];
        [NSWorkspace.sharedWorkspace.notificationCenter addObserver:self selector:@selector(didWakeUp:) name:NSWorkspaceDidWakeNotification object:nil];
    }
    return self;
}

- (void)makeDevice {
    if (MTDeviceIsAvailable()) {
        self.device = MTDeviceCreateDefault();
        
        uuid_t guid;
        OSStatus err = MTDeviceGetGUID(self.device, &guid);
        if (!err) {
            uuid_string_t val;
            uuid_unparse(guid, val);
            NSLog(@"GUID: %s", val);
        }
        
        int type;
        err = MTDeviceGetDriverType(self.device, &type);
        if (!err) NSLog(@"Driver Type: %d", type);
        
        uint64_t deviceID;
        err = MTDeviceGetDeviceID(self.device, &deviceID);
        if (!err) NSLog(@"DeviceID: %llu", deviceID);
        
        int familyID;
        err = MTDeviceGetFamilyID(self.device, &familyID);
        if (!err) NSLog(@"FamilyID: %d", familyID);
        
        int width, height;
        err = MTDeviceGetSensorSurfaceDimensions(self.device, &width, &height);
        if (!err) NSLog(@"Surface Dimensions: %d x %d ", width, height);
        
        int rows, cols;
        err = MTDeviceGetSensorDimensions(self.device, &rows, &cols);
        if (!err) NSLog(@"Dimensions: %d x %d ", rows, cols);
        
        bool isOpaque = MTDeviceIsOpaqueSurface(self.device);
        NSLog(isOpaque ? @"Opaque: true" : @"Opaque: false");
        
        // MTPrintImageRegionDescriptors(self.device); work
    }
}

//- (void)handlePathEvent:(OpenMTTouch *)touch {
//    NSLog(@"%@", touch.description);
//}

- (void)handleMultitouchEvent:(OpenMTEvent *)event {
    for (int i = 0; i < (int)self.listeners.count; i++) {
        OpenMTListener *listener = self.listeners[i];
        if (listener.dead) {
            [self removeListener:listener];
            continue;
        }
        if (!listener.listening) {
            continue;
        }
        dispatchResponse(^{
            [listener listenToEvent:event];
        });
    }
}

- (void)startHandlingMultitouchEvents {
    [self makeDevice];
    @try {
        MTRegisterContactFrameCallback(self.device, contactEventHandler); // work
        // MTEasyInstallPrintCallbacks(self.device, YES, NO, NO, NO, NO, NO); // work
        // MTRegisterPathCallback(self.device, pathEventHandler); // work
        // MTRegisterMultitouchImageCallback(self.device, MTImagePrintCallback); // not work
        MTDeviceStart(self.device, 0);
    } @catch (NSException *exception) {
        NSLog(@"Failed Start Handling Multitouch Events");
    }
}

- (void)stopHandlingMultitouchEvents {
    if (!MTDeviceIsRunning(self.device)) { return; }
    @try {
        MTUnregisterContactFrameCallback(self.device, contactEventHandler); // work
        // MTUnregisterPathCallback(self.device, pathEventHandler); // work
        // MTUnregisterImageCallback(self.device, MTImagePrintCallback); // not work
        MTDeviceStop(self.device);
        MTDeviceRelease(self.device);
    } @catch (NSException *exception) {
        NSLog(@"Failed Stop Handling Multitouch Events");
    }
}

- (void)willSleep:(NSNotification *)note {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self stopHandlingMultitouchEvents];
    });
}

- (void)didWakeUp:(NSNotification *)note {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self startHandlingMultitouchEvents];
    });
}

// Public Function
- (OpenMTListener *)addListenerWithTarget:(id)target selector:(SEL)selector {
    __block OpenMTListener *listener = nil;
    dispatchSync(dispatch_get_main_queue(), ^{
        if (!self.class.systemSupportsMultitouch) { return; }
        listener = [[OpenMTListener alloc] initWithTarget:target selector:selector];
        if (self.listeners.count == 0) {
            [self startHandlingMultitouchEvents];
        }
        [self.listeners addObject:listener];
    });
    return listener;
}

- (void)removeListener:(OpenMTListener *)listener {
    dispatchSync(dispatch_get_main_queue(), ^{
        [self.listeners removeObject:listener];
        if (self.listeners.count == 0) {
            [self stopHandlingMultitouchEvents];
        }
    });
}

// Utility Tools C Language
static void dispatchSync(dispatch_queue_t queue, dispatch_block_t block) {
    if (!strcmp(dispatch_queue_get_label(queue), dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL))) {
        block();
        return;
    }
    dispatch_sync(queue, block);
}

static void dispatchResponse(dispatch_block_t block) {
    static dispatch_queue_t responseQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        responseQueue = dispatch_queue_create("com.kyome.openmt", DISPATCH_QUEUE_SERIAL);
    });
    dispatch_sync(responseQueue, block);
}

static void contactEventHandler(MTDeviceRef eventDevice, MTTouch eventTouches[], int numTouches, double timestamp, int frame) {
    NSMutableArray *touches = [NSMutableArray array];
    
    for (int i = 0; i < numTouches; i++) {
        OpenMTTouch *touch = [[OpenMTTouch alloc] initWithMTTouch:&eventTouches[i]];
        [touches addObject:touch];
    }
    
    OpenMTEvent *event = OpenMTEvent.new;
    event.touches = touches;
    event.deviceID = (int)eventDevice;
    event.frameID = frame;
    event.timestamp = timestamp;
    
    [OpenMTManager.sharedManager handleMultitouchEvent:event];
}

//static void pathEventHandler(MTDeviceRef device, long pathID, long state, MTTouch* touch) {
//    OpenMTTouch *otouch = [[OpenMTTouch alloc] initWithMTTouch:touch];
//    [OpenMTManager.sharedManager handlePathEvent:otouch];
//}

@end
