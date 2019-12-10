//
//  LKBaseTableViewCellModel.m
//  LKMagicIO
//
//  Created by LK on 2019/12/2.
//  Copyright © 2019 LK. All rights reserved.
//

#import "LKBaseTableViewCellModel.h"

@implementation LKBaseTableViewCellModel

@end

@implementation LKBaseTableViewSecitonModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerHeight = CGFLOAT_MIN;
        self.footerHeight = CGFLOAT_MIN;
    }
    return self;
}

@end
