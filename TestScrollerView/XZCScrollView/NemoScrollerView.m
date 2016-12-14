//
//  NemoScrollerView.m
//  TestScrollerView
//
//  Created by Nemo on 16/2/17.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "NemoScrollerView.h"
#import "XZCScrollerButton.h"
#import "XZCScrollView.h"


#define rect [UIScreen mainScreen].bounds

@interface NemoScrollerView ()<UIScrollViewDelegate>
{
    CGFloat _y;
    BOOL isClick;
}
@property (nonatomic,strong) XZCScrollerButton *scroller;
@property (nonatomic,strong) XZCScrollView *scrollview;
@end

@implementation NemoScrollerView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createView];
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
-(void)createView{
    
    _scroller = [[XZCScrollerButton alloc] initWithFrame:CGRectMake(0, 0, rect.size.width,40)];
    
    _scroller.backgroundHeightLightColor = [UIColor whiteColor];
    _scroller.titlesHeightLightColor = [UIColor redColor];
    
    __weak typeof(self) ws = self;
    [_scroller setButtonClickBlock:^(NSInteger tag) {
        isClick = YES;
        [ws.scrollview setContentOffset:CGPointMake(tag*rect.size.width, 0) animated:NO];
    }];
    [self addSubview:_scroller];
    
    _y = CGRectGetHeight(_scroller.frame);
    _scrollview = [[XZCScrollView alloc] initWithFrame:CGRectMake(0, _y+2, rect.size.width, rect.size.height-_y-2)];
    _scrollview.pagingEnabled = YES;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.delegate = self;
    _scrollview.bounces = NO;
    [self addSubview:_scrollview];
}
-(void)setSelectPage:(NSInteger)selectPage
{
    _selectPage = selectPage;
    CGFloat x = 375*selectPage;
    isClick = YES;
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:3 animations:^{
        [ws.scroller setButtonPositionWithNumber:x];
    }];
    
    [_scrollview setContentOffset:CGPointMake(x, 0) animated:NO];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"%s",__func__);
    isClick = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%s%@",__func__,NSStringFromCGPoint(scrollView.contentOffset));
    if (isClick) return;
    [_scroller setButtonPositionWithNumber:scrollView.contentOffset.x];
}

-(void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = viewControllers;
    _scrollview.viewControllers = viewControllers;
}

-(void)layoutSubviews{

    [super layoutSubviews];

    _scroller.titles = self.titles;
    _scrollview.contentSize = CGSizeMake(self.titles.count*rect.size.width, _y);

}

@end
