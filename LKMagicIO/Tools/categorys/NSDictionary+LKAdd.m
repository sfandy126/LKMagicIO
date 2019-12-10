//
//  NSDictionary+LKAdd.m
//  LKMagicIO
//
//  Created by LK on 2019/12/5.
//  Copyright © 2019 LK. All rights reserved.
//

#import "NSDictionary+LKAdd.h"

@implementation NSDictionary (LKAdd)

+ (BOOL )isNotEmptyDict:(NSDictionary *)dict{
    if (dict && [dict isKindOfClass:[NSDictionary class]] && dict.allKeys.count>0) {
        return YES;
    }
    return NO;
}

+ (NSDictionary *)getDictionary:(NSDictionary *)dict{
    if ([self isNotEmptyDict:dict]) {
        return dict;
    }
    return @{};
}

@end
