//
//  BaseHeroViewController.h
//  LOLInfo
//
//  Created by qianfeng on 16/4/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseHeroViewController : UIViewController

/** 列表*/
@property (nonatomic,strong) UITableView *tableView;
/** 数据源*/
@property (nonatomic,strong) NSMutableArray *dataArray;
/** 存储英雄的大数组*/
@property (nonatomic,strong) NSMutableArray *heroArr;
/** 存储分类后段的标题*/
@property (nonatomic,strong) NSMutableArray *titleArr;
/** 网址*/
@property (nonatomic,strong) NSString *url;

//设置网址
- (void)setMyUrl;
//请求数据
- (void)loadData;



@end
