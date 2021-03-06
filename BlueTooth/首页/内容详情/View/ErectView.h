//
//  ErectView.h
//  BlueTooth
//
//  Created by Chen on 2018/4/16.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ErectViewDelegate <NSObject>

@optional

- (void)tapShowNum:(NSNumber *)num;

@end

@interface ErectView : UIView

@property (assign) CGFloat maxValue;
- (void)setVerticalDaySource:(NSArray *)dayArray horizontalValueArray:(NSArray *)valueArray;
- (void)show;
@property (weak, nonatomic) id<ErectViewDelegate> delegate;

- (void)setText:(NSString *)str andLast:(NSString *)danweiStr;

@end
