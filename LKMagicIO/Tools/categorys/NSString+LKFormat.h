//
//  NSString+LKFormat.h
//  LKMagicIO
//
//  Created by LK on 2019/12/9.
//  Copyright © 2019 LK. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (LKFormat)

/**
 *  时间戳转换成日期格式
 *
 **/
+(NSString *)formatDateStringForTimestamp:(long long)timestamp;

/**
 *  时间戳转换成%天%时%分%秒
 *
 **/
+ (NSString *)formatDayStringForTimestamp:(long long)timestamp;

/**
 *  转传成GB/MB/KB/B格式
 **/
+ (NSString *)formatGBString:(long long)value;

@end

