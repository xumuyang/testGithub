//
//  FMDBManager.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "FMDBManager.h"

@implementation FMDBManager

+(instancetype)sharedFMDBManager {
    static FMDBManager *manager;
    //考虑线程
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FMDBManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        //1.数据库创建路径(沙盒路径)
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/hero.rdb"];
        //2.创建
        _database = [[FMDatabase alloc]initWithPath:path];
        //3.是否创建成功
        if ([_database open]) {
            NSLog(@"数据库创建成功");
        }else {
            NSLog(@"数据库创建失败");
        }
        //4.表的创建
        NSString *createSql = @"CREATE TABLE IF NOT EXISTS HeroTab (heroID  varchar(256))";
        //5.执行创建
        BOOL isSuc = [_database executeUpdate:createSql];
        if (isSuc) {
            NSLog(@"创建表成功");
        }else {
            NSLog(@"创建表失败");
        }
    }
    return self;
}

- (BOOL)insertHeroID:(NSString *)heroID {
    NSString *insertSql = @"INSERT INTO HeroTab (heroID) values(?)";
    NSLock *lock = [[NSLock alloc]init];
    
    [lock lock];
    BOOL isSuc = [_database executeUpdate:insertSql,heroID];
    [lock unlock];
    if (isSuc) {
        NSLog(@"增加成功");
        return YES;
    }else{
        NSLog(@"增加失败");
        return NO;
    }
}


- (BOOL)isExistWithHeroID:(NSString *)heroID {
    NSString *selectSql = @"SELECT * FROM HeroTab WHERE heroID = ?";
    //调用
    FMResultSet *set = [_database executeQuery:selectSql,heroID];
    if ([set next]) {
        NSLog(@"已收藏");
        return YES;
    }else {
        NSLog(@"未收藏");
        return NO;
    }
}

@end
