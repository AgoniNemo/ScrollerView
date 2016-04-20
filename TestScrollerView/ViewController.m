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

@interface ViewController ()
@property (nonatomic,strong) UIScrollView *bottom;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.hidesBottomBarWhenPushed = YES;
    
    NSArray *titles = @[@"推荐",@"银行",@"尼莫",@"尼莫",@"推荐",@"银行",@"推荐",@"银行"];
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    NemoScrollerView *scroll = [[NemoScrollerView alloc] initWithFrame:CGRectMake(0, 64, SCREEN.size.width, SCREEN.size.height-64)];
    scroll.titles = titles;
    for (int i = 0; i < titles.count; i ++) {
        TestController *vc = [[TestController alloc] init];
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
