//
//  BaseView.m
//  BlueTooth
//
//  Created by Chen on 2018/4/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "BaseView.h"
@interface BaseView()

@property (nonatomic,strong) CAShapeLayer *curveLayer;
@property (nonatomic,strong) CAShapeLayer *lineLayer;


@property (nonatomic,strong) NSMutableArray *verticalDayArray;
@property (nonatomic,strong) NSMutableArray *horizontalValueArray;
@property (nonatomic,assign) CGFloat maxValue;
@property (nonatomic,assign) CGFloat minValue;
@property (nonatomic,assign) CGFloat viewWidth;
@property (nonatomic,assign) CGFloat viewHigh;

@property (nonatomic,strong) UILabel *showLabel;
@property (nonatomic,strong) UIImageView *showImageView;

@property (nonatomic,strong) CAShapeLayer *circleLayer;
@end

@implementation BaseView

- (CAShapeLayer *)circleLayer {
    if (!_circleLayer) {
        NSMutableArray *pointArray = [NSMutableArray array];
        CGFloat everyY = (self.viewHigh - 16 * HeightNum)/(self.maxValue - self.minValue);
        CGFloat everyX = (self.viewWidth - 80 * WidthNum) / (self.horizontalValueArray.count - 1);
        CGFloat edgY = self.viewHigh;
        CGFloat edgX = 40 * WidthNum;
        if (self.horizontalValueArray.count == 1) {
            [pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, edgY - ([self.horizontalValueArray[0] floatValue] - self.minValue) * everyY)]];
        } else {
            
            for (int i = 0; i < self.horizontalValueArray.count; i ++) {
                [pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(edgX + i * everyX, edgY - ([self.horizontalValueArray[i] floatValue] - self.minValue) * everyY)]];
            }
        }
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        layer.fillColor = RGB(173, 119, 205).CGColor;
        layer.strokeColor = RGB(173, 119, 205).CGColor;
        layer.lineWidth = 0;
        UIBezierPath *path = [[UIBezierPath alloc] init];
        for (int i = 0; i < pointArray.count; i++) {
            NSValue *selectPointValue = pointArray[i];
            CGPoint selectPoint = [selectPointValue CGPointValue];
            [path moveToPoint:CGPointMake(selectPoint.x,selectPoint.y)];
            [path addArcWithCenter:CGPointMake(selectPoint.x,selectPoint.y) radius:4 startAngle:0 endAngle:2*M_PI clockwise:YES];
        }
        layer.path = path.CGPath;
        CAShapeLayer *whiteLayer = [CAShapeLayer layer];
        [whiteLayer addSublayer:layer];
        whiteLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        whiteLayer.fillColor = [UIColor whiteColor].CGColor;
        whiteLayer.strokeColor = [UIColor whiteColor].CGColor;
        whiteLayer.lineWidth = 0;
        UIBezierPath *whitePath = [[UIBezierPath alloc] init];
        for (int i = 0; i < pointArray.count; i++) {
            NSValue *selectPointValue = pointArray[i];
            CGPoint selectPoint = [selectPointValue CGPointValue];
            [whitePath moveToPoint:CGPointMake(selectPoint.x,selectPoint.y)];
            [whitePath addArcWithCenter:CGPointMake(selectPoint.x,selectPoint.y) radius:7 startAngle:0 endAngle:2*M_PI clockwise:YES];
        }
        whiteLayer.path = whitePath.CGPath;
        
        
        _circleLayer = whiteLayer;
    }
    return _circleLayer;
}

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
        self.viewWidth = SCREEN_WIDTH;
        self.viewHigh = 200 * HeightNum;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (UILabel *)showLabel {
    if (!_showLabel) {
        _showLabel = [[UILabel alloc] init];
        [_showLabel setBackgroundColor:[UIColor clearColor]];
        [_showLabel setTextAlignment:NSTextAlignmentCenter];
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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initValueAndView];
        self.viewWidth = self.bounds.size.width;
        self.viewHigh = self.bounds.size.height;
        WS(ws);

        [self addSubview:self.showImageView];
        [self addSubview:self.showLabel];

        [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws.showLabel.mas_centerX);
            make.centerY.equalTo(ws.showLabel.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(78,42));
        }];
        [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.left.equalTo(@10);
            make.size.mas_equalTo(CGSizeMake(78,22));
        }];
    }
    return self;
}

- (void)initValueAndView {
    self.backgroundColor = RGB(250, 250, 250);
    self.maxValue = 44.0;
    self.minValue = 46.0;
    if (self.horizontalValueArray.count > 0) {
        [self.layer addSublayer:self.lineLayer];
        [self.layer addSublayer:self.curveLayer];
        [self.layer addSublayer:self.circleLayer];
    }
}

