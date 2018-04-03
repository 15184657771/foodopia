//
//  WeightViewController.h
//  BlueTooth
//
//  Created by Qian on 2018/4/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeightViewDelegate <NSObject>

- (void)WeightViewBackIndex:(NSInteger )index;

@end

@interface WeightViewController : UIViewController

@property (nonatomic, assign)id delegate;

@end
