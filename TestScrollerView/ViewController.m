//
//  ViewController.m
//  TestScrollerView
//
//  Created by Nemo on 16/1/9.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "ViewController.h"
#import "NemoScrollerView.h"
#import "TestController.h"
#import "NemoSrollerController.h"
#import "XZCScrollerController.h"

@interface ViewController ()
{
    NSInteger indext;
}
@property (nonatomic,strong) UIScrollView *bottom;
@property (nonatomic,strong) NemoScrollerView *scroll;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    indext = 0;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = item;
    
    
    XZCScrollerController *vc = [[XZCScrollerController alloc] init];
    NSArray *titles = @[@"消息",@"银行",@"尼莫",@"时光",@"KTV",@"通讯录",@"推荐",@"银行"];
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < titles.count; i ++) {
        TestController *vc = [[TestController alloc] init];
        vc.text = titles[i];
        [views addObject:vc];
    }
    vc.viewControllers = views;
    vc.titles = titles;
    [self.navigationController pushViewController:vc animated:YES];
    
//    [self create];
}

-(void)create{

#warning 头部的button会受这个影响而且导致坐标不对
    self.navigationController.navigationBar.translucent = NO;
    
    NSArray *titles = @[@"消息",@"银行",@"尼莫",@"时光",@"KTV",@"通讯录",@"推荐",@"银行"];
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    _scroll = [[NemoScrollerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.size.width, SCREEN.size.height)];
    _scroll.titles = titles;
    for (int i = 0; i < titles.count; i ++) {
        TestController *vc = [[TestController alloc] init];
        vc.text = titles[i];
        [views addObject:vc];
    }
    _scroll.viewControllers = views;
    [self.view addSubview:_scroll];

}

-(void)leftAction{

    NSLog(@"%s",__func__);
    indext ++;
    
    _scroll.selectPage = indext;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
