//
//  PicTableViewCell.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/14.
//  Copyright © 2016年 qianfeng. All rights reserved.

#import "PicTableViewCell.h"

@implementation PicTableViewCell

-(void)loadDataFromModel:(FindModel *)model {
    //标题和图片
    _titleLabel.text = model.title;
    //
    NSArray *picArr = model.pics[@"list"];
    //循环创建图片
    float height = _scrollView.bounds.size.height;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(picArr.count * 100 + (picArr.count - 1)*10, height);
    for (int i = 0; i < picArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(110 * i, 0, 100, height)];
        NSDictionary *dict = picArr[i];
        [imageView setImageWithURL:[NSURL URLWithString:dict[@"kpic"]] placeholderImage:[UIImage imageNamed:@"default_hero_head"]];
        [_scrollView addSubview:imageView];
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
