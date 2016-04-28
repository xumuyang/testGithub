//
//  DetailViewController.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "DetailViewController.h"
#import "UMSocial.h"

@interface DetailViewController ()<UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DetailViewController

//显示导航栏
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    //设置导航栏
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //文字颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createWebView];
    
    [self createShareButton];
}

- (void)createShareButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"share_normal"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 60, 44);
    [button addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)shareClick {
    //第三方分享
    //shareSDK/友盟
    //1.当前视图
    //2.appKey,保证与AppDelegate中设置一致
    //3.shareText 分享的文字
    //4.shareImage 分享图片
    //5.shareToSnsNames @[] 分享渠道;
    
    //更改分享的链接,标题,类型等
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://www.baidu.com";
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://www.taobao.com";
    //标题
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"外面下着雨";
    
    //更改qq分享链接
    [UMSocialData defaultData].extConfig.qqData.url = @"http://www.tabbao.com";
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5629925367e58e55140015c0" shareText:@"" shareImage:[UIImage imageNamed:@"loading_teemo_1.png"] shareToSnsNames:@[UMShareToSina,UMShareToRenren,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ,UMShareToQzone] delegate:self];
}

- (void)createWebView {
    //网址
    NSString *url = [NSString stringWithFormat:kNewsDetailUrlString,_ID];
    //请求体
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
