//
//  BaseTableViewCell.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell


- (void)loadDataFromModel:(BaseModel *)model {
    //图标
    [_iconImageView setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"top_page_view_default"]];

    //标题
    _titleLabel.text = model.title;
    
    //详情
    _infoLabel.text = model.shortStr;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
