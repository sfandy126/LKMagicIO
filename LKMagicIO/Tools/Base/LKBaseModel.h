//
//  LKBaseModel.h
//  LKMagicIO
//
//  Created by LK on 2019/12/3.
//  Copyright © 2019 LK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKBaseModel : NSObject

+ (id)modelWithDict:(NSDictionary *)dict;

- (void)loadData:(NSDictionary *)dict;

@end
