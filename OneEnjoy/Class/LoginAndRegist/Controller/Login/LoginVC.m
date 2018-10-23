//
//  LoginVC.m
//  OneEnjoy
//
//  Created by 吴 on 2018/10/15.
//  Copyright © 2018年 YiChenTec. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginVC

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUserInterface];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - UIResponse & Event

- (IBAction)forgetPasswordBtnDidClick:(UIButton *)sender {
    [self push:@"ForgetPasswordVC" storyBoard:SB_LOGIN_REGIST];
}

- (IBAction)registBtnDidClick:(UIButton *)sender {
    [self push:@"RegistVC" storyBoard:SB_LOGIN_REGIST];
}

- (IBAction)loginBtnDidClick:(UIButton *)sender {
    if (_phoneNumberTF.text.length == 0) {
        [self showErrorHUD:@"请输入手机号"];
        return;
    }
    if (_phoneNumberTF.text.length != 11) {
        [self showErrorHUD:@"手机号码格式不符"];
        return;
    }
    if (_passwordTF.text.length == 0) {
        [self showErrorHUD:@"请输入密码"];
        return;
    }
    if (![NSString judgePassWordLegal:_passwordTF.text]) {
        [self showErrorHUD:@"密码应当为6-20位的数字和字母组合"];
        return;
    }
    NSDictionary *params = @{@"mobile":_phoneNumberTF.text,
                             @"password":_passwordTF.text,
                             @"type":TYPE,
                             };
    WS(weakSelf);
    [self postRequest:URL_USER_LOGIN params:params showTips:TIPS_STR success:^(id responseObject) {
        DLog(@"Login responseObject is %@",responseObject);
        if ([responseObject[@"code"] isEqualToString:SUCCESS]) {
            if (responseObject[@"data"]) {
//                if (responseObject[@"data"][@"info"]) {
//                    NSDictionary *infoDic = responseObject[@"data"][@"info"];
//                    AccountModel *model = [[AccountModel alloc] initWithDictionary:infoDic context:nil];
//                    [ProjectCacheUtil setCurrentAccount:weakSelf.phoneNumberTF.text];
//                    DLog(@"model toDictionary is %@",[model toDictionary]);
//                    [ProjectCacheUtil setAccountInfo:[model toDictionary] WithKey:weakSelf.phoneNumberTF.text];
//                }
                [ProjectCacheUtil setSessionToken:responseObject[@"data"][@"token"]];
            }
            [weakSelf popToMainOrPersonalCenter];
        }
    } faild:^(NSError *error) {
        
    }];
}

- (IBAction)deleteTextBtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
            _phoneNumberTF.text = @"";
            break;
        case 11:
            _passwordTF.text = @"";
            break;
        default:
            break;
    }
}

/*
 // 第三方登录数据(为空表示平台未提供)
 // 授权数据
 DLog(@" uid: %@", resp.uid);
 DLog(@" openid: %@", resp.openid);
 DLog(@" accessToken: %@", resp.accessToken);
 DLog(@" refreshToken: %@", resp.refreshToken);
 DLog(@" expiration: %@", resp.expiration);
 
 // 用户数据
 DLog(@" name: %@", resp.name);
 DLog(@" iconurl: %@", resp.iconurl);
 DLog(@" gender: %@", resp.unionGender);
 */
//- (IBAction)wechatLoginBtnClick:(UIButton *)sender {
//    WS(weakSelf);
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
//        UMSocialUserInfoResponse *resp = result;
//        // 第三方平台SDK原始数据
//        DLog(@" originalResponse: %@", resp.originalResponse);
//        if ([resp.originalResponse isKindOfClass:[NSDictionary class]]) {
//            NSString *jsonData = [weakSelf convertToJsonData:resp.originalResponse];
//            NSDictionary *paramDic = @{@"data":jsonData};
//            [weakSelf postRequest:URL_USER_WXLOGIN params:paramDic showTips:TIPS_STR success:^(id responseObject) {
//                DLog(@"Login responseObject is %@",responseObject);
//                if ([responseObject[@"code"] isEqualToString:SUCCESS]) {
//                    if (responseObject[@"data"]) {
//                        if (responseObject[@"data"][@"info"]) {
//                            NSDictionary *infoDic = responseObject[@"data"][@"info"];
//                            AccountModel *model = [[AccountModel alloc] initWithDictionary:infoDic context:nil];
//                            [ProjectCacheUtil setCurrentAccount:weakSelf.phoneNumberTF.text];
//                            DLog(@"model toDictionary is %@",[model toDictionary]);
//                            [ProjectCacheUtil setAccountInfo:[model toDictionary] WithKey:weakSelf.phoneNumberTF.text];
//                        }
//                        [ProjectCacheUtil setSessionToken:responseObject[@"data"][@"token"]];
//                    }
//                    [weakSelf popToMainOrPersonalCenter];
//                }
//            } faild:^(NSError *error) {
//
//            }];
//        }
//    }];
//}

- (void)navigationBarButtonClick:(UIButton *)sender {
    switch (sender.tag) {
        case NAVBAR_BTN_LEFT_TAG:
            [self popToMainOrPersonalCenter];
            [ProjectCacheUtil deleteSessionToken];
            break;
            
        default:
            break;
    }
}

#pragma mark - PrivateMethod

- (void)createUserInterface {
    [self createNavigationBar];
}

- (void)createNavigationBar {
    [self initNavigationBarWithWhiteBg];
    [self addBarButtonItem:nil andImage:@[@"navigation_back"] selector:@selector(navigationBarButtonClick:) location:YES tag:NAVBAR_BTN_LEFT_TAG];
}

- (void)popToMainOrPersonalCenter {
    if (_isPush) {
        if ([self.identifierString isEqualToString:BACK_POP]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([self.identifierString isEqualToString:BACK_HOME_VC]) {
            BaseTabBarViewController *tab = (BaseTabBarViewController *)self.tabBarController;
            [tab tabBarDidSelectedIndex:0];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else if ([self.identifierString isEqualToString:BACK_PERSONALCENTER]) {
            BaseTabBarViewController *tab = (BaseTabBarViewController *)self.tabBarController;
            [tab tabBarDidSelectedIndex:1];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }else {
        if ([self.identifierString isEqualToString:BACK_POP]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else if ([self.identifierString isEqualToString:BACK_HOME_VC]) {
            [self dismissViewControllerAnimated:YES completion:^{
                [NotificationCenter postNotificationName:LoginVCDidDismiss object:nil userInfo:nil];
            }];
        }else if ([self.identifierString isEqualToString:BACK_PERSONALCENTER]) {
            [self dismissViewControllerAnimated:YES completion:^{
                [NotificationCenter postNotificationName:LoginVCDidDismiss object:nil userInfo:nil];
            }];
        }
    }
}

- (NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

#pragma mark - Set & Get

@end
