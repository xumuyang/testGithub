//
//  NormalTableViewCell.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "NormalTableViewCell.h"

@implementation NormalTableViewCell

- (void)loadDataFromModel:(FindModel *)model {
    //标题
    _titleLabel.text = model.title;
    //详情
    _infoLabel.text = model.intro;
    //图片
    [_iconImageView setImageWithURL:[NSURL URLWithString:model.kpic] placeholderImage:[UIImage imageNamed:@"default_hero_head"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
