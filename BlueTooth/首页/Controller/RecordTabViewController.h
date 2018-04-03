//
//  RecordTabViewController.h
//  BlueTooth
//
//  Created by Qian on 2018/4/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecordTabDelegate <NSObject>

- (void)RecordTabBackIndex:(NSInteger )index;

@end

@interface RecordTabViewController : UIViewController

-(void)selectTab:(NSUInteger)index;

@property (nonatomic, assign)id delegate;

@end
