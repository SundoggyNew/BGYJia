//
//  BGYLoginViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYLoginViewController.h"
#import "BGYRegisterViewController.h"
#import "BGYFindPwdVerifyViewController.h"
#import "BGYRemoveCardLoseViewController.h"


#import "BGYInputTextView.h"

@interface BGYLoginViewController ()<JCActionViewDelegate>

@property (nonatomic , strong) TPKeyboardAvoidingScrollView * backgroundView;

@property (nonatomic , strong) UIImageView                  * headImageView;

@property (nonatomic , strong) BGYInputTextView             * accountInputView;

@property (nonatomic , strong) BGYInputTextView             * passwordInputView;

@property (nonatomic , strong) UILabel                      * loginRemindLabel;

@property (nonatomic , strong) UIButton                     * loginButton;

@property (nonatomic , strong) UIButton                     * loginErrorButton;

@property (nonatomic , strong) UIButton                     * registerButton;

@end

@implementation BGYLoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpLoginSystemUI];
    
    [self setUpLoginUI];
}

-(void)setUpLoginSystemUI
{
    
}

-(void)setUpLoginUI
{
    [self.view addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.headImageView];
    [self.backgroundView addSubview:self.accountInputView];
    [self.backgroundView addSubview:self.passwordInputView];
    [self.backgroundView addSubview:self.loginErrorButton];
    [self.backgroundView addSubview:self.loginRemindLabel];
    [self.backgroundView addSubview:self.loginButton];
    [self.backgroundView addSubview:self.registerButton];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView);
        make.top.equalTo(self.backgroundView.mas_top).with.offset(-20);
        make.width.equalTo(self.backgroundView);
        make.height.equalTo(self.backgroundView);
    }];
    
    [self.accountInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundView.mas_centerX);
        make.top.equalTo(self.backgroundView.mas_top).with.offset(SELF_VIEW_HEIGHT*0.4000);
        make.width.equalTo(self.backgroundView);
        make.height.equalTo(self.accountInputView.mas_width).multipliedBy(0.1375);
    }];
    
    [self.passwordInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundView.mas_centerX);
        make.top.equalTo(self.accountInputView.mas_bottom).with.offset(SELF_VIEW_HEIGHT*0.0195);
        make.width.equalTo(self.backgroundView);
        make.height.equalTo(self.passwordInputView.mas_width).multipliedBy(0.1375);
    }];

    [self.loginErrorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundView.mas_centerX).with.offset(SELF_VIEW_WIDTH*0.35);
        make.top.equalTo(self.passwordInputView.mas_bottom).with.offset(SELF_VIEW_HEIGHT*0.0150);
        make.width.equalTo(self.backgroundView).multipliedBy(0.741);
        make.height.equalTo(self.loginRemindLabel.mas_width).multipliedBy(0.0600);
    }];
    
    

    
    
    if (SCREEN_HEIGHT <= 480) {
        
        [self.loginRemindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backgroundView.mas_centerX);
            make.top.equalTo(self.loginErrorButton.mas_bottom).with.offset(SELF_VIEW_HEIGHT*0.0900);
            make.width.equalTo(self.backgroundView).multipliedBy(0.741);
            make.height.equalTo(self.loginRemindLabel.mas_width).multipliedBy(0.0700);
        }];
        
        [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backgroundView.mas_centerX);
            make.top.equalTo(self.loginRemindLabel.mas_bottom).with.offset(SELF_VIEW_HEIGHT*0.0100);
            make.width.equalTo(self.backgroundView);
            make.height.equalTo(self.loginButton.mas_width).multipliedBy(0.165*0.741);
        }];
        
        [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backgroundView.mas_centerX);
            make.top.equalTo(self.loginButton.mas_bottom).with.offset(SELF_VIEW_HEIGHT*0.0250);
            make.bottom.equalTo(self.backgroundView.mas_bottom);
            make.width.equalTo(self.backgroundView.mas_width).multipliedBy(0.500);
        }];
        
    }else{
        
        [self.loginRemindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backgroundView.mas_centerX);
            make.top.equalTo(self.loginErrorButton.mas_bottom).with.offset(SELF_VIEW_HEIGHT*0.1400);
            make.width.equalTo(self.backgroundView).multipliedBy(0.741);
            make.height.equalTo(self.loginRemindLabel.mas_width).multipliedBy(0.0700);
        }];
        
        [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backgroundView.mas_centerX);
            make.top.equalTo(self.loginRemindLabel.mas_bottom).with.offset(SELF_VIEW_HEIGHT*0.0100);
            make.width.equalTo(self.backgroundView);
            make.height.equalTo(self.loginButton.mas_width).multipliedBy(0.165*0.741);
        }];
        
        [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backgroundView.mas_centerX);
            make.top.equalTo(self.loginButton.mas_bottom).with.offset(SELF_VIEW_HEIGHT*0.050);
            make.bottom.equalTo(self.backgroundView.mas_bottom).with.offset(SELF_VIEW_HEIGHT*0.0302);
            make.width.equalTo(self.backgroundView.mas_width).multipliedBy(0.475);
        }];
        
    }
}



