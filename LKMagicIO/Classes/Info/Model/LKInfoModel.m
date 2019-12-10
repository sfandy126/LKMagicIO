//
//  LKInfoModel.m
//  LKMagicIO
//
//  Created by LK on 2019/12/5.
//  Copyright © 2019 LK. All rights reserved.
//

#import "LKInfoModel.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation LKInfoModel


- (void)loadData:(NSDictionary *)dict{
    
    NSArray *sections = @[@{@"title":@"系统状态",@"list":@[@{@"title":@"设备名称",@"type":@"1"},
                                                        @{@"title":@"系统名称",@"type":@"2"},
                                                        @{@"title":@"系统版本",@"type":@"3"},
                                                        @{@"title":@"设备类型",@"type":@"4"},
                                                        @{@"title":@"UUID",@"type":@"5"},
                                                        @{@"title":@"屏幕分辨率",@"type":@"6"},
                                                        @{@"title":@"运营商",@"type":@"7"},
                                                        @{@"title":@"IP地址",@"type":@"18"},
                                                        @{@"title":@"MAC地址",@"type":@"19"},
                                                        @{@"title":@"磁盘最大容量",@"type":@"21"},
                                                        @{@"title":@"磁盘可用容量",@"type":@"22"},
                                                      ]},
                         @{@"title":@"电池状态",@"list":@[@{@"title":@"电量",@"type":@"8"},
                                                        @{@"title":@"充电状态",@"type":@"9"},
                                                        @{@"title":@"低电量模式",@"type":@"10"},
                                                        @{@"title":@"已开机时长",@"type":@"11"},
                                                      ]},
                         @{@"title":@"cpu信息",@"list":@[@{@"title":@"cpu名称",@"type":@"12"},
                                                        @{@"title":@"处理器",@"type":@"13"},
                                                        @{@"title":@"架构",@"type":@"14"},
                                                        @{@"title":@"物理核数",@"type":@"15"},
                                                        @{@"title":@"逻辑核数",@"type":@"16"},
                                                        @{@"title":@"总内存大小",@"type":@"17"},
                                                        @{@"title":@"当前可用内存大小",@"type":@"20"}
                                                      ]},
                          
                         ];
   
    
    NSMutableArray *tempSections = [NSMutableArray array];
    for (NSDictionary *section in sections) {
        LKBaseTableViewSecitonModel *sectionModel = [LKBaseTableViewSecitonModel new];
        UILabel *sectionView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        sectionView.font = LKFont(16);
        sectionView.backgroundColor = [UIColor colorWithHexString:@"#3B444C"];
        sectionView.textColor = [UIColor colorWithHexString:@"#808C99"];
        sectionView.text = [section valueForKey:@"title"];
        sectionView.left = 15;
        sectionModel.headerView = sectionView;
        
        NSArray *list = [section valueForKey:@"list"];
        NSMutableArray *tempRows = [NSMutableArray array];
        for (NSDictionary *row in list) {
            LKBaseTableViewCellModel *item = [LKBaseTableViewCellModel new];
            item.cellClass = [LKInfoTableViewCell class];
            LKInfoItem *model = [LKInfoItem modelWithDict:row];
            model.subTitle = [self getSectionSubTitle:[row valueForKey:@"type"]];
            item.data = model;
            item.height = 40;
            if (item.data) {
                [tempRows addObject:item];
            }
        }
        
        if (tempRows.count>0) {
            sectionModel.rows = [tempRows copy];
            [tempSections addObject:sectionModel];
        }
    }
    self.sections = [tempSections copy];
}

- (NSString *)getSectionSubTitle:(NSString *)type{
    NSString *subTitle = @"";
    switch ([type integerValue]) {
        case 1:
        {
            subTitle = [UIDevice currentDevice].name;
        }
            break;
        case 2:
        {
            subTitle = [UIDevice currentDevice].systemName;
        }
            break;
        case 3:
        {
            subTitle = [UIDevice currentDevice].systemVersion;
        }
            break;
        case 4:
        {
            subTitle = [UIDevice currentDevice].model;
        }
            break;
        case 5:
        {
            subTitle = [UIDevice currentDevice].identifierForVendor.UUIDString;
        }
            break;
        case 6:
        {
            CGFloat scale = [UIScreen mainScreen].scale;
            CGSize size = [UIScreen mainScreen].bounds.size;
            subTitle = [NSString stringWithFormat:@"%0.fx%0.f",size.width*scale,size.height*scale];
        }
            break;
        case 7:
        {
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            CTCarrier *carrier = [info subscriberCellularProvider];
            //先判断有没有SIM卡，如果没有则不获取本机运营商
            if (!carrier.isoCountryCode) {
                subTitle = @"无运营商";
            }else{
                subTitle = [carrier carrierName];
            }
        }
            break;
        case 8:
        {
            [UIDevice currentDevice].batteryMonitoringEnabled = YES;
            subTitle = [NSString stringWithFormat:@"%0.f%%",[UIDevice currentDevice].batteryLevel*100];
        }
            break;
        case 9:
        {
            UIDeviceBatteryState state = [UIDevice currentDevice].batteryState;
            if (state == UIDeviceBatteryStateFull) {
                subTitle = @"连接充满状态";
            }else if (state == UIDeviceBatteryStateCharging){
                subTitle = @"正在充电...";
            }else{
                subTitle = @"无法获取充电状态";
            }
        }
            break;
        case 10:
        {   //NSProcessInfoPowerStateDidChangeNotification
            if ([NSProcessInfo processInfo].isLowPowerModeEnabled) {
                subTitle = @"低电量模式开启";
            }else{
                subTitle = @"低电量模式关闭";
            }
        }
            break;
        case 11:
        {
            subTitle = [NSString formatDayStringForTimestamp:([[NSDate date] timeIntervalSince1970] - [NSProcessInfo processInfo].systemUptime)];
        }
            break;
        case 12:
        {
            
        }
            break;
        case 13:
        {
            
        }
            break;
        case 14:
        {
            subTitle = [UIDevice getCPUType];
        }
            break;
        case 15:
        {
            
        }
            break;
        case 16:
        {
            
        }
            break;
        case 17:
        {
            // 获取总内存大小
            subTitle = [NSString formatGBString:[UIDevice getTotalMemorySize]];
            
        }
            break;
        case 18:
        {
            subTitle = [UIDevice getIPAddress];
        }
            break;
        case 19:
        {
           subTitle = [UIDevice getMacAddress];
        }
            break;
        case 20:
        {
            subTitle = [NSString formatGBString:[UIDevice getAvailableMemorySize]];
        }
            break;
        case 21:
        {
            subTitle = [NSString formatGBString:[UIDevice getTotalDiskSize]];
        }
            break;
        case 22:
        {
            subTitle = [NSString formatGBString:[UIDevice getAvailableDiskSize]];
        }
            break;
    }

    return subTitle;
}

@end


@implementation LKInfoItem

+ (id)modelWithDict:(NSDictionary *)dict{
    if ([NSDictionary isNotEmptyDict:dict]) {
        LKInfoItem *item = [LKInfoItem new];
        item.title = [NSString stringValue:[dict valueForKey:@"title"]];
        item.subTitle = [NSString stringValue:[dict valueForKey:@"subTitle"]];
        item.type = [NSString stringValue:[dict valueForKey:@"type"]];
        return item;
    }
    return nil;
}

@end
