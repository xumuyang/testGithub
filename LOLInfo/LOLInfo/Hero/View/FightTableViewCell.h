//
//  FightTableViewCell.h
//  LOLInfo
//
//  Created by qianfeng on 16/4/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FightTableViewCell : UITableViewCell
//该自定义cell存在多label自适应问题.需要调节约束权重(优先级)
@property (weak, nonatomic) IBOutlet UILabel *useLabel;
@property (weak, nonatomic) IBOutlet UILabel *fightLabel;

@end
