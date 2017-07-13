//
//  WSKBasicMarco.h
//
//  Created by 王盛魁 on 2017/3/18.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#ifndef WSKBasicMarco_h
#define WSKBasicMarco_h
/* ***************************** 分隔线 ***************************** */
/* ****** ****** ******  色值 ****** ****** ****** */
#define _kRGB(R,G,B) _UIColorWithRGB(R,G,B)
#define _kRGBA(R,G,B,A) _UIColorWithRGBA(R,G,B,A)
#define _kRGBV(RGBValue) _UIColorWithRGBValue(RGBValue)
#define _UIColorWithRGB(r,g,b) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.0f]
#define _UIColorWithRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(a)]
#define _UIColorWithRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(a)]
#define _UIColorWithRGBValue(RGBValue) [UIColor colorWithRed:((float)((RGBValue & 0xFF0000) >> 16))/255.0 green:((float)((RGBValue & 0xFF00) >> 8))/255.0 blue:((float)(RGBValue & 0xFF))/255.0 alpha:1.0]
/* ****** ****** ****** 屏幕 ****** ****** ****** */
#define _kScreenSize [[UIScreen mainScreen] bounds].size
#define _kScreenWidth _kScreenSize.width
#define _kScreenHeight _kScreenSize.height
/* ****** ****** ****** 字体 ****** ****** ****** */
#define _kFontSize(fSize) [UIFont systemFontOfSize:fSize]
#define _kFontNameSize(strName,fSize) [UIFont fontWithName:strName size:fSize]
/* ****** ****** ****** UserDefaults ****** ****** ****** */
/* ----------- UserDefaults Set、Get、Remove ----------- */
#define _kUserDefaults [NSUserDefaults standardUserDefaults]
// set
#define _kUserDefaults_set_bool(key,bool) {[_kUserDefaults setBool:YES forKey:key];[_kUserDefaults synchronize];}
#define _kUserDefaults_set_int(key,int) {[_kUserDefaults setInteger:i forKey:key];[_kUserDefaults synchronize];}
#define _kUserDefaults_set_float(key,float) {[_kUserDefaults setFloat:float forKey:key];}
#define _kUserDefaults_set_double(key,double) {[_kUserDefaults setDouble:double forKey:key];[_kUserDefaults synchronize];}
#define _kUserDefaults_set_object(key,object) {[_kUserDefaults setObject:object forKey:key];[_kUserDefaults synchronize];}
#define _kUserDefaults_set_string(key,string) _kUserDefaults_set_object(key,string)
#define _kUserDefaults_set_array(key,array) _kUserDefaults_set_object(key,array)
#define _kUserDefaults_set_dictionary(key,dictionary) _kUserDefaults_set_object(key,dictionary)
#define _kUserDefaults_set_data(key,data) _kUserDefaults_set_object(key,data)
// get
#define _kUserDefaults_get_bool(key) [_kUserDefaults boolForKey:key]
#define _kUserDefaults_get_float(key) [_kUserDefaults floatForKey:key]
#define _kUserDefaults_get_double(key) [_kUserDefaults doubleForKey:key]
#define _kUserDefaults_get_int(key) ((int)[_kUserDefaults integerForKey:key])
#define _kUserDefaults_get_string(key) wsk_safeString([_kUserDefaults stringForKey:key])
#define _kUserDefaults_get_array(key) [_kUserDefaults arrayForKey:key]
#define _kUserDefaults_get_dictionary(key) [_kUserDefaults dictionaryForKey:key]
#define _kUserDefaults_get_data(key) [_kUserDefaults dataForKey:key]
#define _kUserDefaults_get_object(key) [_kUserDefaults objectForKey:key]
// remove
#define _kUserDefaults_remove(key) [_kUserDefaults removeObjectForKey:key]
/* ****** ****** ****** 手机型号 ****** ****** ****** */
#define iPhone4_4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

/* ****** ****** ****** NSMainBundle ****** ****** ****** */
#define _kMainBundle [NSBundle mainBundle]
#define _kMainBundleInfo(key) [_kMainBundle objectForInfoDictionaryKey:key]


/* ***************************** 分隔线 ***************************** */
typedef void (^Closure) (id);

inline __attribute__((always_inline)) NSString *wsk_safeString(NSString *str) { return str ? str : @""; }

inline __attribute__((always_inline)) NSString *wsk_dictionaryValueToString(NSObject *cfObj)
{
    if ([cfObj isKindOfClass:[NSString class]]) return wsk_safeString((NSString *)cfObj);
    else return [(NSNumber *)cfObj stringValue];
}

// If we're currently on the main thread, run block() sync, otherwise dispatch block() sync to main thread.
inline __attribute__((always_inline)) void wsk_executeOnMainThread(void (^block)())
{
    if (block) {
        if ([NSThread isMainThread]) block(); else dispatch_sync(dispatch_get_main_queue(), block);
    }
}
/* ***************************** 分隔线 ***************************** */

#endif /* WSKBasicMarco_h */
