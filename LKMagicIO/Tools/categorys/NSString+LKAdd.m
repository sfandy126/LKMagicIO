//
//  NSString+LKAdd.m
//  LKMagicIO
//
//  Created by LK on 2019/12/5.
//  Copyright © 2019 LK. All rights reserved.
//

#import "NSString+LKAdd.h"

@implementation NSString (LKAdd)

+ (BOOL )isNotEmptyString:(NSString *)string{
    if (string && [string isKindOfClass:[NSString class]] && string.length>0) {
        return YES;
    }
    return NO;
}

+ (NSString *)stringValue:(NSString *)string{
    if ([self isNotEmptyString:string]) {
        return string;
    }
    return @"";
}

@end
