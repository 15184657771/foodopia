//
//  AppDelegate.h
//  AkesoChild
//
//  Created by Chen on 16/7/25.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "Toast.h"
#import <QuartzCore/CALayer.h>
static Toast * _toast = nil;

@implementation Toast

- (id)initWithText:(NSString*)text andWidth:(CGFloat)width
{
    self = [super init];
    if (self) {
        _text = [text copy];
        // Initialization code
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
        CGRect textFrame = [_text boundingRectWithSize:CGSizeMake(280, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
        //leak;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, textFrame.size.width, textFrame.size.height)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:16];
        label.text = _text;
        label.numberOfLines = 0;
        label.shadowColor = [UIColor darkGrayColor];
        label.shadowOffset = CGSizeMake(1, 1);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self setFrame:CGRectMake((width - textFrame.size.width)/2, 200, textFrame.size.width + 20, textFrame.size.height + 10)];
        [self addSubview:label];
    }
    return self;
}


+(Toast *)makeText:(NSString *)text andWidth:(CGFloat)width{
//    if(_toast == nil){
//        _toast = [[Toast alloc]initWithText:text andWidth:width];
//    }
    
    @synchronized(self){
        if(_toast == nil){
            _toast = [[Toast alloc]initWithText:text andWidth:width];
        }
    }
    return _toast;
}

-(void)showWithType:(enum TimeType)type{
    if (type == LongTime) {
        _time = 3.0f;
    } else if (type == LongLongTime) {
        _time = 7.0f;
    } else{
        _time = 1.5f;
    }
    NSTimer *timer1 = [NSTimer timerWithTimeInterval:(_time/4.0f)  target:self selector:@selector(removeToast) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer1 forMode:NSDefaultRunLoopMode];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

-(void)removeToast
{
    [UIView animateWithDuration:_time animations:^{
            if (_toast.alpha!=0.0f) {
                _toast.alpha -= 0.3f;
            }
        }
        completion:^(BOOL finished) {
        [_toast setAlpha:0];
        [_toast removeFromSuperview];
        _toast = nil;
        }
    ];
}



@end
