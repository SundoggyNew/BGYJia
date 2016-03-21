//
//  BGYRegisterForCellPhoneViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//
#import "BGYRegisterForCellPhoneViewController.h"
#import "BGYRegisterForSetPswViewController.h"
#import "BGYNotOwnerRegisterViewController.h"

#import "BGYRegisterForInputView.h"

@interface BGYRegisterForCellPhoneViewController ()

@property (nonatomic , strong) TPKeyboardAvoidingScrollView * backgroundView;

@property (nonatomic , strong) BGYRegisterForInputView * cellPhoneInputView;

@property (nonatomic , strong) BGYRegisterForInputView * validationCodeInputView;

@property (nonatomic , strong) BGYRegisterForInputView * idCardInputView;

@property (nonatomic , strong) UIButton * nextButton;

@property (nonatomic , assign) NSInteger validationCode;

@end

@implementation BGYRegisterForCellPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpRegisterForCellPhoneSystemUI];
    
    [self setUpRegisterForCellPhoneUI];
}
-(void)setUpRegisterForCellPhoneSystemUI
{
    self.titleViewString = @"注 册";
    
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f8);
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}

-(void)setUpRegisterForCellPhoneUI
{
    if (self.type == REGISTER_TYPE_NOTOWNER) {
        self.idCardInputView.hidden = YES;
    }else{
        self.idCardInputView.alpha = 0;
    }
    
    [self.view addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.cellPhoneInputView];
    [self.backgroundView addSubview:self.validationCodeInputView];
    [self.backgroundView addSubview:self.idCardInputView];
    [self.backgroundView addSubview:self.nextButton];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.cellPhoneInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.backgroundView.mas_top).with.offset(26);
        make.width.equalTo(self.backgroundView);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.validationCodeInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.cellPhoneInputView.mas_bottom);
        make.width.equalTo(self.backgroundView);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.idCardInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.validationCodeInputView.mas_bottom);
        make.width.equalTo(self.backgroundView);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading).with.offset(12.5);
        make.top.equalTo(self.idCardInputView.mas_bottom).with.offset(30.5);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.122666667);
        make.width.equalTo(self.backgroundView.mas_width).multipliedBy(0.933333333);
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
                
                [self.validationCodeInputView.rightButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                
                self.validationCodeInputView.rightButton.userInteractionEnabled = YES;
                
                self.validationCodeInputView.rightButton.selected = NO;
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                JCLog(@"____%@",strTime);
                
                [self.validationCodeInputView.rightButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                
                self.validationCodeInputView.rightButton.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

#pragma mark - public method

+(instancetype)newWithType:(REGISTER_TYPE)type
{
    BGYRegisterForCellPhoneViewController * registerForCellPhoneVC = [BGYRegisterForCellPhoneViewController new];
    
    registerForCellPhoneVC.type = type;
    
    return registerForCellPhoneVC;
}

#pragma mark - initializes attributes

-(TPKeyboardAvoidingScrollView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[TPKeyboardAvoidingScrollView alloc] init];
    }
    return _backgroundView;
}
-(BGYRegisterForInputView *)cellPhoneInputView
{
    if (!_cellPhoneInputView) {
        _cellPhoneInputView = [[BGYRegisterForInputView alloc] init];
        _cellPhoneInputView.mainPlaceholder = @"请输入手机号码";
    }
    return _cellPhoneInputView;
}
-(BGYRegisterForInputView *)validationCodeInputView
{
    if (!_validationCodeInputView) {
        _validationCodeInputView = [[BGYRegisterForInputView alloc] init];
        _validationCodeInputView.mainPlaceholder = @"请输入验证码";
        _validationCodeInputView.haveRightButton = YES;
        _validationCodeInputView.haveLineDown = YES;
        _validationCodeInputView.lineColor = UIColorFromRGB(0xe0e0e1);
        
        [_validationCodeInputView.rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_validationCodeInputView.rightButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        _validationCodeInputView.rightButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _validationCodeInputView.rightButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _validationCodeInputView.rightButton.layer.borderColor = MAIN_COLOR.CGColor;
        _validationCodeInputView.rightButton.layer.borderWidth = 1.0f;
        _validationCodeInputView.rightButton.layer.masksToBounds = YES;
        _validationCodeInputView.rightButton.layer.cornerRadius = 5.0f;
        
        @weakify(self);
        [[_validationCodeInputView.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.cellPhoneInputView outOfFirstResponder];
            [self.validationCodeInputView outOfFirstResponder];
            [self.idCardInputView outOfFirstResponder];
            
            NSString * cellphone  = [self.cellPhoneInputView getTheInputFieldText];
            
            if (cellphone.length == 0) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入手机号码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
                
            }
            
            BOOL haveRightCellphone       = [RegularTools validateMobile:cellphone];
            
            if (!haveRightCellphone) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入正确的手机号码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
                
            }
            
            //判断用户类型 REGISTER_TYPE_OWNER业主 REGISTER_TYPE_NOTOWNER非业主
            switch (self.type) {
                case REGISTER_TYPE_OWNER:
                {
                    
                    //是业主，检测手机号是否存在
                    @weakify(self);
                    [[JCNetWorking runNetWorking] searchCellphoneExist:[self.cellPhoneInputView getTheInputFieldText] Success:^(NSDictionary *dictionary) {
                        @strongify(self);
                        
                        if ([[dictionary objectForKey:@"errorcode"] integerValue] == 0) {
                            
                            //如果手机号不存在，显示验证身份证号码视图
                            [UIView animateWithDuration:0.5 animations:^{
                                
                                self.idCardInputView.alpha = 1;
                                
                            } completion:^(BOOL finished) {
                                
                                self.idCardInputView.alpha = 1;
                                
                            }];
                            
                        } else if ([[dictionary objectForKey:@"errorcode"] integerValue] == 3) {
                        
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"您是非业主，请按非业主的身份注册" hideForTime:2 andHideBlock:nil];
                            
                            [remindView show];
                        
                            [self.nextButton setTitle:@"请返回重新选择您的身份" forState:UIControlStateNormal];
                            [self.nextButton setBackgroundColor:[UIColor lightGrayColor]];
                            self.nextButton.enabled = NO;
                            
                        } else {
                            
                        }
                        
                    } orFailure:^(NSError *error) {
                        
                        JCRemindView * remindView = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:2 andHideBlock:nil];
                        
                        [remindView show];
                        
                    }];
                    
                }
                    break;
                case REGISTER_TYPE_NOTOWNER:
                {
                    
                    
                    
                }
                    break;
            }
            
            //发送短信
            @weakify(self);
            [[JCNetWorking runNetWorking] sendMessageWithCellphone:[self.cellPhoneInputView getTheInputFieldText] Type:SendMessageTypeRegister success:^(NSString *message, NSInteger number) {
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
    return _validationCodeInputView;
}

-(BGYRegisterForInputView *)idCardInputView
{
    if (!_idCardInputView) {
        _idCardInputView = [[BGYRegisterForInputView alloc] init];
        _idCardInputView.mainPlaceholder = @"请输入身份证";
//        _idCardInputView.hidden = YES;
    }
    return _idCardInputView;
}

-(UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] init];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextButton.backgroundColor = MAIN_COLOR;
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.cornerRadius = 8.0f;
        
        @weakify(self);
        [[_nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.cellPhoneInputView outOfFirstResponder];
            [self.validationCodeInputView outOfFirstResponder];
            [self.idCardInputView outOfFirstResponder];
            

            NSString * cellphone  = [self.cellPhoneInputView getTheInputFieldText];
            
            if (![self.validationCodeInputView getTheInputFieldText].length) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入验证码" hideForTime:2 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            if (cellphone.length == 0) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"内容不能为空" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
                
            }
            
            BOOL haveRightCellphone       = [RegularTools validateMobile:cellphone];
            
            if (!haveRightCellphone) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"手机号码格式不正确" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
                
            }
            
            switch (self.type) {
                case REGISTER_TYPE_OWNER:
                {
                    
                    //判断验证码是否正确
                    if ([[self.validationCodeInputView getTheInputFieldText] isEqualToString:[NSString stringWithFormat:@"%ld",self.validationCode]]) {
                    
                        if (self.idCardInputView.alpha == 0) {
                            
                            //验证码正确、业主手机也能查到跳至BGYRegisterForSetPswViewController
                            BGYRegisterForSetPswViewController *vc = [BGYRegisterForSetPswViewController newWithType:REGISTER_TYPE_OWNER];
                            vc.cellphone = [self.cellPhoneInputView getTheInputFieldText];
                            [self.navigationController pushViewController:vc animated:YES];
                            
                        } else {
                            
                            NSString * idcard  = [self.idCardInputView getTheInputFieldText];
                            
                            if (idcard.length == 0) {
                                
                                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入身份证号码" hideForTime:3 andHideBlock:nil];
                                
                                [remindView show];
                                
                                return;
                                
                            }
                            
                            BOOL haveRightIdcard       = [RegularTools validateIdentityCard:[self.idCardInputView getTheInputFieldText]];
                            
                            if (!haveRightIdcard) {
                                
                                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入正确的身份证号码" hideForTime:3 andHideBlock:nil];
                                
                                [remindView show];
                                
                                return;
                                
                            }
                            
                            @weakify(self);
                            [[JCNetWorking runNetWorking] searchIDCardExist:[self.idCardInputView getTheInputFieldText] Success:^(NSDictionary *dictionary) {
                                @strongify(self);
                                
                                //验证码正确、身份证也能查到 是业主 跳至BGYRegisterForSetPswViewController
                                if ([[dictionary objectForKey:@"errorcode"] integerValue] == 2) {
                                    BGYRegisterForSetPswViewController *vc = [BGYRegisterForSetPswViewController newWithType:REGISTER_TYPE_OWNER];
                                    vc.cellphone = [self.cellPhoneInputView getTheInputFieldText];
                                    [self.navigationController pushViewController:vc animated:YES];
                                } else if ([[dictionary objectForKey:@"errorcode"] integerValue] == 3) {
                                
                                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"您是非业主，请按非业主的身份注册" hideForTime:2 andHideBlock:nil];
                                    
                                    [remindView show];
                                    
                                } else {
                                    
                                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"输入的身份证号不存在" hideForTime:3 andHideBlock:nil];
                                    
                                    [remindView show];
                                    
                                }
                                
                            } orFailure:^(NSError *error) {
                                
                                JCLog(@"error%@", error);
                                
                            }];
                            
                        }
                        
                    } else {
                        
                        JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入正确的验证码" hideForTime:3 andHideBlock:nil];
                        
                        [remindView show];
                        
                    }
    
                }
                    break;
                case REGISTER_TYPE_NOTOWNER:
                {
                    //判断验证码是否正确
                    if ([[self.validationCodeInputView getTheInputFieldText] isEqualToString:[NSString stringWithFormat:@"%ld",self.validationCode]]) {
                    
                    BGYNotOwnerRegisterViewController *vc = [BGYNotOwnerRegisterViewController new];
                    vc.cellphone = [self.cellPhoneInputView getTheInputFieldText];
                    [self.navigationController pushViewController:vc animated:YES];
                        
                    } else {
                        
                        JCRemindView * remindView = [JCRemindView remindWithMessage:@"验证码输入不正确" hideForTime:3 andHideBlock:nil];
                        
                        [remindView show];
                        
                    }

                }
                    break;
            }
            
            
        }];
    }
    return _nextButton;
}

@end
