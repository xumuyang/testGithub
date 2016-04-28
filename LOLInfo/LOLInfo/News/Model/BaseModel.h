//
//  BaseModel.h
//  LOLInfo
//
//  Created by qianfeng on 16/4/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

/** 图标*/
@property (nonatomic,copy) NSString *icon;

/** 标题*/
@property (nonatomic,copy) NSString *title;

/** 详情*/
@property (nonatomic,copy) NSString *shortStr;

/** id*/
@property (nonatomic,copy) NSString *idStr;


@end
