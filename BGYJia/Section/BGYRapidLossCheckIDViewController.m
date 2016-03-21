//
//  BGYRapidLossCheckIDViewController.m
//  BGYJia
//
//  Created by 全民尚网 on 16/3/7.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYRapidLossCheckIDViewController.h"
#import "BGYRapidLossFinishViewController.h"
#import "BGYBasicView.h"

@interface BGYRapidLossCheckIDViewController ()

/** 承载键盘遮挡背景 View */
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *backScrollView;

@property (nonatomic, strong) BGYBasicView *idView;

@property (nonatomic, strong) UITextField *idTextField;

@property (nonatomic, strong) UILabel *tipUpLabel;

@property (nonatomic, strong) UILabel *accountLabel;

@property (nonatomic, strong) UILabel *tipDownLabel;

@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation BGYRapidLossCheckIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_RGB(245, 245, 248, 1);
    
    [self setUpNewRegisterSystemUI];
    
    [self setUpNewRegisterUI];
    
}

#pragma mark - private method

- (void)setUpNewRegisterSystemUI {
    self.titleViewString = @"快速挂失";
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.idTextField resignFirstResponder];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)setUpNewRegisterUI {
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.idView];
    [self.idView addSubview:self.idTextField];
    [self.backScrollView addSubview:self.tipUpLabel];
    [self.backScrollView addSubview:self.accountLabel];
    [self.backScrollView addSubview:self.nextButton];
    [self.backScrollView addSubview:self.tipDownLabel];
    
    [self.backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tipUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.backScrollView.mas_top).with.offset(8);
        make.leading.equalTo(self.backScrollView.mas_leading).with.offset(20);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.06);
    }];
    
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.tipUpLabel.mas_bottom);
        make.width.equalTo(self.backScrollView.mas_width);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.12);
    }];
    
    [self.idView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.accountLabel.mas_bottom);
        make.width.equalTo(self.backScrollView.mas_width);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.12);
    }];
    
    [self.idTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 15, 1, 80));
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.idView.mas_bottom).with.offset(35);
        make.width.equalTo(self.backScrollView.mas_width).multipliedBy(0.93);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.12);
    }];
    
    [self.tipDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.nextButton.mas_bottom).with.offset(5);
        make.width.equalTo(self.backScrollView.mas_width).multipliedBy(0.93);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.10);
    }];
    
}



#pragma mark - initializes

- (TPKeyboardAvoidingScrollView *)backScrollView {
    if (!_backScrollView) {
        _backScrollView = [[TPKeyboardAvoidingScrollView alloc] init];
    }
    return _backScrollView;
}

- (UILabel *)tipUpLabel {
    if (!_tipUpLabel) {
        _tipUpLabel = [[UILabel alloc] init];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"1填写挂失账号 > 2身份信息验证 > 3挂失成功"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10,7)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0,9)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(17,8)];
        _tipUpLabel.attributedText = str;
        _tipUpLabel.adjustsFontSizeToFitWidth = YES;
        _tipUpLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipUpLabel;
}

- (UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel = [[UILabel alloc] init];
        _accountLabel.text = [NSString stringWithFormat:@"挂失账号：%@", self.account];
        _accountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _accountLabel;
}

- (BGYBasicView *)idView {
    if (!_idView) {
        _idView = [[BGYBasicView alloc] init];
        _idView.backgroundColor = [UIColor whiteColor];
        _idView.haveLineDown = YES;
        _idView.lineColor = [UIColor lightGrayColor];
    }
    return _idView;
}

- (UITextField *)idTextField {
    if (!_idTextField) {
        _idTextField = [[UITextField alloc] init];
        _idTextField.placeholder = @"请输入身份证号码";
        _idTextField.backgroundColor = [UIColor whiteColor];
    }
    return _idTextField;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] init];
        [_nextButton setTitle:@"确认，立刻挂失" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextButton setBackgroundColor:UICOLOR_RGB(250, 73, 100, 1)];
        [_nextButton.layer setCornerRadius:5.0f];
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        
        @weakify(self);
        [[_nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.idTextField resignFirstResponder];
            
            NSString *idcard = self.idTextField.text;
            
            if (idcard.length == 0) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入身份证号码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
                
            }
            
            BOOL haveRightIDCard = [RegularTools validateIdentityCard:self.idTextField.text];
            
            if (!haveRightIDCard) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入正确的身份证号码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            @weakify(self);
            [[JCNetWorking runNetWorking] reportOfTheLossOfCellphone:self.account success:^(NSInteger number) {
                @strongify(self);
                
                if (number == 0) {
                    
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"挂失成功" hideForTime:3 andHideBlock:nil];
                    
                    [remindView show];
                    
                    //挂失成功后，对挂失账号注销登录
                    @weakify(self);
                    [[JCNetWorking runNetWorking] logoutWithsuccess:^(NSDictionary *dictionary) {
                        @strongify(self);
                        
                        JCRemindView * remindView = [JCRemindView remindWithMessage:@"挂失账号注销登录成功" hideForTime:3 andHideBlock:nil];
                        
                        [remindView show];
                        
                    } orFailure:^(NSError *error) {
                        
                        
                        
                    }];
                    
                    BGYRapidLossFinishViewController *vc = [BGYRapidLossFinishViewController new];
                    vc.account = self.account;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                } else if (number == -1) {
                    
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"挂失失败" hideForTime:3 andHideBlock:nil];
                    
                    [remindView show];
                    
                } else if (number == 2) {
                    
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"账户不存在" hideForTime:3 andHideBlock:nil];
                    
                    [remindView show];
                    
                } else {
                    
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"没有参数传入" hideForTime:3 andHideBlock:nil];
                    
                    [remindView show];
                    
                }
                
            } orFailure:^(NSError *error) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
            }];
            
        }];
    }
    return _nextButton;
}

- (UILabel *)tipDownLabel {
    if (!_tipDownLabel) {
        _tipDownLabel = [[UILabel alloc] init];
        _tipDownLabel.backgroundColor = UICOLOR_RGB(245, 245, 248, 1);
        _tipDownLabel.textColor = [UIColor lightGrayColor];
        _tipDownLabel.adjustsFontSizeToFitWidth = YES;
        _tipDownLabel.text = @"挂失后账户无法正常使用，资金无法进出，\n解除挂失前任何人都无法登录";
        _tipDownLabel.numberOfLines = 2;
    }
    return _tipDownLabel;
}

@end