- (CAShapeLayer *)lineLayer {
    if (!_lineLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = CGRectMake(0, 0, self.viewWidth, self.viewHigh);
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = RGBA(191, 140, 219, 0.25).CGColor;
        layer.lineWidth = 1;
        layer.lineJoin = kCALineJoinRound;
        layer.lineDashPattern = @[@4,@4];
        UIBezierPath *path = [UIBezierPath bezierPath];
        if (self.horizontalValueArray.count == 1) {
            [path moveToPoint:CGPointMake(self.viewWidth/2, 16 * HeightNum)];
            [path addLineToPoint:CGPointMake(self.viewWidth/2, self.viewHigh)];
        } else {
            CGFloat everyX = (self.viewWidth - 80 * WidthNum) / (self.horizontalValueArray.count - 1);
            CGFloat edgX = 40 * WidthNum;
            for (int i = 0; i < self.horizontalValueArray.count; i ++) {
                [path moveToPoint:CGPointMake(edgX + everyX * i, 16 * HeightNum)];
                [path addLineToPoint:CGPointMake(edgX + everyX * i, self.viewHigh)];
            }
        }
        layer.path = path.CGPath;
        _lineLayer = layer;
    }
    return _lineLayer;

}

- (CAShapeLayer *)curveLayer {
    if (!_curveLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = CGRectMake(0, 0, self.viewWidth, self.viewHigh);
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = RGB(173, 119, 205).CGColor;
        layer.lineWidth = 3;
        layer.lineJoin = kCALineJoinRound;
        
        CGFloat everyY = (self.viewHigh - 16 * HeightNum)/(self.maxValue - self.minValue);
        CGFloat everyX = (self.viewWidth - 80 * WidthNum) / (self.horizontalValueArray.count - 1);
        CGFloat edgY = self.viewHigh;
        CGFloat edgX = 40 * WidthNum;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        if (self.horizontalValueArray.count == 1) {
            [path moveToPoint:CGPointMake(0,edgY - ([self.horizontalValueArray[0] floatValue] - self.minValue) * everyY)];
            [path addLineToPoint:CGPointMake(SCREEN_WIDTH,edgY - ([self.horizontalValueArray[0] floatValue] - self.minValue) * everyY)];
        } else {
            if ([self.horizontalValueArray[0] floatValue] > [self.horizontalValueArray[1] floatValue]) {
                [path moveToPoint:CGPointMake(0,edgY - ([self.horizontalValueArray[0] floatValue] - self.minValue + 0.1) * everyY)];
            } else {
                [path moveToPoint:CGPointMake(0,edgY - ([self.horizontalValueArray[0] floatValue] - self.minValue - 0.1) * everyY)];
            }
            [path addQuadCurveToPoint:CGPointMake(edgX, edgY - ([self.horizontalValueArray[0] floatValue] - self.minValue) * everyY) controlPoint:CGPointMake(edgX/2, edgY - ([self.horizontalValueArray[0] floatValue] - self.minValue) * everyY)];

            
            [path moveToPoint:CGPointMake(edgX,edgY - ([self.horizontalValueArray[0] floatValue] - self.minValue) * everyY)];
            for (int i = 1; i < self.horizontalValueArray.count; i ++) {
                CGFloat controlX = edgX + i * everyX - everyX/2;
                CGFloat controlY = edgY - (([self.horizontalValueArray[i - 1] floatValue] - self.minValue) + ([self.horizontalValueArray[i] floatValue] - [self.horizontalValueArray[i - 1] floatValue])/4*3) * everyY;
//                CGFloat controlY;
//                if ([self.horizontalValueArray[i] floatValue] > [self.horizontalValueArray[i - 1] floatValue]) {
////                    controlX = edgX + i * everyX;
//                    controlY = edgY - ([self.horizontalValueArray[i] floatValue] - self.minValue) * everyY;
//                } else {
////                    controlX = edgX + (i - 1) * everyX;
//                    controlY = edgY - ([self.horizontalValueArray[i - 1] floatValue] - self.minValue) * everyY;
//                }
                
                
                [path addQuadCurveToPoint:CGPointMake(edgX + i * everyX, edgY - ([self.horizontalValueArray[i] floatValue] - self.minValue) * everyY) controlPoint:CGPointMake(controlX, controlY)];
            }
            if ([self.horizontalValueArray[self.horizontalValueArray.count - 1] floatValue] > [self.horizontalValueArray[self.horizontalValueArray.count - 2] floatValue]) {
                [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH, edgY - ([[self.horizontalValueArray lastObject] floatValue] - self.minValue + 0.1) * everyY) controlPoint:CGPointMake(SCREEN_WIDTH - edgX/2, edgY - ([[self.horizontalValueArray lastObject] floatValue] - self.minValue + 0.1) * everyY)];
            } else {
                [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH, edgY - ([[self.horizontalValueArray lastObject] floatValue] - self.minValue - 0.1) * everyY) controlPoint:CGPointMake(SCREEN_WIDTH - edgX/2, edgY - ([[self.horizontalValueArray lastObject] floatValue] - self.minValue - 0.1) * everyY)];
            }
        }
        layer.path = path.CGPath;
        _curveLayer = layer;
    }
    return _curveLayer;
}

