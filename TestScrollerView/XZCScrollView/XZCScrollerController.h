//
//  XZCScrollerController.h
//  TestScrollerView
//
//  Created by Mjwon on 2016/12/14.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZCScrollerController : UIViewController

@property (nonatomic) NSArray *titles;

@property (nonatomic,strong) NSArray *viewControllers;

@property (nonatomic,assign) CGFloat lineHeight;

@property (nonatomic,strong) UIColor *lineColor;

@property (nonatomic,assign) CGFloat textFont;

@property (nonatomic,strong) UIColor *textColor;

@property (nonatomic ,assign) NSInteger selectPage;

@end
