//
//  LKBaseTableView.m
//  LKMagicIO
//
//  Created by LK on 2019/12/2.
//  Copyright © 2019 LK. All rights reserved.
//

#import "LKBaseTableView.h"

NS_INLINE NSString *LKCellIdentifier(Class cellClass, NSString * _Nullable nibName, NSString * _Nullable kind) {
    return [NSString stringWithFormat:@"%@%@%@", kind ?: @"", nibName ?: @"", NSStringFromClass(cellClass)];
}

@interface LKBaseTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableSet<Class > *registeredCellClasses;
@end

@implementation LKBaseTableView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config{
    self.backgroundColor = [UIColor clearColor];
    self.delegate = self;
    self.dataSource = self;
    
    self.tableHeaderView = nil;
    self.tableFooterView = [self emptyView];
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (UIView *)emptyView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark getter

- (NSMutableSet<Class> *)registeredCellClasses{
    if (!_registeredCellClasses) {
        _registeredCellClasses = [NSMutableSet new];
    }
    return _registeredCellClasses;
}

#pragma mark private method

- (LKBaseTableViewSecitonModel *)getSectionData:(NSInteger )section{
    if (section < self.sections.count) {
        LKBaseTableViewSecitonModel *sectionModel = [self.sections objectAtIndex:section];
        return sectionModel;
    }
    return nil;
}

- (LKBaseTableViewCellModel *)getCellData:(NSIndexPath *)indexPath{
    if (indexPath.section < self.sections.count) {
        LKBaseTableViewSecitonModel *sectionModel = [self getSectionData:indexPath.section];
        LKBaseTableViewCellModel *cellModel = [sectionModel.rows objectAtIndex:indexPath.row];
        return cellModel;
    }
    return nil;
}

#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.sections.count>0) {
        return self.sections.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LKBaseTableViewSecitonModel *sectionModel = [self getSectionData:section];
    if (sectionModel) {
        return sectionModel.rows.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LKBaseTableViewCellModel *cellModel = [self getCellData:indexPath];
    if (!cellModel || !cellModel.cellClass) {
        NSAssert(0, @"无效cell"); return nil;
    }
    Class cellClass = cellModel.cellClass;
    NSString *cellIdentify = LKCellIdentifier(cellClass,nil, nil);
    
    if (![self.registeredCellClasses containsObject:cellClass]) {
        [self registerClass:cellClass forCellReuseIdentifier:cellIdentify];
        [self.registeredCellClasses addObject:cellClass];
    }
    LKBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify forIndexPath:indexPath];
    cellModel.indexPath = indexPath;
    cell.cellModel = cellModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LKBaseTableViewCellModel *cellModel = [self getCellData:indexPath];
    if (cellModel) {
        return cellModel.height;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LKBaseTableViewSecitonModel *sectionModel = [self getSectionData:section];
    if (sectionModel && sectionModel.headerView) {
        UIView *contentView = [UIView new];
        contentView.backgroundColor = [UIColor clearColor];
        [contentView addSubview:sectionModel.headerView];
        return contentView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    LKBaseTableViewSecitonModel *sectionModel = [self getSectionData:section];
    if (sectionModel && sectionModel.headerView) {
        if (sectionModel.headerHeight>CGFLOAT_MIN) {
            return sectionModel.headerHeight;
        }
        return sectionModel.headerView.frame.size.height;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LKBaseTableViewSecitonModel *sectionModel = [self getSectionData:section];
    if (sectionModel && sectionModel.footerView) {
        UIView *contentView = [UIView new];
        contentView.backgroundColor = [UIColor clearColor];
        [contentView addSubview:sectionModel.footerView];
        return contentView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    LKBaseTableViewSecitonModel *sectionModel = [self getSectionData:section];
    if (sectionModel && sectionModel.footerView) {
        if (sectionModel.footerHeight>CGFLOAT_MIN) {
            return sectionModel.footerHeight;
        }
        return sectionModel.footerView.frame.size.height;
    }
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectRowBlock) {
        LKBaseTableViewCellModel *cellModel = [self getCellData:indexPath];
        self.selectRowBlock(cellModel.data, indexPath);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.didScrollBlock) {
        self.didScrollBlock(scrollView.contentOffset.y);
    }
}

@end




