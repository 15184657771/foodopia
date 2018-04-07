//
//  AppDelegate.h
//  BlueTooth
//
//  Created by Chen on 2018/3/7.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@end

