//
//  NSArray+LKAdd.m
//  LKMagicIO
//
//  Created by LK on 2019/12/5.
//  Copyright © 2019 LK. All rights reserved.
//

#import "NSArray+LKAdd.h"

@implementation NSArray (LKAdd)

+ (BOOL )isNotEmptyArray:(NSArray *)arr{
    if (arr && [arr isKindOfClass:[NSArray class]] && arr.count>0) {
        return YES;
    }
    return NO;
}

+ (NSArray *)getArray:(NSArray *)arr{
    if ([self isNotEmptyArray:arr]) {
        return arr;
    }
    return @[];
}

@end
