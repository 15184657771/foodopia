//
//  SleepErectView.m
//  BlueTooth
//
//  Created by Chen on 2018/5/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "SleepErectView.h"

@interface SleepErectView()

@property (nonatomic,strong) CAShapeLayer *lineLayer;
@property (nonatomic,strong) CAShapeLayer *percentLineLayer;

@property (nonatomic,strong) NSMutableArray *verticalDayArray;
@property (nonatomic,strong) NSMutableArray *horizontalValueArray;

@property (nonatomic,strong) UILabel *showLabel;
@property (nonatomic,strong) UIImageView *showImageView;

@end

@implementation SleepErectView

- (NSMutableArray *)verticalDayArray {
    if (!_verticalDayArray) {
        _verticalDayArray = [NSMutableArray array];
    }
    return _verticalDayArray;
}
- (NSMutableArray *)horizontalValueArray {
    if (!_horizontalValueArray) {
        _horizontalValueArray = [NSMutableArray array];
    }
    return _horizontalValueArray;
}


- (UILabel *)showLabel {
    if (!_showLabel) {
        _showLabel = [[UILabel alloc] init];
        [_showLabel setBackgroundColor:[UIColor clearColor]];
        [_showLabel setTextAlignment:NSTextAlignmentCenter];
        _showLabel.numberOfLines = 0;
        _showLabel.hidden = YES;
    }
    return _showLabel;
}

- (UIImageView *)showImageView {
    if (!_showImageView) {
        _showImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qipao"]];
        _showImageView.hidden = YES;
    }
    return _showImageView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initValueAndView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initValueAndView];
    }
    return self;
}

- (void)initValueAndView {
    self.maxValue = 0;
    self.backgroundColor = RGB(250, 250, 250);
    WS(ws);
    [self addSubview:self.showImageView];
    [self addSubview:self.showLabel];
    
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.showLabel.mas_centerX);
        make.top.equalTo(ws.showLabel.mas_top).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(75,42));
    }];
    [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.left.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(75,32));
    }];
    
    if (self.horizontalValueArray.count > 0) {
        [self.layer addSublayer:self.lineLayer];
        [self.layer addSublayer:self.percentLineLayer];
    }
}

- (CAShapeLayer *)lineLayer {
    if (!_lineLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200 * HeightNum);
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = RGBA(191, 140, 219, 0.25).CGColor;
        layer.lineWidth = 1;
        layer.lineJoin = kCALineJoinRound;
        layer.lineDashPattern = @[@4,@4];
        UIBezierPath *path = [UIBezierPath bezierPath];
        if (self.horizontalValueArray.count == 1) {
            [path moveToPoint:CGPointMake(SCREEN_WIDTH/2, 16 * HeightNum)];
            [path addLineToPoint:CGPointMake(SCREEN_WIDTH/2, 200 * HeightNum)];
        } else {
            CGFloat everyX = 295 * WidthNum / (self.horizontalValueArray.count - 1);
            CGFloat edgX = 40 * WidthNum;
            for (int i = 0; i < self.horizontalValueArray.count; i ++) {
                [path moveToPoint:CGPointMake(edgX + everyX * i, 16 * HeightNum)];
                [path addLineToPoint:CGPointMake(edgX + everyX * i, 200 * HeightNum)];
            }
        }
        layer.path = path.CGPath;
        _lineLayer = layer;
    }
    return _lineLayer;
    
}

- (CAShapeLayer *)percentLineLayer {
    if (!_percentLineLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200 * HeightNum);
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = RGB(224, 184, 255).CGColor;
        layer.lineWidth = 10;
        layer.lineCap = kCALineCapRound;
        UIBezierPath *path = [UIBezierPath bezierPath];
        if (self.horizontalValueArray.count == 1) {
            CGFloat value = [self.horizontalValueArray[0] floatValue] > self.maxValue?self.maxValue : [self.horizontalValueArray[0] floatValue];
            [path moveToPoint:CGPointMake(SCREEN_WIDTH/2, 200 * HeightNum)];
            [path addLineToPoint:CGPointMake(SCREEN_WIDTH/2, (25 + (value/self.maxValue) * 175) * HeightNum)];
        } else {
            CGFloat everyX = 295 * WidthNum / (self.horizontalValueArray.count - 1);
            CGFloat edgX = 40 * WidthNum;
            for (int i = 0; i < self.horizontalValueArray.count; i ++) {
                CGFloat value = [self.horizontalValueArray[i] floatValue] > self.maxValue?self.maxValue : [self.horizontalValueArray[i] floatValue];
                [path moveToPoint:CGPointMake(edgX + everyX * i, 200 * HeightNum)];
                [path addLineToPoint:CGPointMake(edgX + everyX * i, (200 - (value/self.maxValue) * 175) * HeightNum)];
            }
        }
        layer.path = path.CGPath;
        _percentLineLayer = layer;
    }
    return _percentLineLayer;
    
}

