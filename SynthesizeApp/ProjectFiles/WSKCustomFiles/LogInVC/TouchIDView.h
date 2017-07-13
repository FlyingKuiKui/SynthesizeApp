//
//  TouchIDView.h
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/20.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^touchIDIsPass)(BOOL pass);

@interface TouchIDView : UIView
@property (nonatomic,copy) touchIDIsPass touchIDIsPass;
- (void)_showTouchIDView;
- (void)_closeTouchIDView;

@end
