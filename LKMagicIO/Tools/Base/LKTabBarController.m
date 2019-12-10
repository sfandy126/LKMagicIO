//
//  LKTabBarController.m
//  LKMagicIO
//
//  Created by LK on 2019/12/5.
//  Copyright © 2019 LK. All rights reserved.
//

#import "LKTabBarController.h"
#import "LKInfoViewController.h"
#import "LKExtendListViewController.h"

@interface LKTabBarController ()

@end

@implementation LKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    LKNavigationController *info = [[LKNavigationController alloc] initWithRootViewController:[LKInfoViewController new]];
    info.title = @"系统信息";
    LKNavigationController *extend = [[LKNavigationController alloc] initWithRootViewController:[LKExtendListViewController new]];
    extend.title = @"扩展列表";
    [self addChildViewController:info];
    [self addChildViewController:extend];
    
    self.selectedIndex = 0;
}



@end
