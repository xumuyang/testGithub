//
//  FindModel.h
//  LOLInfo
//
//  Created by qianfeng on 16/4/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindModel : NSObject

/** 标题*/
@property (nonatomic,copy) NSString *title;
/** 详情*/
@property (nonatomic,copy) NSString *intro;
/** 图片*/
@property (nonatomic,copy) NSString *kpic;
/** 多张图片*/
@property (nonatomic,strong) NSDictionary *pics;





@end
