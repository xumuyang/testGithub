//
//  DetailModel.h
//  LOLInfo
//
//  Created by qianfeng on 16/4/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

/** 背景故事*/
@property (nonatomic,copy) NSString  *background;

@property (nonatomic,copy) NSString  *analyse;

@property (nonatomic,copy) NSString  *talent_desc;

@property (nonatomic,strong) NSArray *skill;



@end
