//
//  TestController.m
//  TestScrollerView
//
//  Created by Nemo on 16/2/19.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "TestController.h"



@interface TestController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation TestController

-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.tableView];
    
    [super viewDidLoad];
    
    self.view.backgroundColor = randomColor;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@%ld",self.text,indexPath.row];
    
    return cell;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN.size.width , SCREEN.size.height-64-40)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
