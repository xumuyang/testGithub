//
//  NewsViewController.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "NewsViewController.h"
#import "SCNavTabBarController.h"
#import "LatestViewController.h"
#import "ActivityViewController.h"
#import "GameViewController.h"
#import "TopicViewController.h"
#import "PicViewController.h"
#import "OfficalViewController.h"
#import "GirlViewController.h"
#import "TacticViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createControllers];
}

- (void)createControllers {
    LatestViewController *latest = [[LatestViewController alloc] init];
    latest.title = @"最新";
    ActivityViewController *activity = [[ActivityViewController alloc]init];
    activity.title = @"活动";
    GameViewController *game = [[GameViewController alloc] init];
    game.title = @"赛事";
    TopicViewController *topic = [[TopicViewController alloc] init];
    topic.title = @"神贴";
    PicViewController *pic = [[PicViewController alloc] init];
    pic.title = @"囧图";
    OfficalViewController *offical = [[OfficalViewController alloc] init];
    offical.title = @"官方";
    GirlViewController *girl = [[GirlViewController alloc] init];
    girl.title = @"美女";
    TacticViewController *tactic = [[TacticViewController alloc] init];
    tactic.title = @"攻略";
    
    //创建SCNav对象
    SCNavTabBarController *scNav = [[SCNavTabBarController alloc] init];
    //管理视图控制器
    scNav.subViewControllers = @[latest,activity,game,topic,offical,girl,tactic];
    //更改导航栏颜色
    [scNav setNavTabBarColor:[UIColor colorWithRed:35/255.0 green:43/255.0 blue:60/255.0 alpha:0.5]];
    //底色
    self.view.backgroundColor = [UIColor colorWithRed:55/255.0 green:63/255.0 blue:80/255.0 alpha:1];
    //执行管理
    [scNav addParentController:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    //更改状态栏的颜色(首先需要在info.plist中设置键值对)
    //
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
