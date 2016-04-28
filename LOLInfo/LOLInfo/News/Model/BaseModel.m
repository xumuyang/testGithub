//
//  BaseModel.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

//赋值
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"short"]) {
        _shortStr = value;
    }
    if ([key isEqualToString:@"id"]) {
        _idStr = value;
    }
}
//取值
- (instancetype)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
