//
//  LKBaseTableViewCellModel.h
//  LKMagicIO
//
//  Created by LK on 2019/12/2.
//  Copyright © 2019 LK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKBaseTableViewCellModel : NSObject
@property (nonatomic,strong) Class cellClass;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,strong) id data;
@property (nonatomic,strong) NSIndexPath *indexPath;

@end

@interface LKBaseTableViewSecitonModel : NSObject
@property (nonatomic,copy) NSArray <LKBaseTableViewCellModel *> *rows;

/**
 *  表头
 *  header的字控件,里面包了一层contentView,可直接设置坐标x,
 **/
@property (nonatomic,strong) UIView *headerView;
/**
 *  表尾
 *  footer的字控件,里面包了一层contentView,可直接设置坐标x,
 **/
@property (nonatomic,strong) UIView *footerView;

/**
 *  不设置,默认取headerView的高度,设置了则优先取该高度
 **/
@property (nonatomic,assign) CGFloat headerHeight;
/**
 *  不设置,默认取footerView的高度
 **/
@property (nonatomic,assign) CGFloat footerHeight;

@end
