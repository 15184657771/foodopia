//
//  ErectView.m
//  BlueTooth
//
//  Created by Chen on 2018/4/16.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "ErectView.h"

@interface ErectView()

@property (nonatomic,strong) CAShapeLayer *lineLayer;
@property (nonatomic,strong) CAShapeLayer *percentLineLayer;

@property (nonatomic,strong) NSMutableArray *verticalDayArray;
@property (nonatomic,strong) NSMutableArray *horizontalValueArray;


@end

@implementation ErectView

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
                [path addLineToPoint:CGPointMake(edgX + everyX * i, (25 + (value/self.maxValue) * 175) * HeightNum)];
            }
        }
        layer.path = path.CGPath;
        _percentLineLayer = layer;
    }
    return _percentLineLayer;
    
}

- (void)setVerticalDaySource:(NSArray *)dayArray horizontalValueArray:(NSArray *)valueArray {
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

@end
