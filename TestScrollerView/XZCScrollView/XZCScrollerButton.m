//
//  XZCScrollerButton.m
//  TestScrollerView
//
//  Created by Nemo on 16/1/9.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import "XZCScrollerButton.h"
#import "UIView+Extension.h"

#define rect [UIScreen mainScreen].bounds

#define DEFAULT_TITLES_FONT 16.0f
#define DEFAULT_DURATION .7f
#define NUMBER 4

@interface XZCScrollerButton ()<UIScrollViewDelegate>
{
    NSInteger _count;
    NSInteger _tag;
}
@property (nonatomic, assign) CGFloat viewWidth;                    //组件的宽度
@property (nonatomic, assign) CGFloat viewHeight;                   //组件的高度
@property (nonatomic, assign) CGFloat labelWidth;                   //Label的宽度

@property (nonatomic, strong) UIView * heightLightView;
@property (nonatomic, strong) UIView * heightTopView;
@property (nonatomic, strong) UIView * heightColoreView;
@property (nonatomic, strong) UIView * bottomLine;
@property (nonatomic, strong) NSMutableArray * labelMutableArray;
@property (nonatomic, strong) ButtonOnClickBlock buttonBlock;
@property (nonatomic, strong) ButtonClickBlock buttonClick;
@property (nonatomic, strong) UIScrollView *bottom;
@end

@implementation XZCScrollerButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _viewWidth = frame.size.width;
        _viewHeight = frame.size.height;
        _duration = DEFAULT_DURATION;
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _tag = (_titles.count >= 5) ? 5 : _titles.count;
    [self customeData];
    [self createBottomLabels];
    [self createTopLables];
    [self createTopButtons];
}

-(void) setButtonPositionWithNumber:(CGFloat)position{

    _bottomLine.x = position/_tag;
    _heightLightView.x = position/_tag;
    _heightTopView.x = -(position/_tag);
    
    [self scrollAnimation:position/rect.size.width completion:^(BOOL finished) {
        
    }];
}

-(void) setButtonOnClickBlock: (ButtonOnClickBlock) block {
    if (block) {
        _buttonBlock = block;
    }
}

-(void) setButtonClickBlock:(ButtonClickBlock)block{
    if (block) {
        _buttonClick = block;
    }
}
-(void)scrollAnimation:(NSInteger)tag completion:(void (^ __nullable)(BOOL finished))completion{

//    NSLog(@"%ld---count:%ld",tag,_count);
    
    CGPoint point = CGPointMake(0, 0);
    
    if (_count-(tag+1) >= 2 && tag >= 3) {
        
        point = CGPointMake(((tag+1)-3)*_labelWidth, 0);
        
//        NSLog(@"tag:%ld",tag);
    }else{
        if (tag > 5) {
            return;
        }
    }
    [_bottom setContentOffset:point animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion(YES);
    });
    
}

/**
 *  提供默认值
 */
- (void)customeData {
    if (_titles == nil) {
        _titles = @[@"Test0", @"Test1", @"Test2"];
    }
    
    if (_titlesCustomeColor == nil) {
        _titlesCustomeColor = [UIColor blackColor];
    }
    
    if (_titlesHeightLightColor == nil) {
        _titlesHeightLightColor = [UIColor whiteColor];
    }
    
    if (_backgroundHeightLightColor == nil) {
        _backgroundHeightLightColor = [UIColor redColor];
    }
    
    if (_titlesFont == nil) {
        _titlesFont = [UIFont systemFontOfSize:DEFAULT_TITLES_FONT];
    }
    
    if (_labelMutableArray == nil) {
        _labelMutableArray = [[NSMutableArray alloc] initWithCapacity:_titles.count];
    }
    _count = _titles.count;
    
    _labelWidth = _viewWidth / _count;
    
    [self addSubview:self.bottom];
    
    if (_titles.count > NUMBER) {
        _labelWidth = _viewWidth / (NUMBER+1);
    }
    self.bottom.contentSize = CGSizeMake(_labelWidth*_count, 0);
}

/**
 *  计算当前高亮的Frame
 *
 *  @param index 当前点击按钮的Index
 *
 *  @return 返回当前点击按钮的Frame
 */
- (CGRect) countCurrentRectWithIndex: (NSInteger) index {
    
    return  CGRectMake(_labelWidth * index, 0, _labelWidth, _viewHeight);
}

/**
 *  根据索引创建Label
 *
 *  @param index     创建的第几个Index
 *  @param textColor Label字体颜色
 *
 *  @return 返回创建好的label
 */
