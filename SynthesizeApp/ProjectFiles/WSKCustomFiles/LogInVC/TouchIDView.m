//
//  TouchIDView.m
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/20.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "TouchIDView.h"
#import <LocalAuthentication/LocalAuthentication.h>  // 第一步，导入此头文件 TouchID

@interface TouchIDView()

@end

@implementation TouchIDView
- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)_showTouchIDView{
//    touchIDIsPass();
    LAContext *context = [LAContext new];
    context.localizedFallbackTitle = @"验证登录密码"; // 解锁失败时，右侧按钮标题
    NSError *error = nil;
    // 第三步，判断是否支持指纹
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"支持指纹解锁");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"通过Home键验证已有手机指纹" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"指纹验证成功，返回主界面");
            }else{
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                        NSLog(@"系统取消授权");
                        break;
                    case LAErrorUserCancel:
                        NSLog(@"用户取消指纹验证");
                        break;
                    case LAErrorAuthenticationFailed:
                        NSLog(@"提供验证的指纹，不存在");
                        break;
                    case kLAErrorTouchIDLockout:
                        NSLog(@"超过5次输入错误，屏幕将锁住");
                        break;
                    case LAErrorPasscodeNotSet:
                        NSLog(@"未设置指纹密码");
                        break;
                    case LAErrorTouchIDNotEnrolled:
                        NSLog(@"不能验证，指纹未被录入");
                        break;
                    case LAErrorTouchIDNotAvailable:
                        NSLog(@"不能获取到指纹");
                        break;
                    case LAErrorUserFallback:
                        NSLog(@"用户选择不使用TouchID解锁,即解锁失败后，点击右侧按钮");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户选择使用密码登录");
                        }];
                        break;
                    default:
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"未知情况，返回主线程进行处理");
                        }];
                        break;
                }
            }
        }];
    }else{
        NSLog(@"不支持指纹解锁");
        NSLog(@"%@",error.localizedDescription);
    }
    
}
- (void)_closeTouchIDView{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
