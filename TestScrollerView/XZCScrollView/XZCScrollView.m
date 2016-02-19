//
//  XZCScrollView.m
//  TestScrollerView
//
//  Created by Nemo on 16/2/19.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "XZCScrollView.h"

#define GMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define randomColor GMColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface XZCScrollView ()

@end


@implementation XZCScrollView

-(void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = viewControllers;
    
    for (int i = 0; i < viewControllers.count; i ++) {
        
        UIViewController *vc = viewControllers[i];
        vc.view.frame = CGRectMake(i*375, 0, self.bounds.size.width, self.bounds.size.height);
        [self addSubview:vc.view];
    }
}



@end
