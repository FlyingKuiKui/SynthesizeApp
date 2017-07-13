//
//  WSKAppUpdateManager.h
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/4/28.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSKAppUpdateManager : NSObject
+ (void)_checkVersionUpadateWithForce:(BOOL)isForce;
@end
