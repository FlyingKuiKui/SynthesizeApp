//
//  UITextField+WSKCategory.h
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/28.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSKTextRestrict.h"

@interface UITextField (WSKCategory)
@end

@interface UITextField (WSKRestrict)
// 设置后生效
@property (nonatomic,assign) WSKRestrictType restrictType;
// 文本最长长度
@property (nonatomic,assign) NSUInteger maxTextLength;
// 设置自定义的文本限制
@property (nonatomic,strong) WSKTextRestrict *textRestrict;
@end

@interface UITextField (WSKAdjust)
- (void)setAutoAdjust:(BOOL)autoAdjust;
@end
