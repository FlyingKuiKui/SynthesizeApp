//
//  LogInViewController.m
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/20.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_kUserDefaults_get_bool(kSymbol_touchIDIsOpen)) {
        [self _showTouchIDPassView];
    } else if (_kUserDefaults_get_bool(kSymbol_gesturePassIsOpen)) {
        [self _showGesturePassView];
    }
}
- (void)_showTouchIDPassView{
    [self _removeSubView];

}
- (void)_showGesturePassView{
    [self _removeSubView];

}



- (void)_removeSubView{
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
