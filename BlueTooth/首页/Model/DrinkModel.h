//
//  DrinkModel.h
//  BlueTooth
//
//  Created by Qian on 2018/4/4.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrinkModel : NSObject

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
/**杯数  ps: 1 杯*/
@property (nonatomic, copy)NSString *count;

@end
