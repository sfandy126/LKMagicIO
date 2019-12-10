//
//  NSDictionary+LKAdd.h
//  LKMagicIO
//
//  Created by LK on 2019/12/5.
//  Copyright © 2019 LK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (LKAdd)

+ (BOOL )isNotEmptyDict:(NSDictionary *)dict;

+ (NSDictionary *)getDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
