//
//  GetToolViewController.h
//  BlueTooth
//
//  Created by Qian on 2018/4/24.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ToolType) {
    Strawberry, // 草莓
    Egg,  //鸡蛋
    Blueberry, //蓝莓
    Flour, //面粉
    Chocolates, //巧克力
    Cheeses,    //芝士
};


@interface GetToolViewController : UIViewController

- (void)setUpUI:(ToolType)toolType;

@end
