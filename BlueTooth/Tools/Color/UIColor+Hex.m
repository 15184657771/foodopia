//
//  UIColor+Hex.h
//  AkesoChild
//
//  Created by Chen on 16/7/25.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation  UIColor (Hex)

+(UIColor*) colorWithHex:(NSString *) string
{
    return [UIColor colorWithHex:string alpha:1.0];
}
+(int) hexToDecimal:(NSString *) hexString
{
//    NSLog(@"hexString:%@",hexString);
    int hexInt = 0;
    for (long i= [hexString length]-1; i>=0; i--)
    {
        char cItem=[hexString characterAtIndex:i];
        int iItem = 0;
        if (cItem == '0')
        {
            iItem= 0;
        }
        else if (cItem == '1')
        {
            iItem= 1;
        }
        else if (cItem == '2')
        {
            iItem= 2;
        }
        else if (cItem == '3')
        {
            iItem= 3;
        }
        else if (cItem == '4')
        {
            iItem= 4;
        }
        else if (cItem == '5')
        {
            iItem= 5;
        }
        else if (cItem == '6')
        {
            iItem= 6;
        }
        else if (cItem == '7')
        {
            iItem= 7;
        }
        else if (cItem == '8')
        {
            iItem= 8;
        }
        else if (cItem == '9')
        {
            iItem= 9;
        }
        else if (cItem == 'a'||cItem == 'A')
        {
            iItem= 10;
        }
        else if (cItem == 'b'||cItem == 'B')
        {
            iItem= 11;
        }
        else if (cItem == 'c'||cItem == 'C')
        {
            iItem= 12;
        }
        else if (cItem == 'd'||cItem == 'D')
        {
            iItem= 13;
        }
        else if (cItem == 'e'||cItem == 'E')
        {
            iItem= 14;
        }
        else if (cItem == 'f'||cItem == 'F')
        {
            iItem= 15;
        }
        hexInt = hexInt+iItem*powl(16,[hexString length]-1-i);
//        NSLog(@"iItem%d, hexInt:%d",iItem,hexInt);
    }
    return hexInt;
}

+(UIColor*) colorWithHex:(NSString *) string alpha:(CGFloat)alpha
{
    CGFloat red = [UIColor hexToDecimal:([string substringWithRange:NSMakeRange(0, 2)])]/255.0f;
    CGFloat green = [UIColor hexToDecimal:([string substringWithRange:NSMakeRange(2, 2)])]/255.0f;
    CGFloat blue = [UIColor hexToDecimal:([string substringWithRange:NSMakeRange(4, 2)])]/255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+(UIColor*) colorWithChangeRed:(CGFloat)redNum green:(CGFloat)greenNum blue:(CGFloat)blueNum alpha:(CGFloat)alpha {
    CGFloat red = redNum/255.0f;
    CGFloat green = greenNum/255.0f;
    CGFloat blue = blueNum/255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end



