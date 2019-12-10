//
//  LKInfoTableViewCell.m
//  LKMagicIO
//
//  Created by LK on 2019/12/2.
//  Copyright © 2019 LK. All rights reserved.
//

#import "LKInfoTableViewCell.h"
#import "LKInfoModel.h"

@interface LKInfoTableViewCell ()
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *subTitleLab;

@end

@implementation LKInfoTableViewCell

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.text = @"";
        _titleLab.font = LKFont(14);
        _titleLab.textColor = [UIColor colorWithHexString:@"#808C99"];
    }
    return _titleLab;
}

- (UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = [UILabel new];
        _subTitleLab.text = @"";
        _subTitleLab.font = LKFont(12);
        _subTitleLab.textColor = [UIColor colorWithHexString:@"#808C99"];
    }
    return _subTitleLab;
}

- (void)initView{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.subTitleLab];

    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setCellModel:(LKBaseTableViewCellModel *)cellModel{
    LKInfoItem *item = cellModel.data;
    if (!item || ![item isKindOfClass:[LKInfoItem class]]) {
        return;
    }
    self.titleLab.text = item.title;
    self.subTitleLab.text = item.subTitle;
}

@end
