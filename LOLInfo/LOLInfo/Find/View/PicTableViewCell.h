//
//  PicTableViewCell.h
//  LOLInfo
//
//  Created by qianfeng on 16/4/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"

@interface PicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

-(void)loadDataFromModel:(FindModel *)model;
@end
