//
//  NSString+WSKStringCategory.h
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/30.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WSKStringCategory)
/**
 * 转化为JSON字符串
 */
+ (NSString *)toJSONStringWithObject:(id)object;
/**
 * 截取字符串
 *
 * fromString  字符串截取开始字符串
 *
 * toString    字符串截取结束字符串
 *
 * return      截取的字符串数组
 *
 */
- (NSArray *)subStringFromString:(NSString *)fromString ToString:(NSString *)toString;



@end
