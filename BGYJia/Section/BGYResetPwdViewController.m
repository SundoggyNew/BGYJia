//
//  BGYResetPwdViewController.m
//  BGYJia
//
//  Created by 全民尚网 on 16/3/7.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYResetPwdViewController.h"
#import "BGYResetPwdFinishViewController.h"
#import "BGYBasicView.h"

@interface BGYResetPwdViewController ()

/** 承载键盘遮挡背景 View */
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *backScrollView;

@property (nonatomic, strong) BGYBasicView *pwdView;

@property (nonatomic, strong) UITextField *pwdTextField;

@property (nonatomic, strong) UIButton *rightViewBtn;

@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation BGYResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_RGB(245, 245, 248, 1);
    
    [self setUpNewRegisterSystemUI];
    
    [self setUpNewRegisterUI];
    
}

#pragma mark - private method

- (void)setUpNewRegisterSystemUI {
    self.titleViewString = @"重置登录密码";
    
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
    [self.backScrollView addSubview:self.nextButton];
    
    [self.backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.backScrollView.mas_top).with.offset(15);
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
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.pwdView.mas_bottom).with.offset(35);
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
        
//        @weakify(self);
        [[_rightViewBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//            @strongify(self);
            
            _rightViewBtn.selected = !_rightViewBtn.selected;
            _pwdTextField.secureTextEntry = !_pwdTextField.secureTextEntry;
            
            NSString *text = _pwdTextField.text;
            _pwdTextField.text = @" ";
            _pwdTextField.text = text;
            
        }];
    }
    return _rightViewBtn;
}

- (UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] init];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextButton setBackgroundColor:UICOLOR_RGB(250, 73, 100, 1)];
        [_nextButton.layer setCornerRadius:5.0f];
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        
        @weakify(self);
        [[_nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.pwdTextField resignFirstResponder];
            
            if (!self.pwdTextField.text.length) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请设置密码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
                
            }
            
            BOOL haveRightPassWord       = [RegularTools validatePassword:self.pwdTextField.text];
            
            if (!haveRightPassWord) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请设置6-16位字符的密码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            User *user = [User runUser];
            
            @weakify(self);
            [[JCNetWorking runNetWorking] resetPasswordWithCellphone:user.cellphone passWord:self.pwdTextField.text success:^(NSDictionary *dictionary) {
                @strongify(self);
                
                if ([[dictionary objectForKey:@"errorcode"] integerValue] == 0) {
                    
                    @weakify(self);
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"密码更改成功" hideForTime:1 andHideBlock:^{
                        @strongify(self);
                        
                        [self.pwdTextField resignFirstResponder];
                        
                        [self.navigationController pushViewController:[BGYResetPwdFinishViewController new] animated:YES];
                        
                    }];
                    
                    [remindView show];
                    
                }else{
                    
                    if ([[dictionary objectForKey:@"errorcode"] integerValue] == 2) {
                        
                        JCRemindView * remindView = [JCRemindView remindWithMessage:@"密码修改失败" hideForTime:3 andHideBlock:nil];
                        
                        [remindView show];
                    }
                    
                }
                
            } orFailure:^(NSError *error) {
                
                JCLog(@"%@",error);
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
            }];
            
        }];
    }
    return _nextButton;
}

@end
