//
//  WSKLoadingView.m
//  UIPickViewTest
//
//  Created by 王盛魁 on 16/5/27.
//  Copyright © 2016年 wangsk. All rights reserved.
//

#import "WSKLoadingView.h"

static CGFloat viewWidth = 77;
static CGFloat viewHeight = 77;

@interface WSKLoadingView ()
@property (nonatomic, strong) UIView *backView; // 背景
@property (nonatomic, strong) UIView *logBackView;
@property (nonatomic, strong) UIImageView *imgvLoad; // load 圆图片
@property (nonatomic, strong) UILabel *lblPrompt; // loading...
@property (nonatomic, strong) NSTimer *timer; // 计时器
@end



@implementation WSKLoadingView
#pragma mark - 懒加载
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.2;
    }
    return _backView;
}

- (UIView *)logBackView{
    if (!_logBackView) {
        _logBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
        _logBackView.backgroundColor = [UIColor colorWithRed:0.918 green:0.918 blue:0.918 alpha:1.00];
        _logBackView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        _logBackView.layer.cornerRadius = viewHeight/2;
        _logBackView.layer.masksToBounds = YES;
    }
    return _logBackView;
}

- (UIImageView *)imgvLoad{
    if (!_imgvLoad) {
        _imgvLoad = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading.png"]];
        _imgvLoad.frame = CGRectMake(0, 0, 77, 77);
        _imgvLoad.center = CGPointMake(CGRectGetWidth(self.logBackView.frame)/2, CGRectGetHeight(self.logBackView.frame)/2);
    }
    return _imgvLoad;
}
- (UILabel *)lblPrompt{
    if (!_lblPrompt) {
        _lblPrompt = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.logBackView.frame), [UIScreen mainScreen].bounds.size.width, 30)];
        [_lblPrompt setTextAlignment:NSTextAlignmentCenter];
        [_lblPrompt setTextColor:[UIColor whiteColor]];
        [_lblPrompt setText:@"Loading..."];
    }
    return _lblPrompt;
}

#pragma mark - 单利
+ (WSKLoadingView *)shareWSKLoadingView{
    static WSKLoadingView *loadingView = nil;
    static dispatch_once_t onceToken;
    UIView *view = [[UIApplication sharedApplication].windows firstObject];
    dispatch_once(&onceToken, ^{
        loadingView = [[WSKLoadingView alloc]initWithView:view];
    });
    return loadingView;
}
- (id)initWithView:(UIView *)view {
    NSAssert(view, @"View must not be nil.");
    return [self initWithFrame:view.bounds];
}
#pragma mark - 重写初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        [self addSubview:self.logBackView];
        [self addSubview:self.lblPrompt];

        UIImageView *imgvBack = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logoIcon.png"]];
        imgvBack.frame = CGRectMake(0, 0, 55, 55);
        imgvBack.center = CGPointMake(CGRectGetWidth(self.logBackView.frame)/2, CGRectGetHeight(self.logBackView.frame)/2);
        [self.logBackView addSubview:imgvBack];
        [self.logBackView addSubview:self.imgvLoad];
    }
    return self;
}
#pragma mark - 显示指示器
+ (void)_showWSKLoadingView{
    UIView *view = [[UIApplication sharedApplication].windows firstObject];
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:self]) {
            [subview removeFromSuperview];
        }
    }
    [view addSubview:[WSKLoadingView shareWSKLoadingView]];
    [[WSKLoadingView shareWSKLoadingView] startTimer];
}
#pragma mark - 隐藏指示器
+ (void)_hiddenWSKLoadingView{
    [[WSKLoadingView shareWSKLoadingView] stopTimer];
    UIView *view = [[UIApplication sharedApplication].windows firstObject];
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:self]) {
            [subview removeFromSuperview];
        }
    }
}
#pragma mark - 计时器相关
- (void)startTimer{
    if (self.timer) {
        [self stopTimer];
    }
    self.timer = [NSTimer timerWithTimeInterval:0.06 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)stopTimer{
    [self.timer invalidate];
}
- (void)timerAction{
    self.imgvLoad.transform = CGAffineTransformRotate(_imgvLoad.transform, M_PI /6);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
