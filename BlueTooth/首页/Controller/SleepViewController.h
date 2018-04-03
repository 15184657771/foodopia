//
//  SleepViewController.h
//  BlueTooth
//
//  Created by Qian on 2018/4/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SleepViewDelegate <NSObject>

- (void)SleepViewBackIndex:(NSInteger )index;

@end

@interface SleepViewController : UIViewController

@property (nonatomic, assign)id delegate;

@end
