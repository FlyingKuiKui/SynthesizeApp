//
//  WSKCarouselView.m
//  Carouse
//
//  Created by 王盛魁 on 16/5/9.
//  Copyright © 2016年 wangsk. All rights reserved.
//

#import "WSKCarouselView.h"
#import "WSKCarouselSubView.h"

static const NSInteger DEFAULTTIME = 5; // 默认时间
static const NSInteger Margin = 10;

@interface WSKCarouselView ()<UIScrollViewDelegate>
//滚动视图宽度
@property (nonatomic, assign) CGFloat scrollViewWidth;
//滚动视图高度
@property (nonatomic, assign) CGFloat scrollViewHeight;
//滚动视图
@property (nonatomic, strong) UIScrollView *scrollView;
//分页控件
@property (nonatomic, strong) UIPageControl *pageControl;
//当前视图 对应数据源下标
@property (nonatomic, assign) NSInteger currentIndex;
//当前视图
@property (nonatomic, strong) WSKCarouselSubView *currentView;
//下个视图 对应数据源下标
@property (nonatomic, assign) NSInteger nextIndex;
//下个视图
@property (nonatomic, strong) WSKCarouselSubView *nextView;
//定时器
@property (nonatomic, strong) NSTimer *timer;
//pageControl图片大小
@property (nonatomic, assign) CGSize pageImageSize;

@end

@implementation WSKCarouselView

- (CGFloat)scrollViewWidth{
    return  self.frame.size.width;
}
- (CGFloat)scrollViewHeight{
    return self.frame.size.height;
}
- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}
- (WSKCarouselSubView *)currentView{
    if (!_currentView) {
        _currentView = [[WSKCarouselSubView alloc]init];
    }
    return _currentView;
}
- (WSKCarouselSubView *)nextView{
    if (!_nextView) {
        _nextView = [[WSKCarouselSubView alloc]init];
    }
    return _nextView;
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        // 背景色  测试用
        _scrollView.backgroundColor = [UIColor grayColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView)]];
        [_scrollView addSubview:self.currentView];
        [_scrollView addSubview:self.nextView];
    }
    return _scrollView;
}

