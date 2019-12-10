//
//  UIDevice+IO.h
//  LKMagicIO
//
//  Created by LK on 2019/12/2.
//  Copyright © 2019 LK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (IO)

///获取当前电池的状态比例
+ (CGFloat )getBatteryQuantity;

///获取总内存大小
+ (long long)getTotalMemorySize;

///获取当前可用内存
+ (long long)getAvailableMemorySize;

///获取总磁盘容量
+ (long long)getTotalDiskSize;

///获取可用磁盘容量
+ (long long)getAvailableDiskSize;

///获取CPU架构类型
+ (NSString *)getCPUType;

///获取mac 地址
+ (NSString *) getMacAddress;

///获取ip 地址
+ (NSString *)getIPAddress;

@end

NS_ASSUME_NONNULL_END
