//
//  XZCScrollerController.m
//  TestScrollerView
//
//  Created by Mjwon on 2016/12/14.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "XZCScrollerController.h"
#import "XZCScrollerButton.h"
#import "XZCScrollView.h"


#define rect [UIScreen mainScreen].bounds

@interface XZCScrollerController ()<UIScrollViewDelegate>
{
    CGFloat _y;
    BOOL isClick;
}
@property (nonatomic,strong) XZCScrollerButton *scroller;
@property (nonatomic,strong) XZCScrollView *scrollview;

@end

@implementation XZCScrollerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
     self.title = self.titles[0];
    
    [self createView];
}

-(void)createView{
    
    NSLog(@"%@",self.navigationController.viewControllers);
    NSLog(@"%@",self.titles);
    
    _scroller = [[XZCScrollerButton alloc] initWithFrame:CGRectMake(0, 0, rect.size.width,40)];
    _scroller.titles = self.titles;
    _scroller.backgroundHeightLightColor = [UIColor whiteColor];
    _scroller.titlesHeightLightColor = [UIColor redColor];
    
    __weak typeof(self) ws = self;
    [_scroller setButtonClickBlock:^(NSInteger tag) {
        isClick = YES;
        ws.title = ws.titles[tag];
        [ws.scrollview setContentOffset:CGPointMake(tag*rect.size.width, 0) animated:NO];
    }];
    [self.view addSubview:_scroller];
    
   
    [self.view addSubview:self.scrollview];
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
    
    if (isClick) return;
    
    [_scroller setButtonPositionWithNumber:scrollView.contentOffset.x];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%s%@",__func__,NSStringFromCGPoint(scrollView.contentOffset));
    
    NSInteger i = scrollView.contentOffset.x/rect.size.width;
    self.title = self.titles[i];
}

-(void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = viewControllers;
    
}

-(XZCScrollView *)scrollview
{
    if (_scrollview == nil) {
        _y = CGRectGetHeight(_scroller.frame);
        _scrollview = [[XZCScrollView alloc] initWithFrame:CGRectMake(0, _y+2, rect.size.width, rect.size.height-_y-2)];
        _scrollview.pagingEnabled = YES;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.delegate = self;
        _scrollview.bounces = NO;
        _scrollview.contentSize = CGSizeMake(self.titles.count*rect.size.width, _y);
        _scrollview.viewControllers = self.viewControllers;
    }
    
    return _scrollview;
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
