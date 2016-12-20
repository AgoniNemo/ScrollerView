//
//  NemoScrollerView.h
//  TestScrollerView
//
//  Created by Nemo on 16/2/17.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NemoScrollerView : UIView

@property (nonatomic) NSArray *titles;

@property (nonatomic,strong) UIViewController *viewController;

@property (nonatomic,strong) NSArray *viewControllers;

@property (nonatomic,assign) CGFloat lineHeight;

@property (nonatomic,strong) UIColor *lineColor;

@property (nonatomic,assign) CGFloat textFont;

@property (nonatomic,strong) UIColor *textColor;

@property (nonatomic ,assign) NSInteger selectPage;

@end
