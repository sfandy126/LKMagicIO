//
//  NSString+LKFormat.m
//  LKMagicIO
//
//  Created by LK on 2019/12/9.
//  Copyright © 2019 LK. All rights reserved.
//

#import "NSString+LKFormat.h"

@implementation NSString (LKFormat)

+(NSString *)formatDateStringForTimestamp:(long long)timestamp{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}

+ (NSString *)formatDayStringForTimestamp:(long long)timestamp{
    //时间戳转换成天字符串
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comp = [calendar components:unitFlags fromDate:date toDate:now options:0];
    
    int year = (int)[comp year];
    int month = (int)[comp month];
    int day = (int)[comp day];
    int hour = (int)[comp hour];
    int min = (int)[comp minute];
    int sec = (int)[comp second];
    NSString *string = @"";
    if (year>0) {
        string = [string stringByAppendingFormat:@"%d年",year];
    }
    if (month>0) {
        string = [string stringByAppendingFormat:@"%d月",month];
    }
    if (day>0) {
        string = [string stringByAppendingFormat:@"%d天",day];
    }
    if (hour>0) {
        string = [string stringByAppendingFormat:@"%d时",hour];
    }
    if (min>0) {
        string = [string stringByAppendingFormat:@"%02d分",min];
    }
    if (sec>0) {
        string = [string stringByAppendingFormat:@"%02d秒",sec];
    }
    return string;
}

+ (NSString *)formatGBString:(long long)value{
    if (value<=0) {
        return @"";
    }
    double gb_value = value/1024/1024/1024;
    if (gb_value>0) {
        return [NSString stringWithFormat:@"%0.fGB",gb_value];
    }
    double mb_value = value/1024/1024;
    if (mb_value>0) {
        return [NSString stringWithFormat:@"%0.fMB",mb_value];
    }
    double kb_value = value/1024;
    if (kb_value>0) {
        return [NSString stringWithFormat:@"%0.fkB",kb_value];
    }
    double b_value = value;
    if (b_value>0) {
        return [NSString stringWithFormat:@"%0.fB",b_value];
    }
    return @"";
}

@end

