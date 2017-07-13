//
//  WSKCarouselSubView.m
//  Carouse
//
//  Created by 王盛魁 on 16/5/9.
//  Copyright © 2016年 wangsk. All rights reserved.
//

#import "WSKCarouselSubView.h"

@interface WSKCarouselSubView ()

@property (nonatomic, strong) UILabel *lblceshi; // 页面控件

@end

@implementation WSKCarouselSubView
// 懒加载
-(UILabel *)lblceshi{
    if (!_lblceshi) {
        _lblceshi = [[UILabel alloc]init];
    }
    return _lblceshi;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.lblceshi];
    }
    return self;
}
// 为页面控件赋值
- (void)setStrData:(NSString *)strData{
    _strData = strData;
    self.lblceshi.frame = CGRectMake(0, 0, self.bounds.size.width, 30);
    self.lblceshi.text = _strData;
    self.lblceshi.textColor = [UIColor redColor];
    self.lblceshi.textAlignment = NSTextAlignmentCenter;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
