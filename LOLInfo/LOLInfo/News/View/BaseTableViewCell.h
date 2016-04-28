//
//  BaseTableViewCell.h
//  LOLInfo
//
//  Created by qianfeng on 16/4/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"


@interface BaseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


- (void)loadDataFromModel:(BaseModel *)model;

@end