#pragma mark - jcactionView delegate method
-(void)jcActionView:(JCActionView *)actionView selectedWithTitle:(NSString *)title index:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            BGYFindPwdVerifyViewController *findVC = [BGYFindPwdVerifyViewController newWithMessage:^(NSString *message) {
                [self.accountInputView setTheInputFieldText:message];
            }];
            [self.navigationController pushViewController:findVC animated:YES];
        }
            break;
        case 1:
        {
            [self.navigationController pushViewController:[BGYRemoveCardLoseViewController new] animated:YES];
        }
            break;
    }
    
    
}




#pragma mark - initializes attributes
-(TPKeyboardAvoidingScrollView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[TPKeyboardAvoidingScrollView alloc] init];
    }
    return _backgroundView;
}
-(UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_index"]];
    }
    return _headImageView;
}
-(BGYInputTextView *)accountInputView
{
    if (!_accountInputView) {
        _accountInputView = [[BGYInputTextView alloc] initWithLeftImage:[UIImage imageNamed:@"Icon_User"] andPlaceholder:@"请输入手机号码"];
        _accountInputView.haveLineDown = YES;
        _accountInputView.lineColor = [UIColor whiteColor];
    }
    return _accountInputView;
}

-(BGYInputTextView *)passwordInputView
{
    if (!_passwordInputView) {
        _passwordInputView = [[BGYInputTextView alloc] initWithLeftImage:[UIImage imageNamed:@"Icon_Lock"] andPlaceholder:@"请输入登录密码"];
        _passwordInputView.haveLineDown = YES;
        _passwordInputView.secureTextEntry = YES;
        _passwordInputView.lineColor = [UIColor whiteColor];
    }
    return _passwordInputView;
}