- (void)setVerticalDaySource:(NSArray *)dayArray horizontalValueArray:(NSArray *)valueArray {
    self.showLabel.hidden = YES;
    self.showImageView.hidden = YES;
    if (dayArray.count == valueArray.count) {
        [self.verticalDayArray removeAllObjects];
        [self.horizontalValueArray removeAllObjects];
        if (dayArray.count > 7) {
            for (int i = 7; i >= 1; i--) {
                [self.verticalDayArray addObject:dayArray[dayArray.count - i]];
                [self.horizontalValueArray addObject:valueArray[dayArray.count - i]];
            }
        } else {
            [self.verticalDayArray addObjectsFromArray:dayArray];
            [self.horizontalValueArray addObjectsFromArray:valueArray];
        }
        
    }
}

- (void)show {
    [self.lineLayer removeFromSuperlayer];
    [self.percentLineLayer removeFromSuperlayer];
    self.lineLayer = nil;
    self.percentLineLayer = nil;
    if (self.horizontalValueArray.count > 0) {
        [self.layer addSublayer:self.lineLayer];
        [self.layer addSublayer:self.percentLineLayer];
    }
    [self.layer setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect {
    CGFloat everyX = 295 * WidthNum / (self.horizontalValueArray.count - 1);
    CGFloat edgX = 40 * WidthNum;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:10 * HeightNum], NSForegroundColorAttributeName:RGB(191, 191, 191)};
    for (int i = 0; i < self.verticalDayArray.count; i++) {
        CGSize statuseStrSize = [[NSString stringWithFormat:@"%@",self.verticalDayArray[i]] sizeWithAttributes:attribute];//计算字数宽度
        [self.verticalDayArray[i] drawAtPoint:CGPointMake(edgX + everyX * i - statuseStrSize.width/2, 3 * HeightNum) withAttributes:attribute];
    }
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    float x = point.x;
    CGFloat everyX = 295 * WidthNum / (self.horizontalValueArray.count - 1);
    CGFloat edgeX = 40 * WidthNum;
    NSInteger num = (x - edgeX + everyX / 2) / everyX;
    
    CGFloat value = [self.horizontalValueArray[num] floatValue] > self.maxValue?self.maxValue : [self.horizontalValueArray[num] floatValue];
    CGFloat selectpointY = (200 - (value/self.maxValue) * 175) * HeightNum;
    if ([_delegate respondsToSelector:@selector(tapShowNum:)]) {
        [_delegate tapShowNum:self.horizontalValueArray[num]];
    }
    WS(ws);
    self.showLabel.hidden = NO;
    self.showImageView.hidden = NO;
    
    CGFloat pointX = num * everyX + edgeX;
    
    [self.showLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.mas_left).with.offset(pointX);
        make.bottom.equalTo(ws.mas_top).with.offset(selectpointY - 25 * HeightNum);
        make.size.mas_equalTo(CGSizeMake(78,22));
    }];
    [self.showImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.showLabel.mas_centerX);
        make.centerY.equalTo(ws.showLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(78,42));
    }];
    [self bringSubviewToFront:self.showImageView];
    [self bringSubviewToFront:self.showLabel];
    
}

- (void)setText:(NSString *)str andLast:(NSString *)danweiStr{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@h%@min",str,danweiStr]];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12]
                    range:NSMakeRange(0, [attrStr length])];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16]
                    range:NSMakeRange(0, [str length])];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16]
                    range:NSMakeRange([str length] + 1, [danweiStr length])];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [attrStr length])]; //设置字体颜色
    self.showLabel.attributedText = attrStr;
}

@end
