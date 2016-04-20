//
//  TestController.h
//  TestScrollerView
//
//  Created by Nemo on 16/2/19.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define SCREEN [UIScreen mainScreen].bounds

#define randomColor GMColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface TestController : UIViewController

@end
