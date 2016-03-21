//
//  BGYFindPwdResetViewController.m
//  BGYJia
//
//  Created by 全民尚网 on 16/3/3.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYFindPwdResetViewController.h"
#import "BGYBasicView.h"

@interface BGYFindPwdResetViewController ()
/** 承载键盘遮挡背景 View */
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *backScrollView;

@property (nonatomic, strong) BGYBasicView *pwdView;

@property (nonatomic, strong) UITextField *pwdTextField;

@property (nonatomic, strong) UIButton *rightViewBtn;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UIButton *completeButton;

@property (nonatomic, copy) VVBlock disappearBlock;

@end

@implementation BGYFindPwdResetViewController

- (void)dealloc {
    self.disappearBlock = nil;
}

+ (instancetype)newWithMessage:(VVBlock)eventBlock {
    BGYFindPwdResetViewController *findVC = [self new];
    findVC.disappearBlock = eventBlock;
    return findVC;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.disappearBlock();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_RGB(245, 245, 248, 1);
    
    [self setUpNewRegisterSystemUI];
    
    [self setUpNewRegisterUI];
    
}

#pragma mark - private method

- (void)setUpNewRegisterSystemUI {
    self.titleViewString = @"找回密码";
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.pwdTextField resignFirstResponder];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)setUpNewRegisterUI {
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.pwdView];
    [self.pwdView addSubview:self.pwdTextField];
    [self.pwdView addSubview:self.rightViewBtn];
    [self.backScrollView addSubview:self.tipLabel];
    [self.backScrollView addSubview:self.completeButton];
    
    [self.backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.backScrollView.mas_top).with.offset(35);
        make.width.equalTo(self.backScrollView.mas_width);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.12);
    }];
    
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 15, 1, 55));
    }];
    
    [self.rightViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdView.mas_top);
        make.bottom.equalTo(self.pwdView.mas_bottom);
        make.leading.equalTo(self.pwdTextField.mas_trailing);
        make.trailing.equalTo(self.pwdView.mas_trailing);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.backScrollView.mas_top).with.offset(8);
        make.width.equalTo(self.backScrollView.mas_width);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.06);
    }];
    
    [self.completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.backScrollView.mas_top).with.offset(112);
        make.width.equalTo(self.backScrollView.mas_width).multipliedBy(0.93);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.12);
    }];
    
}

#pragma mark - initializes attributes

- (TPKeyboardAvoidingScrollView *)backScrollView {
    if (!_backScrollView) {
        _backScrollView = [[TPKeyboardAvoidingScrollView alloc] init];
    }
    return _backScrollView;
}

- (BGYBasicView *)pwdView {
    if (!_pwdView) {
        _pwdView = [[BGYBasicView alloc] init];
        _pwdView.backgroundColor = [UIColor whiteColor];
        _pwdView.haveLineDown = YES;
        _pwdView.lineColor = [UIColor lightGrayColor];
    }
    return _pwdView;
}

- (UITextField *)pwdTextField {
    if (!_pwdTextField) {
        _pwdTextField = [[UITextField alloc] init];
        _pwdTextField.placeholder = @"请设置6 ～ 16位字符的登录密码";
        _pwdTextField.backgroundColor = [UIColor whiteColor];
        _pwdTextField.secureTextEntry = YES;
    }
    return _pwdTextField;
}

- (UIButton *)rightViewBtn {
    if (!_rightViewBtn) {
        _rightViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_rightViewBtn setImage:[UIImage imageNamed:@"eye_1"] forState:UIControlStateNormal];
        [_rightViewBtn setImage:[UIImage imageNamed:@"eye_2"] forState:UIControlStateSelected];
        
        @weakify(self);
        [[_rightViewBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            self.rightViewBtn.selected = !self.rightViewBtn.selected;
            self.pwdTextField.secureTextEntry = !self.pwdTextField.secureTextEntry;
            
            NSString *text = self.pwdTextField.text;
            self.pwdTextField.text = @" ";
            self.pwdTextField.text = text;
            
        }];
    }
    return _rightViewBtn;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"1验证手机 > 2设置密码"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(8,5)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0,7)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:NSMakeRange(0,13)];
        _tipLabel.attributedText = str;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UIButton *)completeButton
{
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
            
            [self.pwdTextField resignFirstResponder];
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.labelText = @"正在努力找回...";
            
            BOOL haveRightPassWord       = [RegularTools validatePassword:self.pwdTextField.text];
            
            if (!self.pwdTextField.text.length) {
                
                [hud hide:YES];
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请设置密码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            if (!haveRightPassWord) {
                
                [hud hide:YES];
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请设置6-16位字符的密码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            @weakify(self)
            [[JCNetWorking runNetWorking] resetPasswordWithCellphone:self.cellphone passWord:self.pwdTextField.text success:^(NSDictionary *dictionary) {
                @strongify(self);
                
                NSString * msg = [NSString string];
                
                [hud hide:YES];
                
                if ([[dictionary objectForKey:@"errorcode"] integerValue] == 0) {
                    
                    @weakify(self);
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"密码更改成功" hideForTime:1 andHideBlock:^{
                        @strongify(self);
                        
                        [self.pwdTextField resignFirstResponder];
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        
                    }];
                    
                    [remindView show];
                    
                } else if ([[dictionary objectForKey:@"errorcode"] integerValue] == 3) {
                    
                    @weakify(self);
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"该手机号未注册过，请先注册" hideForTime:1 andHideBlock:^{
                        @strongify(self);
                        
                        [self.pwdTextField resignFirstResponder];
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        
                    }];
                    
                    [remindView show];
                    
                } else {
                    
                    if ([[dictionary objectForKey:@"errorcode"] integerValue] == 2) {
                        msg = @"密码修改失败";
                    }
                    
                    JCRemindView * remindView = [JCRemindView remindWithMessage:msg hideForTime:3 andHideBlock:nil];
                    
                    [remindView show];
                    
                }
                
            } orFailure:^(NSError *error) {
                
                [hud hide:YES];
                
                JCLog(@"%@",error);
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
            }];
            
        }];
    }
    return _completeButton;
}

@end