- (UILabel *) createLabelWithTitlesIndex: (NSInteger) index
                               textColor: (UIColor *) textColor {
    CGRect currentLabelFrame = [self countCurrentRectWithIndex:index];
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:currentLabelFrame];
    tempLabel.textColor = textColor;
    tempLabel.text = _titles[index];
    tempLabel.font = _titlesFont;
    tempLabel.minimumScaleFactor = 0.1f;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    return tempLabel;
}

/**
 *  创建最底层的Label
 */
- (void) createBottomLabels {
    for (int i = 0; i < _titles.count; i ++) {
        UILabel *tempLabel = [self createLabelWithTitlesIndex:i textColor:_titlesCustomeColor];
        [self.bottom addSubview:tempLabel];
        [_labelMutableArray addObject:tempLabel];
        
    }
}

/**
 *  创建上一层高亮使用的Label
 */
- (void) createTopLables {
    //label层上的view
    CGRect heightLightViewFrame = CGRectMake(0, 0, _labelWidth, _viewHeight);
    _heightLightView = [[UIView alloc] initWithFrame:heightLightViewFrame];
#warning 设置超出_heightLightView的子VIEW不显示
    _heightLightView.clipsToBounds = YES;
    
    //动画元素
    _heightColoreView = [[UIView alloc] initWithFrame:heightLightViewFrame];
    _heightColoreView.backgroundColor = _backgroundHeightLightColor;
    _heightColoreView.layer.cornerRadius = 20;
    [_heightLightView addSubview:_heightColoreView];
    
    _heightTopView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, _viewWidth, _viewHeight)];
    
    
    for (int i = 0; i < _titles.count; i ++) {
        UILabel *label = [self createLabelWithTitlesIndex:i textColor:_titlesHeightLightColor];
        
//        NSLog(@"NSStringFromCG:%@",NSStringFromCGRect(label.frame));
        [_heightTopView addSubview:label];
    }
    [_heightLightView addSubview:_heightTopView];
    
    [self.bottom addSubview:_heightLightView];
}

/**
 *  创建按钮
 */
- (void) createTopButtons {
    for (int i = 0; i < _titles.count; i ++) {
        CGRect tempFrame = [self countCurrentRectWithIndex:i];
        UIButton *tempButton = [[UIButton alloc] initWithFrame:tempFrame];
        tempButton.tag = i;
        [tempButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottom addSubview:tempButton];
    }
    _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _viewHeight, _labelWidth, 2)];
    _bottomLine.backgroundColor = [UIColor redColor];
    [self.bottom addSubview:_bottomLine];
    
}

/**
 *  点击按钮事件
 *
 *  @param sender 点击的相应的按钮
 */
- (void)tapButton:(UIButton *) sender {
    
    if (_buttonBlock && sender.tag < _titles.count) {
        _buttonBlock(sender.tag, _titles[sender.tag]);
    }
    
    if (_buttonClick && sender.tag < _titles.count) {
        _buttonClick(sender.tag);
    }
    
    
    
    CGRect frame = [self countCurrentRectWithIndex:sender.tag];
    CGRect changeFrame = [self countCurrentRectWithIndex:-sender.tag];
    
    __weak typeof(self) weak_self = self;
    [UIView animateWithDuration:_duration animations:^{
        _heightLightView.frame = frame;
        _heightTopView.frame = changeFrame;
        _bottomLine.frame = CGRectMake(sender.tag*_labelWidth, _viewHeight, _labelWidth, 2);
    } completion:^(BOOL finished) {
//        [weak_self shakeAnimationForView:_heightColoreView];
#warning 给bottom加后动画效果快速点击会出现闪现,后期处理
        [weak_self scrollAnimation:sender.tag completion:^(BOOL finished) {
            [weak_self shakeAnimationForView:_bottomLine];
        }];
    }];
}

-(UIScrollView *)bottom
{
    if (_bottom == nil) {
        _bottom = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height+2)];
        _bottom.showsHorizontalScrollIndicator = NO;
        _bottom.delegate = self;
    }
    return _bottom;
}

/**
 *  抖动效果
 *
 *  @param view 要抖动的view
 */
- (void)shakeAnimationForView:(UIView *) view {
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    NSLog(@"position:%@",NSStringFromCGPoint(position));
    CGPoint x = CGPointMake(position.x + 1, position.y);
    CGPoint y = CGPointMake(position.x - 1, position.y);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:.06];
    [animation setRepeatCount:3];
    [viewLayer addAnimation:animation forKey:nil];
}

@end
