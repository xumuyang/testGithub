//
//  FMDBManager.h
//  LOLInfo
//
//  Created by qianfeng on 16/4/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface FMDBManager : NSObject
/**
 *  Database
 */

@property (nonatomic,strong) FMDatabase *database;
/**
 *  增加英雄ID
 */

- (BOOL)insertHeroID:(NSString *)heroID;
/**
 *  判断英雄是否收藏
 */

- (BOOL)isExistWithHeroID:(NSString *)heroID;
/**
 *  单例创建形式
 */

+(instancetype)sharedFMDBManager;
@end
