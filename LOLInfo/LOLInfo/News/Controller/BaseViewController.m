//
//  BaseViewController.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTableViewCell.h"
#import "HttpRequest.h"
#import "BaseModel.h"
#import "DetailViewController.h"
#import "MMProgressHUD.h"
#import "SVProgressHUD.h"
#import "RecommModel.h"
#import "TopAdScrollView.h"

@interface BaseViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self initData];
    //创建列表
    [self createTableView];
    //请求数据
    [self setMyUrl];
    
    [self loadData];
}

#pragma mark 设置网址
- (void)setMyUrl {
    //加载第一页
    self.url = [NSString stringWithFormat:kLatestNewsUrlString,_page];
}
#pragma mark 加载数据
- (void)loadData {
    
    //显示加载栏
    //[MMProgressHUD showWithTitle:nil status:@"loading"];
    
    [SVProgressHUD showWithStatus:@"loading"];
    [HttpRequest startRequestFromUrl:self.url AndParameter:nil returnData:^(NSData *resultData, NSError *error) {
        if (!error) {
            //解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
            //判断dict.count是否存在
            NSArray *resultArr = dict[@"result"];
            for (NSDictionary *newsDict in resultArr) {
                //创建数据模型,存入数据源
                BaseModel *model = [[BaseModel alloc] init];
                [model setValuesForKeysWithDictionary:newsDict];
                //YYModel JSONModel
                [_dataArr addObject:model];
            }
            //广告滚动视图数据
            NSArray *recommArr = dict[@"recomm"];
            for (NSDictionary *recommDict in recommArr) {
                //建立数据模型
                RecommModel *model = [[RecommModel alloc] init];
                [model setValuesForKeysWithDictionary:recommDict];
                [_recommArr addObject:model];
            }
            
            //创建广告视图
            TopAdScrollView *topAd = [[TopAdScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150) AndPicArr:_recommArr];
            
            //接收传值
            topAd.block = ^(NSString * ID) {
                NSLog(@"传递的ID为:%@",ID);
                //跳转
                DetailViewController *detail = [[DetailViewController alloc] init];
                detail.ID = ID;
                detail.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detail animated:YES];
            };
            _tableView.tableHeaderView = topAd;
            
            //刷新UI
            [_tableView reloadData];
            //去除下拉刷新控件
            [_tableView.header endRefreshing];
            //去除上拉加载控件
            [_tableView.footer endRefreshing];
            //去除加载栏
            //[MMProgressHUD dismissWithSuccess:@"加载成功"];
            [SVProgressHUD dismissWithSuccess:@"加载成功"];
        }else {
            NSLog(@"%@",error.localizedDescription);
            [_tableView.header endRefreshing];
            //去除上拉加载控件
            [_tableView.footer endRefreshing];
            //去除加载栏
            //[MMProgressHUD dismissWithSuccess:@"请求失败"];
            [SVProgressHUD dismissWithSuccess:@"请求失败"];
        }
    }];
}

#pragma mark 初始化数据
- (void)initData {
    //数据源
    _dataArr = [NSMutableArray array];
    _recommArr = [NSMutableArray array];
    //页数控制
    _page = 1;
}

#pragma mark 创建列表
- (void)createTableView {
    //去除继承与ScrollView控件的自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    //创建列表
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 64) style:UITableViewStylePlain];
    _tableView.rowHeight = 80;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //去除未加载数据间隔线
    _tableView.tableFooterView = [[UIView alloc] init];
    //背景图片
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH-64-49)];
    bgImageView.image = [UIImage imageNamed:@"notice_pic_background_default"];
    _tableView.backgroundView = bgImageView;
    //注册
    //[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
    [_tableView registerNib:[UINib nibWithNibName:@"BaseTableViewCell" bundle:nil] forCellReuseIdentifier:@"ID"];
    
    //添加下拉刷新
    [self addDropDownRefresh];
    //上拉加载
    [self addDropUpRefresh];
}

- (void)addDropDownRefresh {
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //1.清空数据,页数归一
        [_dataArr removeAllObjects];
        _page = 1;
        //2.重新请求
        [self setMyUrl];
        [self loadData];
    }];
    //设置动态图片
    NSArray *imageArr = @[[UIImage imageNamed:@"common_loading_anne_0"],[UIImage imageNamed:@"common_loading_anne_1"]];
    [header setImages:imageArr forState:MJRefreshStateRefreshing];
    //设置其他状态
    [header setImages:@[[UIImage imageNamed:@"loading_teemo_1"]] forState:MJRefreshStateIdle];
    //放置在列表上
    _tableView.header = header;
}

- (void)addDropUpRefresh {
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        //页数增加,重新加载数据
        _page++;
        [self setMyUrl];
        [self loadData];
        
    }];
    NSArray *imageArr = @[[UIImage imageNamed:@"common_loading_anne_0"],[UIImage imageNamed:@"common_loading_anne_1"]];
    [footer setImages:imageArr forState:MJRefreshStateRefreshing];
    //放置在列表上
    _tableView.footer = footer;
}

#pragma mark TableViewDel
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //接收注册
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
    
    //加入防止刷新操作崩溃判断
    if (_dataArr.count <= 0) {
        return cell;
    }
    
    //数据与视图联系
    BaseModel *model = _dataArr[indexPath.row];

    [cell loadDataFromModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消默认停留效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //跳转
    DetailViewController *detail = [[DetailViewController alloc] init];
    BaseModel *model = _dataArr[indexPath.row];
    detail.ID = model.idStr;
    //隐藏标签栏控制器
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
