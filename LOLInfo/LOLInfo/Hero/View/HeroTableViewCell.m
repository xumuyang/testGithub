//
//  HeroTableViewCell.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "HeroTableViewCell.h"

@implementation HeroTableViewCell

- (void)loadDataFromModel:(HeroModel *)model {
    //头像
    [_iconImageView setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"top_page_view_default"]];
    //姓名
    _nameLabel.text = model.name_c;
    //昵称
    _nickNameLabel.text = model.title;
    //定位
    _tagLabel.text = model.tags;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
