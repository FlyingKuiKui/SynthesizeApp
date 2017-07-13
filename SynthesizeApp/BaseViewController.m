//
//  BaseViewController.m
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/20.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_captureImage) name:UIApplicationUserDidTakeScreenshotNotification object:nil];

    // Do any additional setup after loading the view from its nib.
}
#pragma mark - Custom Method
- (void)_goToBackViewControllWithAnimated:(BOOL)animated{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:animated];
    } else {
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}
// 屏幕截图
- (void)_captureImage{
    
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
