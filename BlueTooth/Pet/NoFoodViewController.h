//
//  NoFoodViewController.h
//  BlueTooth
//
//  Created by Qian on 2018/5/4.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FoodType) {
    Chocolates, //巧克力
    Blueberry_Cake, //蓝莓
    Strawberry_Cake, // 草莓
    Motcha_Roll,     //抹茶卷
};

@protocol NoFoodViewDelegate <NSObject>

- (void)NoFoodViewDelegate;

@end

@interface NoFoodViewController : UIViewController

- (void)setUpUI:(FoodType)toolType;

@property (nonatomic, assign)id delegate;

@end
