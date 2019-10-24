//
//  OpenMTTouch.m
//  OpenMultitouchSupport
//
//  Created by Takuto Nakamura on 2019/07/11.
//  Copyright © 2019 Takuto Nakamura. All rights reserved.
//

#import "OpenMTTouchInternal.h"

@implementation OpenMTTouch

- (id)initWithMTTouch:(MTTouch *)touch {
    if (self = [super init]) {
        _identifier = touch->identifier;
        _state = touch->state;
        _posX = touch->normalizedPosition.position.x;
        _posY = touch->normalizedPosition.position.y;
        _velX = touch->normalizedPosition.velocity.x;
        _velY = touch->normalizedPosition.velocity.y;
        _total = touch->total;
        _pressure = touch->pressure;
        _minorAxis = touch->minorAxis;
        _majorAxis = touch->majorAxis;
        _angle = touch->angle;
        _density = touch->density;
        _timestamp = touch->timestamp;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"ID: %i, State: %lu, Position: [%f, %f], Velocity: [%f, %f], Total: %f, Pressure: %f, Minor: %f, Major: %f, Angle: %f, Density: %f, Timestamp: %lf",
            _identifier, _state, _posX, _posY, _velX, _velY, _total, _pressure, _minorAxis, _majorAxis, _angle, _density, _timestamp];
}

@end

