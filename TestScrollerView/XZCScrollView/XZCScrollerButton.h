//
//  XZCScrollerButton.h
//  TestScrollerView
//
//  Created by Nemo on 16/1/9.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonOnClickBlock)(NSInteger tag, NSString * title);
typedef void(^ButtonClickBlock)(NSInteger tag);

@interface XZCScrollerButton : UIView

@property (nonatomic, strong) NSArray *titles;                      //标题数组
@property (nonatomic, strong) UIColor *titlesCustomeColor;          //标题的常规颜色
@property (nonatomic, strong) UIColor *titlesHeightLightColor;      //标题高亮颜色
@property (nonatomic, strong) UIColor *backgroundHeightLightColor;  //高亮时的颜色
@property (nonatomic, strong) UIFont *titlesFont;                   //标题的字号
@property (nonatomic, assign) CGFloat duration;                     //运动时间
@property (nonatomic, assign) NSInteger number;                     //每行的个数（默认5个）
@property (nonatomic, assign) CGFloat radiusBtn;                     //边框的圆角

-(void) setButtonOnClickBlock: (ButtonOnClickBlock) block;
-(void) setButtonClickBlock: (ButtonClickBlock) block;

-(void) setButtonPositionWithNumber:(CGFloat)position;

@end
