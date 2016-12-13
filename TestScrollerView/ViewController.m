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
@interface ViewController ()
@property (nonatomic,strong) UIScrollView *bottom;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
#warning 头部的button会受这个影响而且导致坐标不对
    self.navigationController.navigationBar.translucent = NO;
    
    NSArray *titles = @[@"消息",@"银行",@"尼莫",@"时光",@"KTV",@"通讯录",@"推荐",@"银行"];
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    NemoScrollerView *scroll = [[NemoScrollerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.size.width, SCREEN.size.height)];
    scroll.titles = titles;
    for (int i = 0; i < titles.count; i ++) {
        TestController *vc = [[TestController alloc] init];
        vc.text = titles[i];
        [views addObject:vc];
    }
    scroll.viewControllers = views;
    [self.view addSubview:scroll];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
