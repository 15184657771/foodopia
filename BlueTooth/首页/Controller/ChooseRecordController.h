//
//  ChooseRecordController.h
//  BlueTooth
//
//  Created by Qian on 2018/4/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseRecordDelegate <NSObject>

- (void)ChooseRecordBackIndex:(NSInteger )index;

@end

@interface ChooseRecordController : UIViewController

@property (nonatomic, assign)id delegate;

@end
