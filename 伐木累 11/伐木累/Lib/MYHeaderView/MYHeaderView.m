//
//  MYHeaderView.m
//  CYN_TBLX1
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 xiaoxiao. All rights reserved.
//

#import "MYHeaderView.h"

#import "UIImageView+WebCache.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MYHeaderView ()<UIScrollViewDelegate>

/** scrollView */
@property (nonatomic, strong)UIScrollView *HeaderScrollView;

/** 分页指示器 */
@property (nonatomic, strong) UIPageControl *HeaderPageControl;

/** 计时器 */
@property (nonatomic, strong) NSTimer *HeaderTimer;

@end

@implementation MYHeaderView

+(instancetype)HeaderView{
    
    MYHeaderView * headerview = [[MYHeaderView alloc]init];
    
    //添加scrollView
    [headerview HeaderScrollView];
    
    // 设置header的frame
    headerview.frame = CGRectMake(0, 0, WIDTH, CGRectGetMaxY(headerview.HeaderScrollView.frame));
    
    return headerview;
}

/** scrollView */
-(UIScrollView *)HeaderScrollView{
    
    if (!_HeaderScrollView) {
        
        _HeaderScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH * 188 / 375.f)];
        //一次显示一张图片
        _HeaderScrollView.pagingEnabled = YES;
        //隐藏横向滚动条
        _HeaderScrollView.showsHorizontalScrollIndicator = NO;
        //设置代理
        _HeaderScrollView.delegate = self;
        
        [self addSubview:_HeaderScrollView];
    }
    return _HeaderScrollView;
}

/** 分页指示器 */
- (UIPageControl *)HeaderPageControl {
    
    if (!_HeaderPageControl) {
        
        _HeaderPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.HeaderScrollView.frame) - 30, WIDTH, 20)];
        
        [self addSubview:_HeaderPageControl];
    }
    return _HeaderPageControl;
}

-(void)setImages:(NSArray *)images{
    
    // 暂停原来计时器
    [self.HeaderTimer setFireDate:[NSDate distantFuture]];
    
    _images = images;
    
    //移除原来的scrollView上的视图
    for (UIView * subView in self.HeaderScrollView.subviews) {
        
        [subView removeFromSuperview];
    }
    // 然后再添加新的视图
    for (int i = 0; i < images.count + 2; i++) {
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, CGRectGetHeight(self.HeaderScrollView.frame))];
        
        NSString * pathImage = nil;
        
        if (i == 0) {
            pathImage = images.lastObject;
        }
        else if (i == images.count + 1){
            pathImage = images.firstObject;
        }
        else{
            pathImage = images[i-1];
        }
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:pathImage] placeholderImage:nil];
        
        [self.HeaderScrollView addSubview:imageView];
        
        self.HeaderScrollView.contentSize = CGSizeMake(CGRectGetMaxX(imageView.frame), 0);
    }
    // 设置pageControl
    [self bringSubviewToFront:self.HeaderPageControl];
    //设置圈的个数
    self.HeaderPageControl.numberOfPages = images.count;
    //设置底圈颜色
    self.HeaderPageControl.pageIndicatorTintColor = [UIColor redColor];
    //设置跳转圈颜色
    self.HeaderPageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    //设置第一次进来圈的位置
    self.HeaderPageControl.currentPage = 0;
    //设置第一次进来图片的位置
    [self.HeaderScrollView setContentOffset:CGPointMake(WIDTH, 0)];
    
    // 启动计时器自动滚屏
    [self.HeaderTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3.5]];
}

/** 减速完成(停止) */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setPageAndCircleWithScrollView:scrollView];
}

/** setContnetOffSet: animated:YES , 动画完成之后, 不会走减速的方法, 而是走这个方法 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self setPageAndCircleWithScrollView:scrollView];
}

/** 设置循环滚动与页码 */
- (void)setPageAndCircleWithScrollView:(UIScrollView *)scrollView {
    //计算第几张
    NSInteger page = scrollView.contentOffset.x / WIDTH;
    
    if (page == 0) {
        [scrollView setContentOffset:CGPointMake(WIDTH * (self.images.count), 0) animated:NO];
        self.HeaderPageControl.currentPage = self.images.count - 1;
    }
    else if (page == self.images.count + 1) {
        [scrollView setContentOffset:CGPointMake(WIDTH, 0) animated:NO];
        self.HeaderPageControl.currentPage = 0;
    }
    else {
        self.HeaderPageControl.currentPage = page - 1;
    }
}

#pragma mark ------- 计时器相关 --------
- (NSTimer *)HeaderTimer {
    
    if (!_HeaderTimer) {
        
        _HeaderTimer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        
        [_HeaderTimer setFireDate:[NSDate distantFuture]];
    }
    return _HeaderTimer;
}

- (void)timerAction {
    
    [self.HeaderScrollView setContentOffset:CGPointMake(self.HeaderScrollView.contentOffset.x + WIDTH, 0) animated:YES];
}



@end
