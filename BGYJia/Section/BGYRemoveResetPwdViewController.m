//
//  BGYRemoveResetPwdViewController.m
//  BGYJia
//
//  Created by 全民尚网 on 16/3/4.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYRemoveResetPwdViewController.h"

@interface BGYRemoveResetPwdViewController ()<UITableViewDataSource, UITableViewDelegate>

/** 承载键盘遮挡背景 View */
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *backScrollView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextField *phoneNumTextField;

@property (nonatomic, strong) UIView *verificationView;

@property (nonatomic, strong) UITextField *verifyTextField;

@property (nonatomic, strong) UIButton *rightViewBtn;

@property (nonatomic, strong) UITextField *pwdTextField;

@property (nonatomic, strong) UIButton *completeButton;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, assign) NSInteger validationCode;

@end

@implementation BGYRemoveResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNewRegisterSystemUI];
    
    [self setUpNewRegisterUI];
    
}

#pragma mark - private method

- (void)setUpNewRegisterSystemUI {
    
    self.titleViewString = @"解除挂失";
    
    self.view.backgroundColor = UICOLOR_RGB(245, 245, 248, 1);
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.phoneNumTextField resignFirstResponder];
        [self.verifyTextField resignFirstResponder];
        [self.pwdTextField resignFirstResponder];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)setUpNewRegisterUI {
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.tableView];
    [self.verificationView addSubview:self.verifyTextField];
    [self.verificationView addSubview:self.rightViewBtn];
    [self.backScrollView addSubview:self.completeButton];
    [self.backScrollView addSubview:self.tipLabel];
    
    [self.backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.backScrollView.mas_top).with.offset(17);
        make.width.equalTo(self.backScrollView.mas_width);
        make.height.mas_equalTo(132);
    }];
    
    [self.verifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 15, 0, 80));
    }];
    
    [self.rightViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.bottom.trailing.mas_equalTo(-8);
        make.leading.equalTo(self.verifyTextField.mas_trailing);
    }];
    
    [self.completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.backScrollView.mas_top).with.offset(180);
        make.width.equalTo(self.backScrollView.mas_width).multipliedBy(0.93);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.12);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.completeButton.mas_bottom);
        make.width.equalTo(self.backScrollView.mas_width).multipliedBy(0.93);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.12);
    }];
    
}

#pragma mark - private method

