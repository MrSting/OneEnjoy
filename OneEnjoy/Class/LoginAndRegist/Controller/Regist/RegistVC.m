//
//  RegistVC.m
//  OneEnjoy
//
//  Created by 吴 on 2018/10/16.
//  Copyright © 2018年 YiChenTec. All rights reserved.
//

#import "RegistVC.h"
#import "VerifyCodeAlertView.h"

@interface RegistVC ()<VerifyCodeAlertViewDelegate> {
    int _counter;
    NSTimer *_timer;
}

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *verifyCodeBtn;

@end

@implementation RegistVC

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

- (IBAction)deleteBtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
            _phoneNumberTF.text = @"";
            break;
        case 11:
            _passwordTF.text = @"";
            break;
        case 12:
            _confirmPasswordTF.text = @"";
            break;
        default:
            break;
    }
}
- (IBAction)getVerifyCodeBtnClick:(UIButton *)sender {
    if (_phoneNumberTF.text.length == 0) {
        [self showErrorHUD:@"请输入手机号"];
        return;
    }
    if (_phoneNumberTF.text.length != 11) {
        [self showErrorHUD:@"手机号码格式不符"];
        return;
    }
    
    [self.phoneNumberTF resignFirstResponder];
    [self.verifyCodeTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    [self.confirmPasswordTF resignFirstResponder];
    
    VerifyCodeAlertView *verifyAlert = [[VerifyCodeAlertView alloc] init];
    verifyAlert.delegate = self;
    verifyAlert.mobile = _phoneNumberTF.text;
    verifyAlert.type = @"reg";
    [verifyAlert showInView:self.navigationController.view];
}

- (IBAction)registBtnClick:(UIButton *)sender {
    if (_phoneNumberTF.text.length == 0) {
        [self showErrorHUD:@"请输入手机号"];
        return;
    }
    if (_phoneNumberTF.text.length != 11) {
        [self showErrorHUD:@"手机号码格式不符"];
        return;
    }
    if (_verifyCodeTF.text.length == 0) {
        [self showErrorHUD:@"请输入验证码"];
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
    //    if(!_protocalSelectBtn.selected) {
    //        [self showErrorHUD:@"您需要同意用户协议"];
    //        return;
    //    }
    //    NSDictionary *params = @{@"mobile":[Coperations AES_encode:_phoneNumberTF.text],
    //                             @"password":[Coperations AES_encode:_passwordTF.text],
    //                             @"sms":_verifyCodeTF.text,
    //                             @"type":TYPE
    //                             };
    NSDictionary *params = @{@"mobile":_phoneNumberTF.text,
                             @"password":_passwordTF.text,
                             @"sms":_verifyCodeTF.text,
                             @"type":TYPE
                             };
    
    WS(weakSelf);
    [self postRequest:URL_USER_REG params:params showTips:TIPS_STR success:^(id responseObject) {
        if ([responseObject[@"code"] isEqualToString:SUCCESS]) {
            [self showSuccessWithStatus:responseObject[@"msg"]];
            if (responseObject[@"data"]) {
//                if (responseObject[@"data"][@"info"]) {
//                    NSDictionary *infoDic = responseObject[@"data"][@"info"];
//                    AccountModel *model = [[AccountModel alloc] initWithDictionary:infoDic context:nil];
//                    [ProjectCacheUtil setCurrentAccount:weakSelf.phoneNumberTF.text];
//                    [ProjectCacheUtil setAccountInfo:[model toDictionary] WithKey:weakSelf.phoneNumberTF.text];
//                }
                [ProjectCacheUtil setSessionToken:responseObject[@"data"][@"token"]];
            }
            [weakSelf pop];
        }
    } faild:^(NSError *error) {
        
    }];
}

- (IBAction)loginBtnClick:(UIButton *)sender {
    [self pop];
}

- (void)navigationBarButtonClick:(UIButton *)sender {
    switch (sender.tag) {
        case NAVBAR_BTN_LEFT_TAG:
            [self pop];
            break;
            
        default:
            break;
    }
}

#pragma mark - VerifyCodeAlertViewDelegate

- (void)verifyCodeVerifySuccess {
    [self timeBegin];
    [self showSuccessWithStatus:@"验证码已发送到您的手机,请注意查收"];
}

#pragma mark - PrivateMethod

- (void)createUserInterface {
    [self createNavigationBar];
}

- (void)createNavigationBar {
    [self initNavigationBarWithWhiteBg];
    [self addBarButtonItem:nil andImage:@[@"navigation_back"] selector:@selector(navigationBarButtonClick:) location:YES tag:NAVBAR_BTN_LEFT_TAG];
}

- (void)timeBegin {
    _counter = 60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startTimerFire:) userInfo:nil repeats:YES];
}

- (void)startTimerFire:(NSTimer*)timer {
    --_counter;
    if (_counter > 0) {
        NSString* title = [NSString stringWithFormat:@"%d秒", _counter];
        _verifyCodeBtn.enabled = NO;
        [_verifyCodeBtn setTitle:title forState:UIControlStateNormal];
    }else {
        _counter = 0;
        NSString* title = [NSString stringWithFormat:@"获取验证码"];
        _verifyCodeBtn.enabled = YES;
        [_verifyCodeBtn setTitle:title forState:UIControlStateNormal];
        [timer invalidate];
    }
}

#pragma mark - Set & Get

@end
