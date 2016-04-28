//
//  HeroModel.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "HeroModel.h"

@implementation HeroModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _idStr = value;
    }
}


- (instancetype)valueForUndefinedKey:(NSString *)key {
    return nil;
}
@end
