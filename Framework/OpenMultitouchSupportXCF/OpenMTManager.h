//
//  OpenMTManager.h
//  OpenMultitouchSupport
//
//  Created by Takuto Nakamura on 2019/07/11.
//  Copyright © 2019 Takuto Nakamura. All rights reserved.
//

#ifndef OpenMTManager_h
#define OpenMTManager_h

#import <Foundation/Foundation.h>
#import <OpenMultitouchSupportXCF/OpenMTListener.h>
#import <OpenMultitouchSupportXCF/OpenMTEvent.h>

@interface OpenMTManager: NSObject

+ (BOOL)systemSupportsMultitouch;
+ (OpenMTManager *)sharedManager;

- (OpenMTListener *)addListenerWithTarget:(id)target selector:(SEL)selector;
- (void)removeListener:(OpenMTListener *)listener;

@end

#endif /* OpenMTManager_h */
