//
//  FMDBUtil.m
//  BlueTooth
//
//  Created by Qian on 2018/4/7.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "FMDBUtil.h"

@implementation FMDBUtil

+ (FMDatabase *)shareFMDBObject {
    
    static FMDatabase *db = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* dirPath = NSHomeDirectory();
        NSString* dbPath = [dirPath stringByAppendingPathComponent:@"Documents/BYSJ.db"];
        db = [[FMDatabase alloc] initWithPath:dbPath];
    });
    return db;
    
    
    
    
}

+ (FMDBUtil *)sharedExternUtil {
    static FMDBUtil *externUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        externUtil = [[FMDBUtil alloc] init];
    });
    return externUtil;
}

@end
