//
//  NemoSrollerController.m
//  TestScrollerView
//
//  Created by Nemo on 16/4/21.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "NemoSrollerController.h"
#import "XZCScrollerButton.h"
#import "XZCScrollView.h"


#define rect [UIScreen mainScreen].bounds

@interface NemoSrollerController ()<UIScrollViewDelegate>
{
    CGFloat _y;
    BOOL isClick;
}
@property (nonatomic,strong) XZCScrollerButton *scroller;
@property (nonatomic,strong) XZCScrollView *scrollview;
@end

@implementation NemoSrollerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];

    NSLog(@"%@",self.viewControllers);
}

-(void)setIndex:(NSInteger)index
{
    _index = index;
    
}

-(void)createView{
    
    self.scroller.titles = self.titles;
    __weak typeof(self) ws = self;
    [self.scroller setButtonClickBlock:^(NSInteger tag) {
        isClick = YES;
        [ws.scrollview setContentOffset:CGPointMake(tag*rect.size.width, 0) animated:YES];
        if (ws.selectAction) {
            ws.selectAction();
        }
    }];
    [self.view addSubview:self.scroller];
    
    _y = 20+CGRectGetHeight(_scroller.frame);
    _scrollview = [[XZCScrollView alloc] initWithFrame:CGRectMake(0, _y+2, rect.size.width, rect.size.height-_y-2)];
    _scrollview.pagingEnabled = YES;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.delegate = self;
    _scrollview.bounces = NO;
    _scrollview.contentSize = CGSizeMake(self.titles.count*rect.size.width, _y);
//    [self.view addSubview:_scrollview];
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    NSLog(@"%s",__func__);
    isClick = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    NSLog(@"%s%@",__func__,NSStringFromCGPoint(scrollView.contentOffset));
    if (isClick) return;
    [_scroller setButtonPositionWithNumber:scrollView.contentOffset.x];
}

-(void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = viewControllers;
    _scrollview.viewControllers = viewControllers;
}

-(XZCScrollerButton *)scroller
{
    if (_scroller == nil) {
        _scroller = [[XZCScrollerButton alloc] initWithFrame:CGRectMake(0, 64, rect.size.width,30)];
        _scroller.backgroundHeightLightColor = [UIColor whiteColor];
        _scroller.titlesHeightLightColor = [UIColor redColor];
    }
    return _scroller;
}


@end
