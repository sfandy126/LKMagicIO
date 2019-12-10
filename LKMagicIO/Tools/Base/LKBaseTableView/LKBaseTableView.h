//
//  LKBaseTableView.h
//  LKMagicIO
//
//  Created by LK on 2019/12/2.
//  Copyright © 2019 LK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKBaseTableViewCell.h"

@interface LKBaseTableView : UITableView

@property (nonatomic,copy) NSArray<LKBaseTableViewSecitonModel *> *sections;

@property (nonatomic,copy) void (^selectRowBlock)(id data, NSIndexPath *indexPath);
@property (nonatomic,copy) void (^didScrollBlock)(CGFloat offsetY);

@end



