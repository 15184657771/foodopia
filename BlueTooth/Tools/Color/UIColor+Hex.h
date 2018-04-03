//
//  UIColor+Hex.h
//  AkesoChild
//
//  Created by Chen on 16/7/25.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIColor (Hex)

+(UIColor*) colorWithHex:(NSString *) string;

+(UIColor*) colorWithHex:(NSString *) string alpha:(CGFloat)alpha;

+(UIColor*) colorWithChangeRed:(CGFloat)redNum green:(CGFloat)greenNum blue:(CGFloat)blueNum alpha:(CGFloat)alpha;


@end