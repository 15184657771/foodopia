//
//  FMDBUtil.h
//  BlueTooth
//
//  Created by Qian on 2018/4/7.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface FMDBUtil : NSObject

+ (FMDatabase *)shareFMDBObject;

+ (FMDBUtil *)sharedExternUtil;

@end