#pragma mark - 重写setter方法
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setUpUIView];
}
- (void)setTime:(NSTimeInterval)time{
    _time = time;
    [self startTimer];
}
- (void)setDataArray:(NSArray *)dataArray{
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
        [self layoutSubviews];
    }else{
        return;
    }
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUIView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame RollDirection:(RollDirection)rollDirection{
    self = [super initWithFrame:frame];
    if (self){
        self.pagePosition = PagePosition_None;
        if (rollDirection) {
            self.rollDirection = rollDirection;
        }else{
            self.rollDirection = RollDirection_Horizontal;
        }
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];

    }
    return self;
}
+ (instancetype)carouselViewWithFrame:(CGRect)frame RollDirection:(RollDirection)rollDirection{
    return [[self alloc] initWithFrame:frame RollDirection:rollDirection];
}
#pragma mark - 初始化
- (void)setUpUIView{
    self.rollDirection = RollDirection_Horizontal;
    self.pagePosition = PagePosition_None;
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

#pragma mark - 定时器相关
- (void)startTimer{
    if (self.dataArray.count <= 1) {
        return;
    }
    // 如果定时器是开始的，先停再开
    if (self.timer) {
        [self stopTimer];
    }
    self.timer = [NSTimer timerWithTimeInterval:self.time < 1? DEFAULTTIME : self.time target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)nextPage{
    if (self.rollDirection == RollDirection_Horizontal) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollViewWidth*3, 0) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollViewHeight*3) animated:YES];
    }
}
- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark - 分页控件相关
// 设置分页控件指示器的图片
- (void)setPageImage:(UIImage *)pageImage andCurrentImage:(UIImage *)currentImage{
    if (!pageImage || !currentImage){
        return;
    }
    self.pageImageSize = pageImage.size;
    [self.pageControl setValue:currentImage forKey:@"_currentPageImage"];
    [self.pageControl setValue:pageImage forKey:@"_pageImage"];
}
// 设置分页控件指示器的颜色
- (void)setPageColor:(UIColor *)color andCurrentPageColor:(UIColor *)currentColor{
    self.pageControl.pageIndicatorTintColor = color;
    //  设置当前页码指示器的颜色
    self.pageControl.currentPageIndicatorTintColor = currentColor;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    if (self.rollDirection == RollDirection_Horizontal) {
        [self changeCurrentPageWithOffset:offset.x];
        if (offset.x < self.scrollViewWidth * 2) {   //右滑
            self.nextView.frame = CGRectMake(self.scrollViewWidth, 0, self.scrollViewWidth, self.scrollViewHeight);

            self.nextIndex = self.currentIndex - 1;
            if (self.nextIndex < 0){
                self.nextIndex = self.dataArray.count - 1;
            }
            [self setDataForNextView];

            if (offset.x <= self.scrollViewWidth) {
                [self changeToNext];
            }
        } else if (offset.x > self.scrollViewWidth * 2){  //左滑
            self.nextView.frame = CGRectMake(CGRectGetMaxX(self.currentView.frame), 0, self.scrollViewWidth, self.scrollViewHeight);

            self.nextIndex = (self.currentIndex + 1) % self.dataArray.count;
            [self setDataForNextView];

            if (offset.x >= self.scrollViewWidth * 3) {
                [self changeToNext];
            }
        }
    }else{
        [self changeCurrentPageWithOffset:offset.y];
        if (offset.y < self.scrollViewHeight * 2) { //向下滑
            self.nextView.frame = CGRectMake(0, self.scrollViewHeight, self.scrollViewWidth, self.scrollViewHeight);
            self.nextIndex = self.currentIndex - 1;
            if (self.nextIndex < 0){
                self.nextIndex = self.dataArray.count - 1;
            }
            [self setDataForNextView];

            if (offset.y <= self.scrollViewHeight) {
                [self changeToNext];
            }
        } else if (offset.y > self.scrollViewHeight * 2){ //向上滑
            self.nextView.frame = CGRectMake(0, CGRectGetMaxY(self.currentView.frame), self.scrollViewWidth, self.scrollViewHeight);
            self.nextIndex = (self.currentIndex + 1) % self.dataArray.count;
            [self setDataForNextView];

            if (offset.y >= self.scrollViewHeight * 3) {
                [self changeToNext];
            }
        }
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}
#pragma mark 当图片滚动过半时就修改当前页码
- (void)changeCurrentPageWithOffset:(CGFloat)offset {
    if (_rollDirection == RollDirection_Horizontal) {
        if (offset < self.scrollViewWidth * 1.5) {
            NSInteger index = self.currentIndex - 1;
            if (index < 0){
                index = self.dataArray.count - 1;
            }
            _pageControl.currentPage = index;
        } else if (offset > self.scrollViewWidth * 2.5){
            _pageControl.currentPage = (self.currentIndex + 1) % self.dataArray.count;
        } else {
            _pageControl.currentPage = self.currentIndex;
        }
    }else{
        if (offset < self.scrollViewHeight * 1.5) {
            NSInteger index = self.currentIndex - 1;
            if (index < 0){
                index = self.dataArray.count - 1;
            }
            _pageControl.currentPage = index;
        } else if (offset > self.scrollViewHeight * 2.5){
            _pageControl.currentPage = (self.currentIndex + 1) % self.dataArray.count;
        } else {
            _pageControl.currentPage = self.currentIndex;
        }
    }
}
- (void)changeToNext{
    if (self.rollDirection == RollDirection_Horizontal) {
        self.scrollView.contentOffset = CGPointMake(self.scrollViewWidth * 2, 0);
    }else{
        self.scrollView.contentOffset = CGPointMake(0, self.scrollViewHeight * 2);
    }
    self.currentIndex = self.nextIndex;
    self.pageControl.currentPage = self.currentIndex;
    [self setDataForCurrentView];

}
#pragma mark - 点击scrollView
- (void)clickView{
    if (self.clickViewBlock) {
        self.clickViewBlock(self.currentIndex);
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickViewWithCurrentIndex:)]) {
            [self.delegate clickViewWithCurrentIndex:self.currentIndex];
        }
    }
}
#pragma mark - 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.pageControl.numberOfPages = self.dataArray.count;
    self.nextIndex = self.currentIndex+1;
    [self setUpPageControl];
    [self setUpSubViewOfScrollView];
    [self setDataForCurrentView];
    [self setDataForNextView];
    [self startTimer];
}
- (void)setUpPageControl{
    if (_pagePosition == PagePosition_Hidden) {
        self.pageControl.hidden = YES;
        return;
    }
    CGSize size;
    if (_pageImageSize.width == 0) { //没有设置图片
        size = [_pageControl sizeForNumberOfPages:_pageControl.numberOfPages];
        size.height = 20;
    } else {  //设置图片
        size = CGSizeMake(_pageImageSize.width * (_pageControl.numberOfPages * 2 - 1), _pageImageSize.height);
    }
    _pageControl.frame = CGRectMake(0, 0, size.width, size.height);
    if (_pagePosition == PagePosition_None || _pagePosition == PagePosition_BottomCenter){
        _pageControl.center = CGPointMake(self.scrollViewWidth/2, self.scrollViewHeight - size.height/2);
    }else if (_pagePosition == PagePosition_TopCenter){
        _pageControl.center = CGPointMake(self.scrollViewWidth/2, self.scrollViewHeight/2);
    }else if (_pagePosition == PagePosition_BottomLeft){
        _pageControl.frame = CGRectMake(Margin, self.scrollViewHeight - size.height, size.width, size.height);
    }else if (_pagePosition == PagePosition_BottomRight){
        _pageControl.frame = CGRectMake(self.scrollViewWidth - Margin - size.width, self.scrollViewHeight - size.height, size.width, size.height);
    }
}
- (void)setUpSubViewOfScrollView{
    if (self.dataArray.count > 1) {
        if (_rollDirection == RollDirection_Horizontal) {
            self.scrollView.contentSize = CGSizeMake(self.scrollViewWidth * 5, self.scrollViewHeight);
            self.scrollView.contentOffset = CGPointMake(self.scrollViewWidth * 2, 0);
            self.currentView.frame = CGRectMake(self.scrollViewWidth *2, 0, self.scrollViewWidth, self.scrollViewHeight);
        }else {
            self.scrollView.contentSize = CGSizeMake(self.scrollViewWidth, self.scrollViewHeight * 5);
            self.scrollView.contentOffset = CGPointMake(0, self.scrollViewHeight*2);
            self.currentView.frame = CGRectMake(0, self.scrollViewHeight*2, self.scrollViewWidth, self.scrollViewHeight);
        }
        
        self.nextView.frame = self.bounds;
    }else{
        self.scrollView.contentSize = CGSizeZero;
        self.scrollView.contentOffset = CGPointZero;
        self.currentView.frame = self.bounds;
    }
}

#pragma mark - 为子界面进行赋值
- (void)setDataForCurrentView{
    self.currentView.strData = self.dataArray[self.currentIndex];
}
- (void)setDataForNextView{
    self.nextView.strData = self.dataArray[self.nextIndex];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
