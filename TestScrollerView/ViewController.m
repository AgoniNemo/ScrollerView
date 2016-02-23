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
    
    NSArray *titles = @[@"推荐",@"银行",@"尼莫",@"最强",@"好哟",@"小互",@"视频",@"笑点",@"手枪",@"手枪",@"无语"];
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    NemoScrollerView *scroll = [[NemoScrollerView alloc] initWithFrame:self.view.bounds];
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
