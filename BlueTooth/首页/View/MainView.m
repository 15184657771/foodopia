//
//  MainView.m
//  BlueTooth
//
//  Created by Chen on 2018/3/11.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "MainView.h"
#import "GetToolViewController.h"

@interface MainView()

@property (nonatomic,strong) CAShapeLayer *lineLayer;
@property (nonatomic,strong) CAShapeLayer *dottedLineLayer;
@property (nonatomic,strong) UIBezierPath *workPath;
@property (nonatomic,strong) NSMutableArray *pointArray;
@property (nonatomic,strong) CAShapeLayer *circleLayer;
@property (nonatomic,strong) UIImageView *locationImageView;
@property (nonatomic,strong) NSArray *selectNumArray;
@property (nonatomic,strong) NSMutableArray *bezierPoints;
@end

@implementation MainView

- (UIImageView *)locationImageView {
    if (!_locationImageView) {
        _locationImageView = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"pin"]];
    }
    return _locationImageView;
}

- (NSMutableArray *)pointArray {
    if (!_pointArray) {
        _pointArray = [NSMutableArray array];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(1200, 1215)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(1095, 1140)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(1255, 1040)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(1175, 950)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(1085, 835)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(895, 790)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(805, 715)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(750, 845)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(655, 960)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(395, 1030)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(305, 940)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(350, 850)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(430, 780)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(360, 585)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(440, 525)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(615, 525)]];
        [_pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(685, 415)]];

    }
    return _pointArray;
}

- (NSMutableArray *)bezierPoints {
    if (!_bezierPoints) {
        _bezierPoints = [NSMutableArray array];
        CGPathApply(self.workPath.CGPath, (__bridge void *)(_bezierPoints), MyCGPathApplierFunc);
    }
    return _bezierPoints;
}

- (UIBezierPath *)workPath {
    if (!_workPath) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(1410, 1215)];
        for (int i=5; i<=305; i+=5) {
            [path addLineToPoint:CGPointMake(1410 - i, 1215)];
        }
        [path addQuadCurveToPoint:CGPointMake(1095, 1205) controlPoint:CGPointMake(1095, 1215)];
        for (int i=5; i<=95; i+=5) {
            [path addLineToPoint:CGPointMake(1095, 1205 - i)];
        }
        [path addQuadCurveToPoint:CGPointMake(1105, 1100) controlPoint:CGPointMake(1095, 1100)];
        for (int i=5; i<=140; i+=5) {
            [path addLineToPoint:CGPointMake(1105 + i, 1100)];
        }
        [path addQuadCurveToPoint:CGPointMake(1255, 1090) controlPoint:CGPointMake(1255, 1100)];
        for (int i=5; i<=130; i+=5) {
            [path addLineToPoint:CGPointMake(1255, 1090 - i)];
        }
        [path addQuadCurveToPoint:CGPointMake(1245, 950) controlPoint:CGPointMake(1255, 950)];
        for (int i=5; i<=110; i+=5) {
            [path addLineToPoint:CGPointMake(1245- i, 950)];
        }
        [path addQuadCurveToPoint:CGPointMake(1125, 940) controlPoint:CGPointMake(1125, 950)];
        for (int i=5; i<=95; i+=5) {
            [path addLineToPoint:CGPointMake(1125, 940 - i)];
        }
        [path addQuadCurveToPoint:CGPointMake(1115, 835) controlPoint:CGPointMake(1125, 835)];
        for (int i=5; i<=210; i+=5) {
            [path addLineToPoint:CGPointMake(1115 - i, 835)];
        }
        [path addQuadCurveToPoint:CGPointMake(895, 825) controlPoint:CGPointMake(895, 835)];
        for (int i=5; i<=100; i+=5) {
            [path addLineToPoint:CGPointMake(895, 825 - i)];
        }
        [path addQuadCurveToPoint:CGPointMake(885, 715) controlPoint:CGPointMake(895, 715)];
        for (int i=5; i<=125; i+=5) {
            [path addLineToPoint:CGPointMake(885 - i, 715)];
        }
        [path addQuadCurveToPoint:CGPointMake(750, 725) controlPoint:CGPointMake(750, 715)];
        for (int i=5; i<=225; i+=5) {
            [path addLineToPoint:CGPointMake(750, 725 + i)];
        }
        [path addQuadCurveToPoint:CGPointMake(740, 960) controlPoint:CGPointMake(750, 960)];
        for (int i=5; i<=250; i+=5) {
            [path addLineToPoint:CGPointMake(740 - i, 960)];
        }
        [path addQuadCurveToPoint:CGPointMake(480, 970) controlPoint:CGPointMake(480, 960)];
        for (int i=5; i<=50; i+=5) {
            [path addLineToPoint:CGPointMake(480, 970 + i)];
        }
        [path addQuadCurveToPoint:CGPointMake(470, 1030) controlPoint:CGPointMake(480, 1030)];
        for (int i=5; i<=155; i+=5) {
            [path addLineToPoint:CGPointMake(470 - i, 1030)];
        }
        [path addQuadCurveToPoint:CGPointMake(305, 1020) controlPoint:CGPointMake(305, 1030)];
        for (int i=5; i<=160; i+=5) {
            [path addLineToPoint:CGPointMake(305, 1020 - i)];
        }
        [path addQuadCurveToPoint:CGPointMake(315, 850) controlPoint:CGPointMake(305, 850)];
        for (int i=5; i<=105; i+=5) {
            [path addLineToPoint:CGPointMake(315 + i, 850)];
        }
        [path addQuadCurveToPoint:CGPointMake(430, 840) controlPoint:CGPointMake(430, 850)];
        for (int i=5; i<=200; i+=5) {
            [path addLineToPoint:CGPointMake(430, 840 - i)];
        }
        [path addQuadCurveToPoint:CGPointMake(420, 630) controlPoint:CGPointMake(430, 630)];
        for (int i=5; i<=50; i+=5) {
            [path addLineToPoint:CGPointMake(420 - i, 630)];
        }
        [path addQuadCurveToPoint:CGPointMake(360, 620) controlPoint:CGPointMake(360, 630)];
        for (int i=5; i<=85; i+=5) {
            [path addLineToPoint:CGPointMake(360, 620 - i)];
        }
        [path addQuadCurveToPoint:CGPointMake(370, 525) controlPoint:CGPointMake(360, 525)];
        for (int i=5; i<=305; i+=5) {
            [path addLineToPoint:CGPointMake(370 + i, 525)];
        }
        [path addQuadCurveToPoint:CGPointMake(685, 515) controlPoint:CGPointMake(685, 525)];
        for (int i=5; i<=250; i+=5) {
            [path addLineToPoint:CGPointMake(685, 515 - i)];
        }
        _workPath = path;
    }
    return _workPath;
}

