//
//  SkillTableViewCell.h
//  LOLInfo
//
//  Created by qianfeng on 16/4/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkillTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *skillNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *skilldescLabel;
@property (weak, nonatomic) IBOutlet UILabel *cdLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;

- (void)loadDataFromSkillArr:(NSArray *)skillArr;

@end
