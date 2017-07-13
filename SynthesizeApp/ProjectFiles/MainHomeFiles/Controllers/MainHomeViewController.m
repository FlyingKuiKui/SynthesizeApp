//
//  MainHomeViewController.m
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/18.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "MainHomeViewController.h"
@interface MainHomeViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation MainHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupView];
    // Do any additional setup after loading the view.
}
- (void)_setupView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _kScreenWidth, _kScreenHeight-49)];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.contentSize = CGSizeMake(_kScreenWidth,900);
    [self.view addSubview:self.scrollView];
    
    UIImageView *topBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -20, _kScreenWidth, 200)];
    topBackImage.backgroundColor = _kRGB(200, 202, 200);
    [self.scrollView addSubview:topBackImage];
    
    
    UITextField *txt = [[UITextField alloc]init];
    txt.frame = CGRectMake(10, 600, 200, 40);
    txt.placeholder = @"funck";
    txt.borderStyle = UITextBorderStyleRoundedRect;
    txt.keyboardType = UIKeyboardTypeNamePhonePad;
    txt.restrictType = WSKRestrictTypeOnlyCharacter;
    [txt setAutoAdjust:YES];
    txt.delegate = self;
    [self.scrollView addSubview:txt];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 100, 30)];
    lbl.textColor = [UIColor redColor];
//    [self.scrollView addSubview:lbl];
    NSDictionary *ditccc = @{@"aaa":@"bbbb",@"cccc":@"dddd"};
    NSArray *qqqq = @[@"111",@"222",@"4444"];
    NSString *sss = [NSString toJSONStringWithObject:ditccc];
    NSString *qqqqw = [NSString toJSONStringWithObject:qqqq];
    debugLog(@"%@\n%@",sss,qqqqw);
    debugLog(@"%@",qqqq);
    debugLog(@"%@",qqqqw);
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    self.navigationController.navigationBarHidden = offsetY>0?NO:YES;
    self.navigationController.navigationBar.alpha = (((offsetY/44)>1.0)?1.0:(offsetY/44>0?(offsetY/44):0));
//    debugLog(@"yyyyyy === %f",scrollView.contentOffset.y);
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
