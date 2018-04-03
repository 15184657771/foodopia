//
//  AppDelegate.h
//  AkesoChild
//
//  Created by Chen on 16/7/25.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
enum TimeType
{
    LongTime,
    ShortTime,
    LongLongTime
};

@interface Toast : UIView
{
    UILabel* _label;
    NSString * _text;
    enum TimeType _time;
}
+(Toast *)makeText:(NSString *)text andWidth:(CGFloat)width;
-(void)showWithType:(enum TimeType)type;
@end