- (CAShapeLayer *)lineLayer {
    if (!_lineLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = RGB(255, 252, 259).CGColor;
        layer.lineWidth = 10;
        layer.lineCap = kCALineCapRound;
        layer.path = self.workPath.CGPath;
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
        layer.lineDashPattern = @[@3,@3];
        layer.path = self.workPath.CGPath;
        _dottedLineLayer = layer;
    }
    return _dottedLineLayer;
}

- (CAShapeLayer *)circleLayer {
    if (!_circleLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        layer.fillColor = RGB(255, 214, 73).CGColor;
        layer.strokeColor = RGB(255, 214, 73).CGColor;
        layer.lineWidth = 0;
        UIBezierPath *path = [[UIBezierPath alloc] init];
        for (int i = 0; i < self.pointArray.count; i++) {
            NSValue *selectPointValue = self.pointArray[i];
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
        for (int i = 0; i < self.pointArray.count; i++) {
            NSValue *selectPointValue = self.pointArray[i];
            CGPoint selectPoint = [selectPointValue CGPointValue];
            [whitePath moveToPoint:CGPointMake(selectPoint.x,selectPoint.y)];
            [whitePath addArcWithCenter:CGPointMake(selectPoint.x,selectPoint.y) radius:7 startAngle:0 endAngle:2*M_PI clockwise:YES];
        }
        whiteLayer.path = whitePath.CGPath;
        
        
        _circleLayer = whiteLayer;
    }
    return _circleLayer;
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
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"map-1"]]];
    [self.layer addSublayer:self.lineLayer];
    [self.layer addSublayer:self.dottedLineLayer];
    [self.layer addSublayer:self.circleLayer];
    
    [self addSubview:self.locationImageView];
    CGPoint movePoint = [self moveToPlace];
    [self.locationImageView setFrame:CGRectMake(movePoint.x - 11, movePoint.y - 31, 22, 36)];
    self.selectNumArray = @[[NSNumber numberWithInt:42],[NSNumber numberWithInt:76],[NSNumber numberWithInt:124],[NSNumber numberWithInt:156],
                                [NSNumber numberWithInt:193],[NSNumber numberWithInt:238],[NSNumber numberWithInt:269],[NSNumber numberWithInt:304],
                                [NSNumber numberWithInt:344],[NSNumber numberWithInt:406],[NSNumber numberWithInt:440],[NSNumber numberWithInt:465],
                                [NSNumber numberWithInt:497],[NSNumber numberWithInt:542],[NSNumber numberWithInt:568],[NSNumber numberWithInt:603],
                                [NSNumber numberWithInt:637]];
    
    NSMutableArray *bezierPoints = [NSMutableArray array];
    CGPathApply(self.workPath.CGPath, (__bridge void *)(bezierPoints), MyCGPathApplierFunc);
    
    int j = 0;
    NSValue *selectPointValue = self.pointArray[j];
    CGPoint selectPoint = [selectPointValue CGPointValue];
    for (int i = 0 ;i<bezierPoints.count;i++) {
        NSValue *pointValue = bezierPoints[i];
        CGPoint point = [pointValue CGPointValue];

        if (point.x == selectPoint.x &&point.y == selectPoint.y) {
            NSLog(@"%d",i);
            if (j < self.pointArray.count - 1) {
                j+=1;
            }
            selectPointValue = self.pointArray[j];
            selectPoint = [selectPointValue CGPointValue];
        }
    }
    
}


