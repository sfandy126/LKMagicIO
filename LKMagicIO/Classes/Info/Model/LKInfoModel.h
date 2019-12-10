//
//  LKInfoModel.h
//  LKMagicIO
//
//  Created by LK on 2019/12/5.
//  Copyright © 2019 LK. All rights reserved.
//

#import "LKBaseModel.h"
#import "LKInfoTableViewCell.h"

@class LKInfoItem;
@interface LKInfoModel : LKBaseModel

@property (nonatomic,copy) NSArray *sections;

@end

@interface LKInfoItem : LKBaseModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subTitle;
@property (nonatomic,copy) NSString *type;

@end