-(void)timerClick
{
    __block int timeout=60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.rightViewBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                
                self.rightViewBtn.userInteractionEnabled = YES;
                
                self.rightViewBtn.selected = NO;
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                JCLog(@"____%@",strTime);
                
                [self.rightViewBtn setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                
                self.rightViewBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        self.phoneNumTextField.frame = CGRectMake(15, 0, tableView.bounds.size.width, 44);
        [cell.contentView addSubview:self.phoneNumTextField];
        return cell;
    } else if (indexPath.row == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        self.verificationView.frame = CGRectMake(0, 0, tableView.bounds.size.width, 44);
        [cell.contentView addSubview:self.verificationView];
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        self.pwdTextField.frame = CGRectMake(15, 0, tableView.bounds.size.width, 44);
        [cell.contentView addSubview:self.pwdTextField];
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - initializes

- (TPKeyboardAvoidingScrollView *)backScrollView {
    if (!_backScrollView) {
        _backScrollView = [[TPKeyboardAvoidingScrollView alloc] init];
    }
    return _backScrollView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (UIView *)verificationView {
    if (!_verificationView) {
        _verificationView = [[UIView alloc] init];
        _verificationView.backgroundColor = [UIColor whiteColor];
    }
    return _verificationView;
}

- (UITextField *)phoneNumTextField {
    if (!_phoneNumTextField) {
        _phoneNumTextField = [[UITextField alloc] init];
        _phoneNumTextField.placeholder = @"请输入新手机号码";
        _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNumTextField.backgroundColor = [UIColor whiteColor];
    }
    return _phoneNumTextField;
}

- (UITextField *)verifyTextField {
    if (!_verifyTextField) {
        _verifyTextField = [[UITextField alloc] init];
        _verifyTextField.placeholder = @"请输入验证码";
        _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        _verifyTextField.backgroundColor = [UIColor whiteColor];
    }
    return _verifyTextField;
}

- (UIButton *)rightViewBtn {
    if (!_rightViewBtn) {
        _rightViewBtn = [[UIButton alloc] init];
        //设置按钮红色圆角边框
        [_rightViewBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_rightViewBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        _rightViewBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        _rightViewBtn.layer.borderColor = MAIN_COLOR.CGColor;
        _rightViewBtn.layer.borderWidth = 1.0f;
        _rightViewBtn.layer.masksToBounds = YES;
        _rightViewBtn.layer.cornerRadius = 5.0f;
        
        @weakify(self);
        [[_rightViewBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.phoneNumTextField resignFirstResponder];
            [self.verifyTextField resignFirstResponder];
            [self.pwdTextField resignFirstResponder];
            
            if (!self.phoneNumTextField.text.length) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入手机号码" hideForTime:2 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            BOOL haveRightCellphone = [RegularTools validateMobile:self.phoneNumTextField.text];
            if (!haveRightCellphone) {
                
                JCRemindView *remindView = [JCRemindView remindWithMessage:@"请输入正确的手机号码" hideForTime:3 andHideBlock:nil];
                [remindView show];
                return ;
                
            }
            
            @weakify(self);
            [[JCNetWorking runNetWorking] sendMessageWithCellphone:self.phoneNumTextField.text Type:SendMessageTypeForgotPassword success:^(NSString *message, NSInteger number) {
                @strongify(self);
                
                if ([message isEqualToString:@"发送成功"]) {
                    [self timerClick];
                }
                
                self.validationCode = number;
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:message hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
            } orFailure:^(NSError *error) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"获取验证码失败，请重试" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
            }];
            
        }];
    }
    return _rightViewBtn;
}

- (UITextField *)pwdTextField {
    if (!_pwdTextField) {
        _pwdTextField = [[UITextField alloc] init];
        _pwdTextField.placeholder = @"请设置6～16位字符的登录密码";
        _pwdTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _pwdTextField.backgroundColor = [UIColor whiteColor];
        _pwdTextField.secureTextEntry = YES;
    }
    return _pwdTextField;
}

- (UIButton *)completeButton {
    if (!_completeButton) {
        _completeButton = [[UIButton alloc] init];
        [_completeButton setTitle:@"完成" forState:UIControlStateNormal];
        [_completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_completeButton setBackgroundColor:UICOLOR_RGB(250, 73, 100, 1)];
        [_completeButton.layer setCornerRadius:5.0f];
        _completeButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        
        @weakify(self);
        [[_completeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.phoneNumTextField resignFirstResponder];
            [self.verifyTextField resignFirstResponder];
            [self.pwdTextField resignFirstResponder];
            
            if (self.pwdTextField.text.length == 0) {
                
                JCRemindView *remindView = [JCRemindView remindWithMessage:@"请设置密码" hideForTime:3 andHideBlock:nil];
                [remindView show];
                return ;
                
            }
            
            if (self.verifyTextField.text.length == 0) {
                
                JCRemindView *remindView = [JCRemindView remindWithMessage:@"请输入验证码" hideForTime:3 andHideBlock:nil];
                [remindView show];
                return ;
                
            }
            
            BOOL haveRightPassword = [RegularTools validatePassword:self.pwdTextField.text];
            if (!haveRightPassword) {
                
                JCRemindView *remindView = [JCRemindView remindWithMessage:@"请设置6-16位字符的密码" hideForTime:3 andHideBlock:nil];
                [remindView show];
                return ;
                
            }
            
            if ([self.verifyTextField.text isEqualToString:[NSString stringWithFormat:@"%ld",(long)self.validationCode]]) {
            
                @weakify(self);
                [[JCNetWorking runNetWorking] removeLossWithCellphone:self.phoneNumTextField.text password:self.pwdTextField.text idCard:self.idcard success:^(NSInteger number) {
                     @strongify(self);
                    
                     if (number == 0) {
                        
                        JCRemindView * remindView = [JCRemindView remindWithMessage:@"解挂成功" hideForTime:3 andHideBlock:nil];
                        
                        [remindView show];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        
                     } else if (number == -1) {
                         
                         JCRemindView * remindView = [JCRemindView remindWithMessage:@"解挂失败" hideForTime:3 andHideBlock:nil];
                         
                         [remindView show];
                         
                     } else if (number == 2) {
                         
                         JCRemindView * remindView = [JCRemindView remindWithMessage:@"账户不存在" hideForTime:3 andHideBlock:nil];
                         
                         [remindView show];
                         
                     } else {
                         
                         JCRemindView * remindView = [JCRemindView remindWithMessage:@"没有参数传入" hideForTime:3 andHideBlock:nil];
                         
                         [remindView show];
                         
                     }
                    
                } orFailure:^(NSError *error) {
                    
                }];
                
            } else {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入正确的验证码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
            }
            
            
        }];
    }
    return _completeButton;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.backgroundColor = UICOLOR_RGB(245, 245, 248, 1);
        _tipLabel.font = [UIFont systemFontOfSize:13.0f];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.text = @"挂失成功后，请用新的账号密码登录，原账户信息不变。";
        _tipLabel.numberOfLines = 2;
    }
    return _tipLabel;
}

@end
