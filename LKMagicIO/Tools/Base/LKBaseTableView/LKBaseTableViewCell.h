//
//  LKBaseTableViewCell.h
//  LKMagicIO
//
//  Created by LK on 2019/12/2.
//  Copyright © 2019 LK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKBaseTableViewCellModel.h"

@interface LKBaseTableViewCell : UITableViewCell
@property (nonatomic,strong) LKBaseTableViewCellModel *cellModel;

- (void)initView;

@end