- (void)drawRect:(CGRect)rect {
    CGFloat everyX = (self.viewWidth - 80 * WidthNum) / (self.horizontalValueArray.count - 1);
    CGFloat edgX = 40 * WidthNum;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:10 * HeightNum], NSForegroundColorAttributeName:RGB(191, 191, 191)};
    for (int i = 0; i < self.verticalDayArray.count; i++) {
        CGSize statuseStrSize = [[NSString stringWithFormat:@"%@",self.verticalDayArray[i]] sizeWithAttributes:attribute];//计算字数宽度
        [self.verticalDayArray[i] drawAtPoint:CGPointMake(edgX + everyX * i - statuseStrSize.width/2, 3 * HeightNum) withAttributes:attribute];
    }

}

- (void)setVerticalDaySource:(NSArray *)dayArray horizontalValueArray:(NSArray *)valueArray {
    self.showLabel.hidden = YES;
    self.showImageView.hidden = YES;
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
    
    
    if (valueArray.count == 0) {
        self.maxValue = 44.0;
        self.minValue = 46.0;
    } else {
        CGFloat maxValue = [valueArray[0] floatValue];
        CGFloat minValue = [valueArray[0] floatValue];
        for (NSNumber *num in valueArray) {
            maxValue = [num floatValue] > maxValue?[num floatValue]:maxValue;
            minValue = [num floatValue] < minValue?[num floatValue]:minValue;
        }
        self.maxValue = maxValue + 0.8;
        self.minValue = minValue - 0.8;
    }
}

- (void)show {
    [self.curveLayer removeFromSuperlayer];
    [self.lineLayer removeFromSuperlayer];
    [self.circleLayer removeFromSuperlayer];
    self.lineLayer = nil;
    self.curveLayer = nil;
    self.circleLayer = nil;
    if (self.horizontalValueArray.count > 0) {
        [self.layer addSublayer:self.lineLayer];
        [self.layer addSublayer:self.curveLayer];
        [self.layer addSublayer:self.circleLayer];
    }
    [self.layer setNeedsDisplay];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    float x = point.x;
    float y = point.y;
    CGFloat everyY = (self.viewHigh - 16 * HeightNum)/(self.maxValue - self.minValue);
    CGFloat everyX;
    if (self.horizontalValueArray.count == 1) {
        everyX = (self.viewWidth - 80 * WidthNum) / 2;
    } else {
        everyX = (self.viewWidth - 80 * WidthNum) / (self.horizontalValueArray.count - 1);
    }
    CGFloat edgeX = 40 * WidthNum;
    NSInteger num = (x - edgeX + everyX / 2) / everyX;
    if (self.horizontalValueArray.count == 1) {
        num = 0;
    }

    CGFloat minMarkNum = self.minValue;
    CGFloat percentNum = 1.0;
    CGFloat edeY = self.viewHigh;
    if (num < self.horizontalValueArray.count) {
        CGFloat selectpointY = edeY - ([self.horizontalValueArray[num] floatValue] - minMarkNum) / percentNum * everyY;
        if (y < 20 + selectpointY && y > selectpointY - 20) {
            if ([_delegate respondsToSelector:@selector(tapShowNum:)]) {
                [_delegate tapShowNum:self.horizontalValueArray[num]];
            }
            WS(ws);
            self.showLabel.hidden = NO;
            self.showImageView.hidden = NO;

            CGFloat pointX = num * everyX + edgeX;
            if (self.horizontalValueArray.count == 1) {
                pointX = everyX + edgeX;
            }
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
    }
    
}

- (void)setText:(NSString *)str andLast:(NSString *)danweiStr{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",str,danweiStr]];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12]
                    range:NSMakeRange(0, [attrStr length])];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16]
                    range:NSMakeRange(0, [str length])];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [attrStr length])]; //设置字体颜色
    self.showLabel.attributedText = attrStr;
}




@end
