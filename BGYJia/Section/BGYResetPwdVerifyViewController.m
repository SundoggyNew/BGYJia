//
//  BGYResetPwdVerifyViewController.m
//  BGYJia
//
//  Created by 全民尚网 on 16/3/7.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYResetPwdVerifyViewController.h"
#import "BGYResetPwdViewController.h"
#import "BGYBasicView.h"

@interface BGYResetPwdVerifyViewController ()

/** 承载键盘遮挡背景 View */
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *backScrollView;

@property (nonatomic, strong) BGYBasicView *verificationView;

@property (nonatomic, strong) UITextField *verifyTextField;

@property (nonatomic, strong) UIButton *rightViewBtn;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, assign) NSInteger validationCode;

@end

@implementation BGYResetPwdVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_RGB(245, 245, 248, 1);
    
    [self setUpNewRegisterSystemUI];
    
    [self setUpNewRegisterUI];
    
}

#pragma mark - private method

- (void)setUpNewRegisterSystemUI {
    self.titleViewString = @"验证手机号";
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.verifyTextField resignFirstResponder];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)setUpNewRegisterUI {
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.verificationView];
    [self.verificationView addSubview:self.verifyTextField];
    [self.verificationView addSubview:self.rightViewBtn];
    [self.backScrollView addSubview:self.tipLabel];
    [self.backScrollView addSubview:self.nextButton];
    
    [self.backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.verificationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.tipLabel.mas_bottom);
        make.width.equalTo(self.backScrollView.mas_width);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.12);
    }];
    
    [self.verifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 15, 1, 80));
    }];
    
    [self.rightViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.bottom.trailing.mas_equalTo(-8);
        make.leading.equalTo(self.verifyTextField.mas_trailing);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.backScrollView.mas_top);
        make.leading.equalTo(self.backScrollView.mas_leading).with.offset(15);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.12);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.verificationView.mas_bottom).with.offset(28);
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

#pragma mark - initializes attributes

- (TPKeyboardAvoidingScrollView *)backScrollView {
    if (!_backScrollView) {
        _backScrollView = [[TPKeyboardAvoidingScrollView alloc] init];
    }
    return _backScrollView;
}

- (BGYBasicView *)verificationView {
    if (!_verificationView) {
        _verificationView = [[BGYBasicView alloc] init];
        _verificationView.backgroundColor = [UIColor whiteColor];
        _verificationView.haveLineDown = YES;
        _verificationView.lineColor = [UIColor lightGrayColor];
    }
    return _verificationView;
}

- (UITextField *)verifyTextField {
    if (!_verifyTextField) {
        _verifyTextField = [[UITextField alloc] init];
        _verifyTextField.placeholder = @"请输入验证码";
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
            
            [self.verifyTextField resignFirstResponder];
            
            User *user = [User runUser];
            
            @weakify(self);
            [[JCNetWorking runNetWorking] sendMessageWithCellphone:user.cellphone Type:SendMessageTypeForgotPassword success:^(NSString *message, NSInteger number) {
                @strongify(self);
                
                if ([message isEqualToString:@"发送成功"]) {
                    [self timerClick];
                }
                
                self.validationCode = number;
                
                JCRemindView *remindView = [JCRemindView remindWithMessage:message hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
            } orFailure:^(NSError *error) {
                
                JCRemindView *remindView = [JCRemindView remindWithMessage:@"网络错误，请重试" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
            }];
            
        }];
    }
    return _rightViewBtn;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        
        User *user = [User runUser];
        NSMutableString *cellphone = [user.cellphone mutableCopy];
        [cellphone deleteCharactersInRange:NSMakeRange(3, 1)];
        [cellphone replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        
        _tipLabel.text = [NSString stringWithFormat:@"请输入%@收到的短信验证码",cellphone];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tipLabel;
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
            
            [self.verifyTextField resignFirstResponder];
            
            if (!self.verifyTextField.text.length) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入验证码" hideForTime:2 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            if ([self.verifyTextField.text isEqualToString:[NSString stringWithFormat:@"%ld",self.validationCode]]) {
                
                [self.navigationController pushViewController:[BGYResetPwdViewController new] animated:YES];
                
            } else {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入正确的验证码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
            }
            
        }];
    }
    return _nextButton;
}


@end
