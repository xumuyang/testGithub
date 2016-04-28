
//
//  HeroDetailViewController.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "HeroDetailViewController.h"
#import "HttpRequest.h"
#import "SkillTableViewCell.h"
#import "StoryTableViewCell.h"
#import "FightTableViewCell.h"
#import "DetailModel.h"
#import "FMDBManager.h"

@interface HeroDetailViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

/** 列表*/
@property (nonatomic,strong) UITableView *tableView;
/** <#name#>*/
@property (nonatomic,strong) UIImageView *topImageView;
/** 跟随线条*/
@property (nonatomic,strong) UIView *line;
/** 描述切换标识*/
@property (nonatomic,assign) int index;
/** 数据源*/
@property (nonatomic,strong) NSMutableArray *dataArr
;





@end

@implementation HeroDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //设置导航栏透明操作
    
    //1.透明图片  2.横竖屏(默认竖屏)
    //透明图片
    UIImage *image = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:image  forBarMetrics:UIBarMetricsDefault];
    
    //判断该英雄是否收藏
    FMDBManager *manager = [FMDBManager sharedFMDBManager];
    BOOL isInsert = [manager isExistWithHeroID:_heroID];
    if (isInsert) {
        //设置按钮不可点击
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.navigationItem.rightBarButtonItem.title = @"已购买";
    }else {
        
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //回归没有设置导航栏的样式
    //设置空的图片
    UIImage *image = [UIImage imageNamed:@""];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [[NSMutableArray alloc] init];
    
    [self craeteUI];
    
    [self loadData];
}

- (void)loadData {
    [HttpRequest startRequestFromUrl:[NSString stringWithFormat:kHeroDetailInfoUrlString,_heroID] AndParameter:nil returnData:^(NSData *resultData, NSError *error) {
        if (!error) {
            //解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *resultDict = dict[@"result"];
            //顶部图片
            [_topImageView setImageWithURL:[NSURL URLWithString:resultDict[@"img_top"]] placeholderImage:[UIImage imageNamed:@"heroDefaultBG.png"]];
            //建立数据模型
            DetailModel *model = [[DetailModel alloc] init];
            [model setValuesForKeysWithDictionary:resultDict];
            [_dataArr addObject:model];
            //刷新UI
            [_tableView reloadData];
        }else {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
}

- (void)craeteUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    /*
     Xcode6.3以后Label自适应Cell问题需要添加额外设置
     */
    //1.允许自适应操作
    _tableView.rowHeight = UITableViewAutomaticDimension;
    //2.设置预计行高
    _tableView.estimatedRowHeight = 44.0;
    
    
    //注册Cell
    [_tableView registerNib:[UINib nibWithNibName:@"SkillTableViewCell" bundle:nil] forCellReuseIdentifier:@"SKILL"];
    [_tableView registerNib:[UINib nibWithNibName:@"StoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"STORY"];
    [_tableView registerNib:[UINib nibWithNibName:@"FightTableViewCell" bundle:nil] forCellReuseIdentifier:@"FIGHT"];
    
    
    
    //contentInset 额外的滑动区域 上左下右 4个参数的意思均为使当前视图在原坐标的基础上进行调节
    _tableView.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);

    //顶部视图
    _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -150, SCREEN_WIDTH, 150)];
    _topImageView.image = [UIImage imageNamed:@"heroDefaultBG"];
    //以addSubView的方式加载到TableView上
    [_tableView addSubview:_topImageView];
    
    //更改图片显示模式 停靠模式 不论如何缩放 显示比例不变
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    //去除多余视图
    _topImageView.clipsToBounds = YES;
    
    //描述切换
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    bgView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    
    NSArray *titleArr = @[@"英雄技能",@"背景故事",@"战斗技巧"];
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        button.frame = CGRectMake((SCREEN_WIDTH / 3 )*i, 0, SCREEN_WIDTH / 3, 40);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 500 + i;
        [bgView addSubview:button];
    }
    //线条
    _line = [[UIView alloc]initWithFrame:CGRectMake(0, 35, SCREEN_WIDTH / 3, 5)];
    _line.backgroundColor = [UIColor cyanColor];
    [bgView addSubview:_line];
    //添加头视图
    _tableView.tableHeaderView = bgView;
    
    //购买按钮
    UIBarButtonItem *buyItem = [[UIBarButtonItem alloc]initWithTitle:@"购买" style:UIBarButtonItemStylePlain target:self action:@selector(buyClick)];
    self.navigationItem.rightBarButtonItem = buyItem;
}

- (void)buyClick {
    //收藏操作 FMDB CoreData 数据库类的设计(方法?属性?)如何防止重复购买
    FMDBManager *manager = [FMDBManager sharedFMDBManager];
    BOOL isSuc = [manager insertHeroID:_heroID];
    if (isSuc) {
        //更改不可点击与文字
        self.navigationItem.rightBarButtonItem.title = @"已购买";
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)buttonClick:(UIButton *)button {
    //切换跟随线条
    [UIView animateWithDuration:0.5 animations:^{
        _line.frame = CGRectMake((button.tag - 500) * SCREEN_WIDTH / 3, 35, SCREEN_WIDTH / 3, 5);
    }];
    //切换描述
    _index = (int)button.tag - 500;
    //刷新UI
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailModel *model = _dataArr[indexPath.row];
    if (_index == 0) {
        //技能
        SkillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKILL" forIndexPath:indexPath];
        //传递数据给自定义cell
        [cell loadDataFromSkillArr:model.skill];
        return  cell;
    }else if (_index == 1) {
        StoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"STORY" forIndexPath:indexPath];
        cell.storyLabel.text = model.background;
        return  cell;

    }else {
        //战斗技巧
        FightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FIGHT" forIndexPath:indexPath];
        //赋值
        cell.useLabel.text = model.analyse;
        cell.fightLabel.text = model.talent_desc;
        return  cell;
    }
}

//滑动即触发的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offSet = scrollView.contentOffset.y;
    //判断滑动方向
    if (offSet < -150) {
        //下拉
        //获取图片原有坐标
        CGRect rect = _topImageView.frame;//(0,-150,SCREEN_WIDTH,150);
        //CGRect结构体 CGPoint CGSize
        //1.图片顶点始终顶在屏幕上方(1.图片的顶点坐标不断在减小 2.减小的大小为上方留白)
        rect.origin.y = offSet;//-150 - (-offSet - 150);
        //2.图片高度随下拉而增大
        rect.size.height = -offSet; //  150 + (-offSet - 150);
        //重置顶部视图坐标
        _topImageView.frame = rect;
    }
}


@end
