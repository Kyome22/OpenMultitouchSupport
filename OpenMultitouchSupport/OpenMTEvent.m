//
//  OpenMTEvent.m
//  OpenMultitouchSupport
//
//  Created by Takuto Nakamura on 2019/07/11.
//  Copyright © 2019 Takuto Nakamura. All rights reserved.
//
// もしかしたらこいつ要らない

#import "OpenMTEventInternal.h"

@implementation OpenMTEvent

- (NSString *)description {
    return [NSString stringWithFormat:@"Touches: %@, Device ID: %i, Frame ID: %i, Timestamp: %f", _touches.description, _deviceID, _frameID, _timestamp];
}

@end

