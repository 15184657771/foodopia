//
//  MainView.m
//  BlueTooth
//
//  Created by Chen on 2018/3/11.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "MainView.h"

@interface MainView()

@property (nonatomic,strong) CAShapeLayer *lineLayer;
@property (nonatomic,strong) CAShapeLayer *dottedLineLayer;

@end

@implementation MainView

- (CAShapeLayer *)lineLayer {
    if (!_lineLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor whiteColor].CGColor;
        layer.lineWidth = 10;
        layer.lineJoin = kCALineJoinRound;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 60 * HeightNum)];
        [path addLineToPoint:CGPointMake(120 * WidthNum, 60 * HeightNum)];
        [path addQuadCurveToPoint:CGPointMake(140 * WidthNum, 80 * HeightNum) controlPoint:CGPointMake(140 * WidthNum, 60 * HeightNum)];
        [path addLineToPoint:CGPointMake(140 * WidthNum, 210 * HeightNum)];
        [path addQuadCurveToPoint:CGPointMake(160 * WidthNum, 230 * HeightNum) controlPoint:CGPointMake(140 * WidthNum, 230 * HeightNum)];
        [path addLineToPoint:CGPointMake(270 * WidthNum, 230 * HeightNum)];
        [path addQuadCurveToPoint:CGPointMake(290 * WidthNum, 250 * HeightNum) controlPoint:CGPointMake(290 * WidthNum, 230 * HeightNum)];
        [path addLineToPoint:CGPointMake(290 * WidthNum, 380 * HeightNum)];
        [path addQuadCurveToPoint:CGPointMake(270 * WidthNum, 400 * HeightNum) controlPoint:CGPointMake(290 * WidthNum, 400 * HeightNum)];
        [path addLineToPoint:CGPointMake(100 * WidthNum, 400 * HeightNum)];
        [path addQuadCurveToPoint:CGPointMake(80 * WidthNum, 420 * HeightNum) controlPoint:CGPointMake(80 * WidthNum, 400 * HeightNum)];
        [path addLineToPoint:CGPointMake(80 * WidthNum, 540 * HeightNum)];
        [path addQuadCurveToPoint:CGPointMake(100 * WidthNum, 560 * HeightNum) controlPoint:CGPointMake(80 * WidthNum, 560 * HeightNum)];
        [path addLineToPoint:CGPointMake(375 * WidthNum, 560 * HeightNum)];
        layer.path = path.CGPath;
        _lineLayer = layer;
    }
    return _lineLayer;
}

- (CAShapeLayer *)dottedLineLayer {
    if (!_dottedLineLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = RGB(255, 214, 73).CGColor;
        layer.lineWidth = 1;
        layer.lineJoin = kCALineJoinRound;
        layer.lineDashPattern = @[@5,@5];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 60 * HeightNum)];
        [path addLineToPoint:CGPointMake(120 * WidthNum, 60 * HeightNum)];
        [path addQuadCurveToPoint:CGPointMake(140 * WidthNum, 80 * HeightNum) controlPoint:CGPointMake(140 * WidthNum, 60 * HeightNum)];
        [path addLineToPoint:CGPointMake(140 * WidthNum, 210 * HeightNum)];
        [path addQuadCurveToPoint:CGPointMake(160 * WidthNum, 230 * HeightNum) controlPoint:CGPointMake(140 * WidthNum, 230 * HeightNum)];
        [path addLineToPoint:CGPointMake(270 * WidthNum, 230 * HeightNum)];
        [path addQuadCurveToPoint:CGPointMake(290 * WidthNum, 250 * HeightNum) controlPoint:CGPointMake(290 * WidthNum, 230 * HeightNum)];
        [path addLineToPoint:CGPointMake(290 * WidthNum, 380 * HeightNum)];
        [path addQuadCurveToPoint:CGPointMake(270 * WidthNum, 400 * HeightNum) controlPoint:CGPointMake(290 * WidthNum, 400 * HeightNum)];
        [path addLineToPoint:CGPointMake(100 * WidthNum, 400 * HeightNum)];
        [path addQuadCurveToPoint:CGPointMake(80 * WidthNum, 420 * HeightNum) controlPoint:CGPointMake(80 * WidthNum, 400 * HeightNum)];
        [path addLineToPoint:CGPointMake(80 * WidthNum, 540 * HeightNum)];
        [path addQuadCurveToPoint:CGPointMake(100 * WidthNum, 560 * HeightNum) controlPoint:CGPointMake(80 * WidthNum, 560 * HeightNum)];
        [path addLineToPoint:CGPointMake(375 * WidthNum, 560 * HeightNum)];
        layer.path = path.CGPath;
        _dottedLineLayer = layer;
    }
    return _dottedLineLayer;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

- (void)creatView {
    [self setBackgroundColor:[UIColor yellowColor]];
    [self.layer addSublayer:self.lineLayer];
    [self.layer addSublayer:self.dottedLineLayer];

}

@end
