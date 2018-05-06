//
//  BaseView.h
//  BlueTooth
//
//  Created by Chen on 2018/4/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseViewDelegate <NSObject>

@optional

- (void)tapShowNum:(NSNumber *)num;

@end

@interface BaseView : UIView
@property (weak, nonatomic) id<BaseViewDelegate> delegate;

- (void)setVerticalDaySource:(NSArray *)dayArray horizontalValueArray:(NSArray *)valueArray;
- (void)show;
- (void)setText:(NSString *)str andLast:(NSString *)danweiStr;
@end
