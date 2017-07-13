//
//  UITextField+WSKCategory.m
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/28.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "UITextField+WSKCategory.h"
#import <objc/runtime.h>
#import "WSKTextRestrict.h"

@implementation UITextField (WSKCategory)

@end

static void * WSKRestrictTypeKey = &WSKRestrictTypeKey;
static void * WSKTextRestrictKey = &WSKTextRestrictKey;
static void * WSKMaxTextLengthKey = &WSKMaxTextLengthKey;

@implementation UITextField (WSKRestrict)
- (WSKRestrictType)restrictType{
    return [objc_getAssociatedObject(self, WSKRestrictTypeKey) integerValue];
}

- (void)setRestrictType:(WSKRestrictType)restrictType{
    objc_setAssociatedObject(self, WSKRestrictTypeKey, @(restrictType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.textRestrict = [WSKTextRestrict textRestrictWithRestrictType: restrictType];
}

- (WSKTextRestrict *)textRestrict{
    return objc_getAssociatedObject(self, WSKTextRestrictKey);
}

- (void)setTextRestrict:(WSKTextRestrict *)textRestrict{
    if (self.textRestrict) {
        [self removeTarget: self.text action: @selector(textDidChanged:) forControlEvents: UIControlEventEditingChanged];
    }
    textRestrict.maxLength = self.maxTextLength;
    [self addTarget: textRestrict action: @selector(textDidChanged:) forControlEvents: UIControlEventEditingChanged];
    objc_setAssociatedObject(self, WSKTextRestrictKey, textRestrict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSUInteger)maxTextLength{
    NSUInteger maxTextLength = [objc_getAssociatedObject(self, WSKMaxTextLengthKey) unsignedIntegerValue];
    if (maxTextLength == 0) {
        self.maxTextLength = NSUIntegerMax;
    }
    return [objc_getAssociatedObject(self, WSKMaxTextLengthKey) unsignedIntegerValue];
}

- (void)setMaxTextLength: (NSUInteger)maxTextLength{
    if (maxTextLength == 0) {
        maxTextLength = NSUIntegerMax;
    }
    objc_setAssociatedObject(self, WSKMaxTextLengthKey, @(maxTextLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end



@implementation UITextField (WSKAdjust)
- (void)setAutoAdjust:(BOOL)autoAdjust{
    if (autoAdjust) {
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillShow:) name: UIKeyboardWillShowNotification object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(keyboardWillHide:) name: UIKeyboardWillHideNotification object: nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver: self];
    }
}
- (void)keyboardWillShow:(NSNotification *)notification{
    if (self.isFirstResponder) {
        CGPoint relativePoint = [self convertPoint: CGPointZero toView: [UIApplication sharedApplication].keyWindow];
        
        CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
        CGFloat actualHeight = CGRectGetHeight(self.frame) + relativePoint.y + keyboardHeight;
        CGFloat overstep = actualHeight - CGRectGetHeight([UIScreen mainScreen].bounds) + 5;
        if (overstep > 0) {
            CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
            CGRect frame = [UIScreen mainScreen].bounds;
            frame.origin.y -= overstep;
            [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
                [UIApplication sharedApplication].keyWindow.frame = frame;
            } completion: nil];
        }
    }
}

- (void)keyboardWillHide:(NSNotification *)notification{
    if (self.isFirstResponder) {
        CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        CGRect frame = [UIScreen mainScreen].bounds;
        [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
            [UIApplication sharedApplication].keyWindow.frame = frame;
        } completion: nil];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

@end
