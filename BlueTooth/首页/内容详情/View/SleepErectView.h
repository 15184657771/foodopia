//
//  SleepErectView.h
//  BlueTooth
//
//  Created by Chen on 2018/5/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SleepErectViewDelegate <NSObject>

@optional

- (void)tapShowNum:(NSNumber *)num;

@end

@interface SleepErectView : UIView
@property (assign) CGFloat maxValue;
- (void)setVerticalDaySource:(NSArray *)dayArray horizontalValueArray:(NSArray *)valueArray;
- (void)show;
@property (weak, nonatomic) id<SleepErectViewDelegate> delegate;

- (void)setText:(NSString *)str andLast:(NSString *)danweiStr;
@end
