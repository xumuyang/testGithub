//
//  HeroViewController.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "HeroViewController.h"
#import "FreeViewController.h"
#import "AllViewController.h"

@interface HeroViewController ()

/** <#name#>*/
@property (nonatomic,strong) FreeViewController *freeVC;
/** <#name#>*/
@property (nonatomic,strong) AllViewController *allVC;


@end

@implementation HeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI {
    //导航栏颜色与控件颜色
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //seg
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"周免",@"全部"]];
    seg.frame = CGRectMake(0, 0, 150, 30);
    [seg addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    seg.selectedSegmentIndex = 0;
    self.navigationItem.titleView = seg;
    
    //创建视图控制器
    _allVC = [[AllViewController alloc] init];
    [self.view addSubview:_allVC.view];
    
    _freeVC = [[FreeViewController alloc] init];
    [self.view addSubview:_freeVC.view];
    
    //将allVC与freeVC添加到push跳转的栈中
    [self addChildViewController:_allVC];
    [self addChildViewController:_freeVC];
    
}

- (void)segClick:(UISegmentedControl *)seg {
    //调整_freeVC and _allVC
    if (seg.selectedSegmentIndex == 0) {
        //周免视图在最上方
        [self.view bringSubviewToFront:_freeVC.view];
    }else {
        //全部视图在最上方
        [self.view bringSubviewToFront:_allVC.view];
        
    }
}

@end
