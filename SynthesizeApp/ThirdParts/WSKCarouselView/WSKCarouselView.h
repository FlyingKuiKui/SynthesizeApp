//
//  WSKCarouselView.h
//  Carouse
//
//  Created by 王盛魁 on 16/5/9.
//  Copyright © 2016年 wangsk. All rights reserved.
//

#import <UIKit/UIKit.h>

// 分页控件位置

typedef NS_ENUM(NSInteger,PagePosition)
{
    PagePosition_None = 1,          // 默认值 == PagePosition_BottomCenter
    PagePosition_Hidden,        // 隐藏
    PagePosition_TopCenter,     // 中上
    PagePosition_BottomLeft,    // 左下
    PagePosition_BottomCenter,  // 中下
    PagePosition_BottomRight    // 右下

};
typedef NS_ENUM(NSInteger,RollDirection)
{
    RollDirection_Horizontal = 1,  // 水平方向 默认值
    RollDirection_Vertical     // 竖直方向
};

// 点击事件
typedef void(^ClickViewBlock)(NSInteger index);

@protocol WSKCarouselViewDelegate <NSObject>

// 点击事件的代理方法
- (void)clickViewWithCurrentIndex:(NSInteger)currentIndex;

@end

/**
 *  重要说明：
 *  1、数据源数组dataArray必须设置；
 *  2、控件的frame必须设置，xib\sb创建的可不设置；
 *  3、其它属性均有默认值，可以不进行设置。
 */

@interface WSKCarouselView : UIView

#pragma mark - Attribute
/**
 *  每一页停留时间，默认为5s
 *  当设置的值小于2s时，则为默认值
 */
@property (nonatomic, assign) NSTimeInterval time;

/**
 * 滚动方向
 */
@property (nonatomic, assign) RollDirection rollDirection;

/**
 * 分页控件位置
 */
@property (nonatomic, assign) PagePosition pagePosition;

/**
 * 数据源数组
 */
@property (nonatomic, copy) NSArray *dataArray;

/**
 * 点击后要执行的操作，会返回数据源数组的当前索引  Block方式
 */
@property (nonatomic, copy) ClickViewBlock clickViewBlock;

/**
 * 点击后要执行的操作，会返回数据源数组的当前索引  Delegate方式
 */
@property (nonatomic, weak) id<WSKCarouselViewDelegate> delegate;

#pragma mark - Method
/**
 * 构造方法
 *
 * @param rollDirection 滚动方向
 *
 */
- (instancetype)initWithFrame:(CGRect)frame RollDirection:(RollDirection)rollDirection;
+ (instancetype)carouselViewWithFrame:(CGRect)frame RollDirection:(RollDirection)rollDirection;

/**
 * 开始计时
 */
- (void)startTimer;

/**
 * 结束计时
 */
- (void)stopTimer;

/**
 *  设置分页控件指示器的图片
 *  两个图片都不能为空，否则设置无效
 *  不设置则为系统默认
 *
 *  @param pageImage    其他页码的图片
 *  @param currentImage 当前页码的图片
 */
- (void)setPageImage:(UIImage *)pageImage andCurrentImage:(UIImage *)currentImage;

/**
 *  设置分页控件指示器的颜色
 *  不设置则为系统默认
 *
 *  @param color    其他页码的颜色
 *  @param currentColor 当前页码的颜色
 */
- (void)setPageColor:(UIColor *)color andCurrentPageColor:(UIColor *)currentColor;

@end
