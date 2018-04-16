//
//  ErectView.h
//  BlueTooth
//
//  Created by Chen on 2018/4/16.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ErectView : UIView

@property (assign) CGFloat maxValue;
- (void)setVerticalDaySource:(NSArray *)dayArray horizontalValueArray:(NSArray *)valueArray;
- (void)show;

@end
