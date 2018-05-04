//
//  DrinkViewController.h
//  BlueTooth
//
//  Created by Qian on 2018/4/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DrinkViewDelegate <NSObject>

- (void)DrinkViewBackIndex:(NSInteger )index;

- (void)drinkBtnClick;

@end

@interface DrinkViewController : UIViewController

@property (nonatomic, assign)id delegate;

@end
