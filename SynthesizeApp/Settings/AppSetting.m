//
//  AppSetting.m
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/18.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "AppSetting.h"

@implementation AppSetting
#pragma mark - AddData


#pragma mark - QueryData


#pragma mark - ClaerData
+ (void)_clearAppLibraryCachesData{
    NSString *cachesFilePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
}
+ (void)_clearAppLibraryPreferenceData{
    
}
+ (void)_clearAppTempData{
    
}
@end
