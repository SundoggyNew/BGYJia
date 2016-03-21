//
//  BGYFindPwdVerifyViewController.m
//  BGYJia
//
//  Created by 全民尚网 on 16/3/3.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYFindPwdVerifyViewController.h"
#import "BGYFindPwdResetViewController.h"
#import "BGYBasicView.h"

@interface BGYFindPwdVerifyViewController ()

/** 承载键盘遮挡背景 View */
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *backScrollView;

@property (nonatomic, strong) BGYBasicView *verificationView;

@property (nonatomic, strong) UITextField *verifyTextField;

@property (nonatomic, strong) UIButton *rightViewBtn;

@property (nonatomic, strong) BGYBasicView *phoneNumView;

@property (nonatomic, strong) UITextField *phoneNumTextField;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, copy) VSBlock disappearBlock;

@property (nonatomic, assign) NSInteger validationCode;

@end

@implementation BGYFindPwdVerifyViewController

- (void)dealloc {
    self.disappearBlock = nil;
}

+ (instancetype)newWithMessage:(VSBlock)eventBlock {
    BGYFindPwdVerifyViewController *findVC = [self new];
    findVC.disappearBlock = eventBlock;
    return findVC;
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
        
        [self.verifyTextField resignFirstResponder];
        
        [self.phoneNumTextField resignFirstResponder];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)setUpNewRegisterUI {
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.phoneNumView];
    [self.phoneNumView addSubview:self.phoneNumTextField];
    [self.backScrollView addSubview:self.verificationView];
    [self.verificationView addSubview:self.verifyTextField];
    [self.verificationView addSubview:self.rightViewBtn];
    [self.backScrollView addSubview:self.tipLabel];
    [self.backScrollView addSubview:self.nextButton];
    
    [self.backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.phoneNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.backScrollView.mas_top).with.offset(35);
        make.width.equalTo(self.backScrollView.mas_width);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.12);
    }];
    
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 15, 1, 80));
    }];
    
    [self.verificationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.phoneNumView.mas_bottom);
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
        make.top.equalTo(self.backScrollView.mas_top).with.offset(8);
        make.width.equalTo(self.backScrollView.mas_width);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.06);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.backScrollView.mas_top).with.offset(156);
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

- (BGYBasicView *)phoneNumView {
    if (!_phoneNumView) {
        _phoneNumView = [[BGYBasicView alloc] init];
        _phoneNumView.backgroundColor = [UIColor whiteColor];
        _phoneNumView.haveLineDown = YES;
        _phoneNumView.lineColor = [UIColor lightGrayColor];
    }
    return _phoneNumView;
}

- (UITextField *)phoneNumTextField {
    if (!_phoneNumTextField) {
        _phoneNumTextField = [[UITextField alloc] init];
        _phoneNumTextField.placeholder = @"请输入手机号";
        _phoneNumTextField.backgroundColor = [UIColor whiteColor];
    }
    return _phoneNumTextField;
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
            
            [self.phoneNumTextField resignFirstResponder];
            [self.verifyTextField resignFirstResponder];
            
            if (self.phoneNumTextField.text.length == 0) {
                
                JCRemindView *remindView = [JCRemindView remindWithMessage:@"请输入手机号码" hideForTime:3 andHideBlock:nil];
                [remindView show];
                return ;
                
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

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"1验证手机 > 2设置密码"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(8,5)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,7)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:NSMakeRange(0,13)];
        _tipLabel.attributedText = str;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
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
            
            [self.phoneNumTextField resignFirstResponder];
            [self.verifyTextField resignFirstResponder];
            
            if (!self.verifyTextField.text.length) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入验证码" hideForTime:2 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            if ([self.verifyTextField.text isEqualToString:[NSString stringWithFormat:@"%ld",(long)self.validationCode]]) {
                
                BGYFindPwdResetViewController *findVC = [BGYFindPwdResetViewController newWithMessage:^{
                    self.disappearBlock(self.phoneNumTextField.text);
                }];
                
                findVC.cellphone = self.phoneNumTextField.text;
                
                
                [self.navigationController pushViewController:findVC animated:YES];
                
            } else {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入正确的验证码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
            }
            
            
            
        }];
    }
    return _nextButton;
}

@end
