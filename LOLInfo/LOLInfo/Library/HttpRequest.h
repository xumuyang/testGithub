//
//  HttpRequest.h
//  LOLInfo
//
//  Created by qianfeng on 16/4/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject

+ (void)startRequestFromUrl:(NSString *)url AndParameter:(NSDictionary *)parameter returnData:(void (^)(NSData *resultData,NSError *error))returnBlock;

@end
