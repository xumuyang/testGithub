//
//  BaseViewController.h
//  LOLInfo
//
//  Created by qianfeng on 16/4/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/** 列表*/
@property (nonatomic,strong) UITableView *tableView;
/** 数据源*/
@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSMutableArray *recommArr;
/** 网址*/
@property (nonatomic,copy) NSString *url;
/** 页数控制*/
@property (nonatomic,assign) int page;
/** 设置网址*/

- (void)setMyUrl;

/** 请求数据*/

- (void)loadData;






@end
