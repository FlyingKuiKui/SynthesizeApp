//
//  AppSetting.h
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/18.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSetting : NSObject
#pragma mark - AddData


#pragma mark - QueryData


#pragma mark - ClearData
+ (void)_clearAppLibraryCachesData;
+ (void)_clearAppLibraryPreferenceData;
+ (void)_clearAppTempData;



@end
