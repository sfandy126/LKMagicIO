//
//  UINavigationController+LKConfig.m
//  LKMagicIO
//
//  Created by LK on 2019/12/5.
//  Copyright © 2019 LK. All rights reserved.
//

#import "UINavigationController+LKConfig.h"

@implementation UINavigationController (LKConfig)

+ (void)load{
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc]init]];
}

@end
