//
//  BaseHeroViewController.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "BaseHeroViewController.h"
#import "HeroTableViewCell.h"
#import "HttpRequest.h"
#import "HeroModel.h"
#import "PinYinForObjc.h"
#import "HeroDetailViewController.h"//英雄详情界面

@interface BaseHeroViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BaseHeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self createTableView];
    
    //设置网址
    [self setMyUrl];
    //请求数据
    [self loadData];//注意:网络请求一定保证网址正确
    
}

- (void)setMyUrl {
    self.url = kAllHeroUrlString;
    
}

- (void)loadData {
    [HttpRequest startRequestFromUrl:self.url AndParameter:nil returnData:^(NSData *resultData, NSError *error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
            NSArray *resultArr = dict[@"result"];
            for (NSDictionary *heroDict in resultArr) {
                //建立数据模型
                HeroModel *model = [[HeroModel alloc] init];
                [model setValuesForKeysWithDictionary:heroDict];
                [_dataArray addObject:model];
            }
            
            //获取每个英雄名转化为对应拼音
            [self chineseToPinyin];
            //刷新UI
            [_tableView reloadData];
        }else{
            
        }
    }];
}

- (void)chineseToPinyin {
    
    
    //建立数据结构
    for (int i = 0; i < 26; i++) {
        //创建小数组
        NSMutableArray *array = [NSMutableArray array];
        //依次添加到大数组中
        [_heroArr addObject:array];
    }
    
    //获取每个英雄
    for (int i = 0; i < _dataArray.count; i++) {
        //获取每个英雄
        HeroModel *model = _dataArray[i];
        //拿到姓名
        NSString *name = model.name_c;
        //转化为拼音
        NSString *pyname = [PinYinForObjc chineseConvertToPinYinHead:name];
        //取得第一个字符
        char firstChar = [pyname characterAtIndex:0];
        //将取得的英雄放置到对应的小数组中
        int index = firstChar - 'a';
        //放入小数组中
        [_heroArr[index] addObject:model];
    }
    //去除空数组
    [_heroArr removeObject:@[]];
    //得到段标题
    for (int i = 0; i < _heroArr.count; i++) {
        //取得剩余每个小数组中第一个英雄
        HeroModel *model = [_heroArr[i]firstObject];
        //名字->拼音
        NSString *heroName = [PinYinForObjc chineseConvertToPinYinHead:model.name_c];
        //取第一个字符
        char firstChar = [heroName characterAtIndex:0];
        //C->OC
        NSString *str = [NSString stringWithFormat:@"%c",firstChar];
        //标题数组存储
        [_titleArr addObject:str];
    }
}

- (void)initData {
    _dataArray = [[NSMutableArray alloc] init];
    _heroArr = [[NSMutableArray alloc] init];
    _titleArr = [[NSMutableArray alloc] init];
}

- (void)createTableView  {
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT- 64 -49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 80;
    [self.view addSubview:_tableView];
    //预留注册cell
    //[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: @"HERO"];
    [_tableView registerNib:[UINib nibWithNibName:@"HeroTableViewCell" bundle:nil] forCellReuseIdentifier:@"HERO"];
}

//返回组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _heroArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_heroArr[section]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HERO" forIndexPath:indexPath];
    //联系数据与视图
    HeroModel *model = _heroArr[indexPath.section][indexPath.row];
    [cell loadDataFromModel:model];
    return cell;
}

//组的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _titleArr[section];
}

//索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _titleArr;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HeroDetailViewController *heroDetail = [[HeroDetailViewController alloc]init];
    HeroModel *model = _heroArr[indexPath.section][indexPath.row];
    heroDetail.heroID = model.idStr;
    heroDetail.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:heroDetail animated:YES];
}
@end
