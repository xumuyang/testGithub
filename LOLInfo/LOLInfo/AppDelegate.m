//
//  AppDelegate.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "UMSocial.h"//友盟相关头文件
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import <SMS_SDK/SMSSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    
    //设置短信SDK的AppKey
    [SMSSDK registerApp:@"11a8f338cecf2" withSecret:@"e97f49f0bfffb20f91e8f0e38609f292"];
    
    //设置友盟AppKey
    [UMSocialData setAppKey:@"5629925367e58e55140015c0"];
    //开启微信分享的功能
    //3个参数均为在微信开放者平台申请获得
    [UMSocialWechatHandler setWXAppId:@"wx87a53db0526ec705" appSecret:@"304dc6f2b158e4d704af9682f451a496" url:@"http://www.1000phone.com"];
    
    [UMSocialQQHandler setQQWithAppId:@"1104944589" appKey:@"oaraqjCJ2CWOjasn" url:@"http://www.sure.com"];
    
    /*
     QQ+腾讯QQ互联应用appId转换成十六进制(不足8位前面补0)
     QQ41DC1DCD
     tencent1104944589
     
     */
    
    
    //统一设置某控件的显示效果
    [[UINavigationBar appearance]setBarStyle:UIBarStyleBlack];
    
    
    [_window makeKeyAndVisible];
    
    _window.rootViewController = [[MainTabBarViewController alloc] init];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation {
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK,例如支付宝SDK等
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
