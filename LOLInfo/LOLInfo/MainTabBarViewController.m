//
//  MainTabBarViewController.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "NewsViewController.h"
#import "HeroViewController.h"
#import "FindViewController.h"
#import "MeViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTabBar];
}

- (void)createTabBar {
    NewsViewController *news = [[NewsViewController alloc] init];
    HeroViewController *hero = [[HeroViewController alloc] init];
    FindViewController *find = [[FindViewController alloc] init];
    MeViewController *me = [[MeViewController alloc] init];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:news,hero,find,me, nil];
    
    //标题
    NSArray *titleArr = @[@"新闻",@"英雄",@"发现",@"我"];
    //图片
    NSArray *normalArr = @[@"tab_icon_news_normal@2x",@"tab_icon_friend_normal@2x",@"tab_icon_quiz_normal@2x",@"tab_icon_more_normal@2x"];
    NSArray *selectedArr = @[@"tab_icon_news_press@2x",@"tab_icon_friend_press@2x",@"tab_icon_quiz_press@2x",@"tab_icon_more_press@2x"];
    //标签栏
    for (int i = 0 ; i < array.count; i++) {
        //得到每个视图控制器
        UIViewController *vc = array[i];
        //视图控制器->导航控制器
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        //替换(视图控制器替换为导航控制器)
        [array replaceObjectAtIndex:i withObject:nav];
        //标题
        vc.title = titleArr[i];
        //图片
        //渲染模式:保证显示图片与给定图片色调一致
        UIImage *normalImage = [UIImage imageNamed:normalArr[i]];
        UIImage *selectedImage = [UIImage imageNamed:selectedArr[i]];
        //进行渲染后赋值
        nav.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    self.viewControllers = array;
}



@end