void MyCGPathApplierFunc (void *info, const CGPathElement *element) {
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    
    CGPoint *points = element->points;
    CGPathElementType type = element->type;
    
    switch(type) {
        case kCGPathElementMoveToPoint: // contains 1 point
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddLineToPoint: // contains 1 point
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddQuadCurveToPoint: // contains 2 points
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            break;
            
        case kCGPathElementAddCurveToPoint: // contains 3 points
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[2]]];
            break;
            
        case kCGPathElementCloseSubpath: // contains no point
            break;
    }
}

- (CGPoint)moveToPlace {
    NSInteger num = [[[NSUserDefaults standardUserDefaults]objectForKey:@"percentNum"] integerValue];
    NSInteger j = num/50 + 42 < self.bezierPoints.count?num/50 + 42:self.bezierPoints.count - 1;
    NSValue *pointValue = self.bezierPoints[j];
    CGPoint point = [pointValue CGPointValue];
    return point;
}

- (void)placeMove:(NSInteger)moveNum {
    NSInteger num = [[[NSUserDefaults standardUserDefaults]objectForKey:@"percentNum"] integerValue];
    NSInteger beforePlace = [self placeCount:num];
    num+=moveNum;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:num] forKey:@"percentNum"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSInteger nowPlace = [self placeCount:num];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i=beforePlace+1; i<=nowPlace; i++) {
        CGPoint point = [self.bezierPoints[i] CGPointValue];
        CGPoint newPoint = CGPointMake(point.x, point.y - 13);
        [array addObject:[NSValue valueWithCGPoint:newPoint]];
    }
    // 设置position属性的每一帧要改变的值
    anim.values = array;
    // 设置动画持续时间
    anim.duration = array.count * 0.05;
    // 保持动画执行完毕后的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    // 3,添加动画
    [self.locationImageView.layer addAnimation:anim forKey:nil];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(array.count * 0.05 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        for (int i = 0; i < self.selectNumArray.count; i++) {
            if ([self.selectNumArray[i] integerValue] > beforePlace &&[self.selectNumArray[i] integerValue] <= nowPlace) {
                GetToolViewController *toolVC = [[GetToolViewController alloc]init];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                if (i == 1||i == 9||i == 13) {//面粉
                    [toolVC setUpUI:Flour];
                    [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"flour"] intValue] + 1] forKey:@"flour"];
                }else if (i == 2||i == 6||i == 14) {//鸡蛋
                    [toolVC setUpUI:Egg];
                    [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"egg"] intValue] + 1] forKey:@"egg"];
                }else if (i == 3) {//巧克力
                    [toolVC setUpUI:Chocolates];
                    [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"chocolate"] intValue] + 1] forKey:@"chocolate"];
                }else if (i == 5||i == 10) {//芝士
                    [toolVC setUpUI:Cheeses];
                    [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"cheese"] intValue] + 1] forKey:@"cheese"];
                }else if (i == 7) {//蓝莓
                    [toolVC setUpUI:Blueberry];
                    [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"blueberry"] intValue] + 1] forKey:@"blueberry"];
                }else if (i == 11) {//草莓
                    [toolVC setUpUI:Strawberry];
                    [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"strawberry"] intValue] + 1] forKey:@"strawberry"];
                }else if (i == 15) {//抹茶粉
                    [toolVC setUpUI:Motcha];
                    [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"motchaBtn"] intValue] + 1] forKey:@"motcha"];
                } else {
                    [toolVC setUpUI:Map];
                }
                [defaults synchronize];
                toolVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
                UIViewController *fatherVC = [self getFartherController];
                fatherVC.definesPresentationContext = YES;
                [fatherVC presentViewController:toolVC animated:NO completion:^{
                    toolVC.view.superview.backgroundColor = [UIColor clearColor];
                }];
            }
        }
    });
    
    
}

- (NSInteger)placeCount:(NSInteger)num {
    NSInteger j = num/50 + 42 < self.bezierPoints.count?num/50 + 42:self.bezierPoints.count - 1;
    return j;
}

- (CGPoint)placePoint:(NSInteger)num {
    NSInteger j = num/50 + 42 < self.bezierPoints.count?num/50 + 42:self.bezierPoints.count - 1;
    NSValue *pointValue = self.bezierPoints[j];
    CGPoint point = [pointValue CGPointValue];
    return point;
}

- (UIViewController *)getFartherController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
