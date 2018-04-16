//
//  RecordInfoTabController.h
//  BlueTooth
//
//  Created by Qian on 2018/4/16.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecordTabDelegate <NSObject>

- (void)RecordTabBackIndex:(NSInteger )index;

@end

@interface RecordInfoTabController : UIViewController

@property (nonatomic, assign) NSInteger showTag;

@property (nonatomic, assign)id delegate;

@end