-(UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        _loginButton.backgroundColor = UIColorFromRGB(0xfa4964);
        [_loginButton setTitle:@"登 录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        @weakify(self);
        [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.accountInputView outOfFirstResponder];
            [self.passwordInputView outOfFirstResponder];
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.labelText = @"正在努力登录...";
            
            NSString * cellphone  = [self.accountInputView getTheInputFieldText];
            NSString * password  = [self.passwordInputView getTheInputFieldText];
            
            if (cellphone.length == 0) {
                
                [hud hide:YES];
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入手机号码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
                
            }
            
            if (password.length == 0) {
                
                [hud hide:YES];
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入密码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
                
            }
            
            BOOL haveRightCellPhone      = [RegularTools validateMobile:[self.accountInputView getTheInputFieldText]];
            BOOL haveRightPassWord       = [RegularTools validatePassword:[self.passwordInputView getTheInputFieldText]];
            
            if (!haveRightCellPhone) {
                
                [hud hide:YES];
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入正确的手机号码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
                
            }
            
            if (!haveRightPassWord) {
                
                [hud hide:YES];
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请设置6-16位字符的密码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            @weakify(self);
            [[JCNetWorking runNetWorking] loginWithAccount:cellphone passWord:password loginMethod:0 success:^(NSDictionary *dictionary) {
                @strongify(self);
                
                [hud hide:YES];
                
                JCLog(@" %@ ",dictionary);
                
                if ([[dictionary objectForKey:@"errorcode"] integerValue] == 0) {
                    
                    User * user = [User runUser];
                    
                    user.password = password;
                    
                    [user setUpWithDictionary:dictionary];
                    
                    [user saveToDB];
                    
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"登录成功" hideForTime:1 andHideBlock:^{
                        
                        BGYTabBarController * tabbar = [BGYTabBarController runTabBar];
                        
                        UIWindow *window                  = [[UIApplication sharedApplication].windows objectAtIndex:0];
                        
                        window.rootViewController         = tabbar;
                        
                    }];
                    
                    [remindView show];
                    
                } else if ([[dictionary objectForKey:@"errorcode"] integerValue] == 1){
                
                    self.loginRemindLabel.hidden = NO;
                    
                } else if ([[dictionary objectForKey:@"errorcode"] integerValue] == 2){
                    
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"该账号审核被拒绝" hideForTime:3 andHideBlock:nil];
                    
                    [remindView show];
                    
                } else if ([[dictionary objectForKey:@"errorcode"] integerValue] == 3){
                    
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"账户被业主删除" hideForTime:3 andHideBlock:nil];
                    
                    [remindView show];
                    
                } else if ([[dictionary objectForKey:@"errorcode"] integerValue] == 4){
                    
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"账户已被挂失" hideForTime:3 andHideBlock:nil];
                    
                    [remindView show];
                    
                } else if ([[dictionary objectForKey:@"errorcode"] integerValue] == 5){
                    
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"账户已被禁用" hideForTime:3 andHideBlock:nil];
                    
                    [remindView show];
                    
                } else if ([[dictionary objectForKey:@"errorcode"] integerValue] == 6){
                    
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"此账号不存在" hideForTime:3 andHideBlock:nil];
                    
                    [remindView show];
                    
                } else if ([[dictionary objectForKey:@"errorcode"] integerValue] == 7){
                    
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"密码输入错误" hideForTime:3 andHideBlock:nil];
                    
                    [remindView show];
                    
                } else {
                    
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:3 andHideBlock:nil];
                    
                    [remindView show];
                }
                
            } orFailure:^(NSError *error) {
                
                [hud hide:YES];
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
            }];
            
        }];
    }
    return _loginButton;
}

-(UILabel *)loginRemindLabel
{
    if (!_loginRemindLabel) {
        _loginRemindLabel = [[UILabel alloc] init];
        _loginRemindLabel.text = @"您的账号还未通过业主审核，请耐心等待.";
        _loginRemindLabel.textColor = UIColorFromRGB(0xfa4964);
        _loginRemindLabel.font = [UIFont systemFontOfSize:14.0f];
        _loginRemindLabel.textAlignment = NSTextAlignmentCenter;
        _loginRemindLabel.adjustsFontSizeToFitWidth = YES;
        _loginRemindLabel.hidden = YES;
    }
    return _loginRemindLabel;
}

-(UIButton *)loginErrorButton
{
    if (!_loginErrorButton) {
        _loginErrorButton = [[UIButton alloc] init];
        _loginErrorButton.backgroundColor = [UIColor clearColor];
        _loginErrorButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_loginErrorButton setTitle:@"登录遇到问题？" forState:UIControlStateNormal];
        [_loginErrorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginErrorButton.titleLabel.textAlignment = NSTextAlignmentRight;
        
        @weakify(self);
        [[_loginErrorButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.accountInputView outOfFirstResponder];
            [self.passwordInputView outOfFirstResponder];
            
            JCActionView * actionList = [[JCActionView alloc] initWithDelegate:self cancelTitle:@"取消" Titles:@"忘记密码",@"解除挂失", nil];
            
            [actionList show];
            
        }];
    }
    return _loginErrorButton;
}

-(UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [[UIButton alloc] init];
        _registerButton.backgroundColor = [UIColor clearColor];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_registerButton setTitle:@"新用户？立即注册→" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        @weakify(self);
        [[_registerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.navigationController pushViewController:[BGYRegisterViewController new] animated:YES];
            
        }];
    }
    return _registerButton;
}

@end
