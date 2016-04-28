//
//  FindViewController.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "FindViewController.h"
#import "HttpRequest.h"
#import "FindModel.h"
#import "NormalTableViewCell.h"
#import "PicTableViewCell.h"

@interface FindViewController ()

/** 数据源*/
@property (nonatomic,strong) NSMutableArray *dataArr;


@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [[NSMutableArray alloc] init];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"NormalTableViewCell" bundle:nil] forCellReuseIdentifier:@"NORMAL"];
     [self.tableView registerNib:[UINib nibWithNibName:@"PicTableViewCell" bundle:nil] forCellReuseIdentifier:@"PIC"];
    
    [self loadData];
}

- (void)loadData {
    [HttpRequest startRequestFromUrl:@"http://api.sina.cn/sinago/list.json?channel=news_toutiao" AndParameter:nil returnData:^(NSData *resultData, NSError *error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDict = dict[@"data"];
            NSArray *listArr = dataDict[@"list"];
            for (NSDictionary *listDict in listArr) {
                //建立数据模型
                FindModel *model = [[FindModel alloc] init];
                [model setValuesForKeysWithDictionary:listDict];
                [_dataArr addObject:model];

            }
            //刷新UI
            [self.tableView reloadData];
        }else {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //加入判断,显示不同的自定义cell
    FindModel *model = _dataArr[indexPath.row];
    if (model.pics.count == 0) {
        //普通
        NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NORMAL" forIndexPath:indexPath];
        [cell loadDataFromModel:model];
        return cell;
    }else {
        //多张图片
        PicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PIC" forIndexPath:indexPath];
        [cell loadDataFromModel:model];
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FindModel *model = _dataArr[indexPath.row];
    if (model.pics.count == 0) {
        return 80.0;
    }else {
        return 100.0;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
