//
//  AppMacro.h
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/18.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//
/* ***************************** 分隔线 ***************************** */
/* ---------  ** 环境/开关 **  --------- */
#define DEBUG_MODULUS



/* ***************************** 分隔线 ***************************** */
#ifdef DEBUG_MODULUS
/* ---------  ** 测试环境 **  --------- */
#define debugLog(...) NSLog(__VA_ARGS__)



#else
/* ---------  ** 生产环境 **  --------- */
#define debugLog(...)




#endif
/* ---------  ** 通知类宏定义 **  --------- */
#define kNotification_notification @"notification"



/* ---------  ** 标识类宏定义 **  --------- */
#define kSymbol_

#define kSymbol_symbol            @"symbol"
#define kSymbol_touchIDIsOpen     @"touchIDIsOpen"
#define kSymbol_gesturePassIsOpen @"gesturePassIsOpen"
/* ---------  ** 其它宏定义 **  --------- */
#define _APP_DISPLAY_NAME _kMainBundleInfo(@"CFBundleDisplayName")
#define _APP_VERSION      _kMainBundleInfo(@"CFBundleShortVersionString")
#define _APP_BACKCOLOR    _kRGB(220,220,220)


/* ***************************** 分隔线 ***************************** */











