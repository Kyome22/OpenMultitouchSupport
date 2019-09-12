//
//  OpenMTInternal.h
//  OpenMultitouchSupport
//
//  Created by Takuto Nakamura on 2019/07/11.
//  Copyright © 2019 Takuto Nakamura. All rights reserved.
//

#ifdef __cplusplus
extern "C" {
#endif
    
    typedef struct {
        float x;
        float y;
    } MTPoint;
    
    typedef struct {
        MTPoint position;
        MTPoint velocity;
    } MTVector;
    
    enum {
        MTTouchStateNotTracking = 0,
        MTTouchStateStartInRange = 1,
        MTTouchStateHoverInRange = 2,
        MTTouchStateMakeTouch = 3,
        MTTouchStateTouching = 4,
        MTTouchStateBreakTouch = 5,
        MTTouchStateLingerInRange = 6,
        MTTouchStateOutOfRange = 7
    };
    
    typedef int MTTouchState;
    
    typedef struct {
        int frame;
        double timestamp;
        int identifier;
        MTTouchState state;
        int fingerId;
        int handId;
        MTVector normalizedPosition;
        float size;
        int field9;
        float angle;
        float majorAxis;
        float minorAxis;
        MTVector absolutePosition;
        int field14;
        int field15;
        float density;
    } MTTouch;
    
    typedef void *MTDeviceRef;
    typedef void (*MTFrameCallbackFunction)(MTDeviceRef device, MTTouch touches[],
                                            int numTouches, double timestamp, int frame);
    typedef void (*MTPathCallbackFunction)(MTDeviceRef device, long pathID, long state, MTTouch* touch);
    // typedef void (*MTImageCallbackFunction)(MTDeviceRef device, int* a, int* b, int* c);
    // typedef void (*MTFullFrameCallbackFunction)(MTDeviceRef device, int a, int b, int c, int d, int e, int f, int g, int h, int i, int j, int k, int l);
    
    bool MTDeviceIsAvailable(void); // true if can create default device
    MTDeviceRef MTDeviceCreateDefault(void);
    OSStatus MTDeviceStart(MTDeviceRef, int);
    OSStatus MTDeviceStop(MTDeviceRef);
    void MTDeviceRelease(MTDeviceRef);
    bool MTDeviceIsRunning(MTDeviceRef);
    bool MTDeviceIsBuiltIn(MTDeviceRef) __attribute__ ((weak_import));
    
    OSStatus MTDeviceGetSensorSurfaceDimensions(MTDeviceRef, int*, int*);
    OSStatus MTDeviceGetSensorDimensions(MTDeviceRef, int*, int*);
    OSStatus MTDeviceGetFamilyID(MTDeviceRef, int*);
    OSStatus MTDeviceGetDeviceID(MTDeviceRef, uint64_t*) __attribute__ ((weak_import));
    OSStatus MTDeviceGetDriverType(MTDeviceRef, int*);
    OSStatus MTDeviceGetGUID(MTDeviceRef, uuid_t*);
    
    void MTRegisterContactFrameCallback(MTDeviceRef, MTFrameCallbackFunction);
    void MTUnregisterContactFrameCallback(MTDeviceRef, MTFrameCallbackFunction);
    
    // void MTRegisterFullFrameCallback(MTDeviceRef, MTFullFrameCallbackFunction);
    // void MTUnregisterFullFrameCallback(MTDeviceRef, MTFullFrameCallbackFunction);
    
    void MTRegisterPathCallback(MTDeviceRef, MTPathCallbackFunction);
    void MTUnregisterPathCallback(MTDeviceRef, MTPathCallbackFunction);
    
    // void MTRegisterMultitouchImageCallback(MTDeviceRef, MTImageCallbackFunction);
    // void MTUnregisterImageCallback(MTDeviceRef, MTImageCallbackFunction);
    
#ifdef __cplusplus
}
#endif


//_MTGetImageProcessingStepName
//_MTGetImageRegionName
//_MTImagePrintCallback
