//
//  MeViewController.m
//  LOLInfo
//
//  Created by qianfeng on 16/4/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "MeViewController.h"
#import "UMSocial.h"
#import <SMS_SDK/SMSSDK.h>

@interface MeViewController (){
    UITextField *_telTextField;
    UITextField *_verifyTextField;
}

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    //第三方登陆(项目的1.0版本尽量不要添加)
    [self createShareButton];
    
}

- (void)createUI {
    //电话输入框
    _telTextField = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200) / 2, 100, 200, 36)];
    _telTextField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:_telTextField];
    
    //验证码输入框
    _verifyTextField = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 200) / 2, 160, 200, 36)];
    _verifyTextField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:_verifyTextField];
    
    //发送验证码
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    sendBtn.frame = CGRectMake((SCREEN_WIDTH - 200) / 2 + 200, 100, 100, 36);
    [sendBtn addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
    //验证
    UIButton *verifyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [verifyBtn setTitle:@"验证" forState:UIControlStateNormal];
    verifyBtn.frame = CGRectMake((SCREEN_WIDTH - 200) / 2 + 200, 160, 100, 36);
    [verifyBtn addTarget:self action:@selector(verifyClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:verifyBtn];
}

- (void)sendClick {
    /**
     method:短信或语音
     2.phoneNumber:电话号码
     3.zone:+86
     4.自定义标识,当项目上线后,可修改来自等 nil
     5.result:返回结果

     */
    NSLog(@"%@", _telTextField.text);
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_telTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"========");
        } else {
            NSLog(@"=====%@", error);
        }
    }];
}
//13269061106


- (void)verifyClick{
    [SMSSDK commitVerificationCode:_verifyTextField.text phoneNumber:_telTextField.text zone:@"86" result:^(NSError *error) {
        if (!error) {
            NSLog(@"验证通过");
        }
    }];
}



-(void)createShareButton {
    NSArray *titleArr = @[@"QQ登陆",@"微信登陆",@"微博登陆"];
    NSArray *colorArr = @[[UIColor greenColor],[UIColor orangeColor],[UIColor yellowColor]];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 200 + i;
        button.frame = CGRectMake(SCREEN_WIDTH / 3 * i, SCREEN_HEIGHT - 200, SCREEN_WIDTH / 3 , 100);
        button.backgroundColor = colorArr[i];
        button.layer.cornerRadius = 50;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
}

- (void)buttonClick:(UIButton *)button {
    if (button.tag == 200) {
        //QQ登陆
        [self thridLoginTo:UMShareToQQ];
    }else if (button.tag == 201){
        //微信登陆
        [self thridLoginTo:UMShareToWechatSession];
    }else {
        //微博登陆
        [self thridLoginTo:UMShareToSina];
    }

}

- (void)thridLoginTo:(NSString *)shareTo {
    UMSocialSnsPlatform *snsPlatForm = [UMSocialSnsPlatformManager getSocialPlatformWithName:shareTo];
    snsPlatForm.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:shareTo];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});

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
