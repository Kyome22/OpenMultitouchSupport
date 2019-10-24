//
//  OpenMTInternal.h
//  OpenMultitouchSupport
//
//  Created by Takuto Nakamura on 2019/07/11.
//  Copyright © 2019 Takuto Nakamura. All rights reserved.
//


#ifndef OpenMTInternal_h
#define OpenMTInternal_h

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
    float total; //total of capacitance
    float pressure;
    float angle;
    float majorAxis;
    float minorAxis;
    MTVector absolutePosition;
    int field14;
    int field15;
    float density; //area density of capacitance
} MTTouch;

typedef void *MTDeviceRef;
typedef void (*MTFrameCallbackFunction)(MTDeviceRef device, MTTouch touches[], int numTouches, double timestamp, int frame);
typedef void (*MTPathCallbackFunction)(MTDeviceRef device, long pathID, long state, MTTouch* touch);
typedef void (*MTImageCallbackFunction)(MTDeviceRef, void*, void*, void*);

bool MTDeviceIsAvailable(void); // true if can create default device
MTDeviceRef MTDeviceCreateDefault(void);
OSStatus MTDeviceStart(MTDeviceRef, int);
OSStatus MTDeviceStop(MTDeviceRef);
void MTDeviceRelease(MTDeviceRef);
bool MTDeviceIsRunning(MTDeviceRef);
bool MTDeviceIsBuiltIn(MTDeviceRef) __attribute__ ((weak_import));
bool MTDeviceIsOpaqueSurface(MTDeviceRef);

OSStatus MTDeviceGetSensorSurfaceDimensions(MTDeviceRef, int*, int*);
OSStatus MTDeviceGetSensorDimensions(MTDeviceRef, int*, int*);
OSStatus MTDeviceGetFamilyID(MTDeviceRef, int*);
OSStatus MTDeviceGetDeviceID(MTDeviceRef, uint64_t*) __attribute__ ((weak_import));
OSStatus MTDeviceGetDriverType(MTDeviceRef, int*);
OSStatus MTDeviceGetGUID(MTDeviceRef, uuid_t*);
void MTPrintImageRegionDescriptors(MTDeviceRef);


void MTEasyInstallPrintCallbacks(MTDeviceRef, BOOL, BOOL, BOOL, BOOL, BOOL, BOOL);

void MTRegisterContactFrameCallback(MTDeviceRef, MTFrameCallbackFunction);
void MTUnregisterContactFrameCallback(MTDeviceRef, MTFrameCallbackFunction);

void MTRegisterFullFrameCallback(MTDeviceRef, MTFrameCallbackFunction);
void MTUnregisterFullFrameCallback(MTDeviceRef, MTFrameCallbackFunction);

void MTRegisterPathCallback(MTDeviceRef, MTPathCallbackFunction);
void MTUnregisterPathCallback(MTDeviceRef, MTPathCallbackFunction);

// not work
extern MTImageCallbackFunction MTImagePrintCallback;
void MTRegisterMultitouchImageCallback(MTDeviceRef, MTImageCallbackFunction);
void MTRegisterImageCallback(MTDeviceRef, MTImageCallbackFunction, int, int);
void MTUnregisterImageCallback(MTDeviceRef, MTImageCallbackFunction);

#ifdef __cplusplus
}
#endif

#endif /* OpenMTInternal_h */

