//
//  NemoSrollerController.h
//  TestScrollerView
//
//  Created by Nemo on 16/4/21.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^titleClick)();

@interface NemoSrollerController : UIViewController

@property (nonatomic) NSArray *titles;

@property (nonatomic,strong) NSArray *viewControllers;

@property (nonatomic,copy) titleClick selectAction;

@end
