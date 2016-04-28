//
//  SkillTableViewCell.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "SkillTableViewCell.h"

@interface SkillTableViewCell ()
/**
 *  全局变量数组
 */
@property (nonatomic,strong) NSArray *arr;

@end

@implementation SkillTableViewCell

- (void)loadDataFromSkillArr:(NSArray *)skillArr {
    _arr = skillArr;
    NSDictionary *dict = skillArr.firstObject;
    //技能名称
    _skillNameLabel.text = dict[@"name"];
    //技能描述
    _skilldescLabel.text = dict[@"desc"];
    //cd
    _cdLabel.text = dict[@"cd"];
    //消耗
    _costLabel.text = dict[@"cost"];
    //循环创建技能图片与描述
    for (int i = 0; i < skillArr.count; i++) {
        //取数据
        NSDictionary *skillDict = skillArr[i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50 * i , 0, 40, 40)];
        imageView.backgroundColor = [UIColor yellowColor];
        [imageView setImageWithURL:[NSURL URLWithString:skillDict[@"img"]] placeholderImage:[UIImage imageNamed:@"default_hero_head"]];
        [_bgView addSubview:imageView];
        
        //图片添加手势获取点击事件
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        imageView.tag = 600 + i;
        
        //label
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50 * i, 40, 40, 10)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:13];
        label.text = skillDict[@"key"];
        [_bgView addSubview:label];
    }
}

- (void)tap:(UIGestureRecognizer *)tap {
    UIImageView *tapImageView = (UIImageView *)tap.view;
    int index = (int)tapImageView.tag - 600;
    //重新赋值下方label
    NSDictionary *dict = _arr[index];
    _skillNameLabel.text = dict[@"name"];
    _skilldescLabel.text = dict[@"desc"];
    _cdLabel.text = dict[@"cd"];
    _costLabel.text = dict[@"cost"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
