//
//  LKInfoViewController.m
//  LKMagicIO
//
//  Created by LK on 2019/12/5.
//  Copyright © 2019 LK. All rights reserved.
//

#import "LKInfoViewController.h"
#import "LKInfoModel.h"

@interface LKInfoViewController ()
@property (nonatomic,strong) LKBaseTableView *tableview;
@property (nonatomic,strong) LKInfoModel *model;
@end

@implementation LKInfoViewController

- (LKBaseTableView *)tableview{
    if (!_tableview) {
        _tableview = [[LKBaseTableView alloc] initWithFrame:CGRectMake(0, 0,LKScreenSize.width,LKScreenSize.height) style:UITableViewStylePlain];
    }
    return _tableview;
}

- (LKInfoModel *)model{
    if (!_model) {
        _model = [LKInfoModel new];
    }
    return _model;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"手机信息";
    if (LK_available(11.0)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#3B444C"];
    [self.view addSubview:self.tableview];
    
    self.tableview.selectRowBlock = ^(id data, NSIndexPath *indexPath) {
        
    };
    self.tableview.didScrollBlock = ^(CGFloat offsetY) {
        
    };
    
    [self.model loadData:nil];
    self.tableview.sections = self.model.sections;
    [self.tableview reloadData];
}

@end
