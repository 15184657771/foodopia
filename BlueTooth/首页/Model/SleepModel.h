//
//  SleepModel.h
//  BlueTooth
//
//  Created by Qian on 2018/4/4.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SleepModel : NSObject

/**年  ps: 2018*/
@property (nonatomic, copy)NSString *year;
/**月  ps: 04*/
@property (nonatomic, copy)NSString *month;
/**日  ps: 04*/
@property (nonatomic, copy)NSString *day;
/**时  ps: 15*/
@property (nonatomic, copy)NSString *hour;
/**分  ps: 43*/
@property (nonatomic, copy)NSString *min;
/**秒  ps: 40*/
@property (nonatomic, copy)NSString *second;
/**睡眠时间  */
@property (nonatomic, copy)NSString *sleepTime;
/**时间戳*/
@property (nonatomic, copy)NSString *time;

//是不是完整的睡眠时间
@property (nonatomic, copy)NSString *isAll;

@end
