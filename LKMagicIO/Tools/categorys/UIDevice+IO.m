//
//  UIDevice+IO.m
//  LKMagicIO
//
//  Created by LK on 2019/12/2.
//  Copyright © 2019 LK. All rights reserved.
//

#import "UIDevice+IO.h"
#include <objc/runtime.h>

#include <sys/types.h>
#include <sys/sysctl.h>
#include <sys/mount.h>

#include <mach/mach.h>
#include <mach/mach_host.h>
#include <mach/host_info.h>
#include <mach/task_info.h>
#include <mach/task.h>

#include <net/if.h>
#include <net/if_dl.h>
#include <net/ethernet.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation UIDevice (IO)

+ (CGFloat )getBatteryQuantity{
    return [[UIDevice currentDevice] batteryLevel];
}

+ (long long)getTotalMemorySize{
    return [NSProcessInfo processInfo].physicalMemory;
}

+ (long long)getAvailableMemorySize{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }

    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

+ (long long)getTotalDiskSize{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return freeSpace;
}

+(long long)getAvailableDiskSize
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
}

+ (NSString *)getCPUType{
    host_basic_info_data_t hostInfo;
    mach_msg_type_number_t infoCount;
    infoCount = HOST_BASIC_INFO_COUNT;
    host_info(mach_host_self(), HOST_BASIC_INFO, (host_info_t)&hostInfo, &infoCount);
    switch (hostInfo.cpu_type) {
        case CPU_TYPE_ARM:
            return @"ARM";
            break;
        case CPU_TYPE_ARM64:
            return @"ARM64";
            break;
        case CPU_TYPE_X86:
            return @"X86";
            break;
        case CPU_TYPE_X86_64:
            return @"X86_64";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *) getMacAddress {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return [outstring uppercaseString];
}

+ (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
            // Loop through linked list of interfaces
          temp_addr = interfaces;
           while(temp_addr != NULL) {
                  if(temp_addr->ifa_addr->sa_family == AF_INET) {
                          // Check if interface is en0 which is the wifi connection on the iPhone
                      if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                             // Get NSString from C String
                                 address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                                }
                        }
                     temp_addr = temp_addr->ifa_next;
                }
       }
     // Free memory
    freeifaddrs(interfaces);
    return address;
}

@end
