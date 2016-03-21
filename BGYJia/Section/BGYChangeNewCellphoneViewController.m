//
//  BGYChangeNewCellphoneViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/7.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYChangeNewCellphoneViewController.h"
#import "BGYChangeCellphoneFinishViewController.h"

#import "BGYRegisterForInputView.h"
#import "BGYLineButton.h"

@interface BGYChangeNewCellphoneViewController ()

@property (nonatomic , strong) TPKeyboardAvoidingScrollView * backgroundView;

@property (nonatomic , strong) UILabel * cellphoneLabel;

@property (nonatomic , strong) UILabel * remindLabel;

@property (nonatomic , strong) BGYLineButton * countryChoseButton;

@property (nonatomic , strong) BGYRegisterForInputView * cellphoneView;

@property (nonatomic , strong) BGYRegisterForInputView * validationCodeView;

@property (nonatomic , strong) BGYRegisterForInputView * idCardView;

@property (nonatomic , strong) UIButton * nextButton;

@property (nonatomic , assign) NSInteger validationCode;

@end

@implementation BGYChangeNewCellphoneViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpChangeNewCellphoneSystemUI];
    
    [self setUpChangeNewCellphoneUI];
}

-(void)setUpChangeNewCellphoneSystemUI
{
    self.titleViewString = @"更换绑定手机号";
    
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f8);
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
}

-(void)setUpChangeNewCellphoneUI
{
    [self.view addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.remindLabel];
    [self.backgroundView addSubview:self.cellphoneLabel];
    [self.backgroundView addSubview:self.countryChoseButton];
    [self.backgroundView addSubview:self.cellphoneView];
    [self.backgroundView addSubview:self.validationCodeView];
    [self.backgroundView addSubview:self.idCardView];
    
    [self.backgroundView addSubview:self.nextButton];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.backgroundView.mas_top).with.offset(26);
        make.width.equalTo(self.backgroundView.mas_width);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.05);
    }];
    
    [self.cellphoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.remindLabel.mas_bottom);
        make.width.equalTo(self.backgroundView.mas_width);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.075);
    }];
    
    [self.countryChoseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.cellphoneLabel.mas_bottom).with.offset(20.0);
        make.width.equalTo(self.backgroundView.mas_width).multipliedBy(0.2);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.cellphoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.countryChoseButton.mas_trailing);
        make.top.equalTo(self.cellphoneLabel.mas_bottom).with.offset(20.0);
        make.width.equalTo(self.backgroundView.mas_width).multipliedBy(0.8);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.validationCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.cellphoneView.mas_bottom);
        make.width.equalTo(self.backgroundView);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.idCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.validationCodeView.mas_bottom);
        make.width.equalTo(self.backgroundView);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading).with.offset(12.5);
        make.top.equalTo(self.idCardView.mas_bottom).with.offset(30.5);
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
                
                [self.validationCodeView.rightButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                
                self.validationCodeView.rightButton.userInteractionEnabled = YES;
                
                self.validationCodeView.rightButton.selected = NO;
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                JCLog(@"____%@",strTime);
                
                [self.validationCodeView.rightButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                
                self.validationCodeView.rightButton.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}













#pragma mark - initializes attributes

-(TPKeyboardAvoidingScrollView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[TPKeyboardAvoidingScrollView alloc] init];
    }
    return _backgroundView;
}

-(UILabel *)cellphoneLabel
{
    if (!_cellphoneLabel) {
        _cellphoneLabel = [[UILabel alloc] init];
        _cellphoneLabel.textColor = [UIColor blackColor];
        _cellphoneLabel.font = [UIFont systemFontOfSize:18.0f];
        _cellphoneLabel.textAlignment = NSTextAlignmentCenter;
        _cellphoneLabel.adjustsFontSizeToFitWidth = YES;
        User *user = [User runUser];
        _cellphoneLabel.text = [NSString stringWithFormat:@"当前手机号:%@", user.cellphone];
    }
    return _cellphoneLabel;
}

-(UILabel *)remindLabel
{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] init];
        _remindLabel.textColor = UIColorFromRGB(0x99999c);
        _remindLabel.font = [UIFont systemFontOfSize:15.0f];
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.adjustsFontSizeToFitWidth = YES;
        _remindLabel.text = @"更换手机后，下次登录可使用新手机号登录。";
    }
    return _remindLabel;
}
-(BGYLineButton *)countryChoseButton
{
    if (!_countryChoseButton) {
        _countryChoseButton = [[BGYLineButton alloc] init];
        _countryChoseButton.haveLineDown = YES;
        _countryChoseButton.haveLineRight = YES;
        [_countryChoseButton setBackgroundColor:[UIColor whiteColor]];
        [_countryChoseButton setTitle:@"+86" forState:UIControlStateNormal];
        [_countryChoseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _countryChoseButton;
}
-(BGYRegisterForInputView *)cellphoneView
{
    if (!_cellphoneView) {
        _cellphoneView = [[BGYRegisterForInputView alloc] init];
        _cellphoneView.mainPlaceholder = @"请填写新手机号码";
        _cellphoneView.haveLineDown = YES;
    }
    return _cellphoneView;
}
-(BGYRegisterForInputView *)validationCodeView
{
    if (!_validationCodeView) {
        _validationCodeView = [[BGYRegisterForInputView alloc] init];
        _validationCodeView.mainPlaceholder = @"请输入验证码";
        _validationCodeView.haveRightButton = YES;
        _validationCodeView.haveLineDown = YES;
        _validationCodeView.lineColor = UIColorFromRGB(0xe0e0e1);
        
        [_validationCodeView.rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_validationCodeView.rightButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        _validationCodeView.rightButton.layer.borderColor = MAIN_COLOR.CGColor;
        _validationCodeView.rightButton.layer.borderWidth = 1.0f;
        _validationCodeView.rightButton.layer.masksToBounds = YES;
        _validationCodeView.rightButton.layer.cornerRadius = 5.0f;
        
        @weakify(self);
        [[_validationCodeView.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.cellphoneView outOfFirstResponder];
            [self.validationCodeView outOfFirstResponder];
            [self.idCardView outOfFirstResponder];
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.labelText = @"发送验证码...";
            
            NSString * cellphone = [self.cellphoneView getTheInputFieldText];
            
            if (cellphone.length == 0) {
                
                [hud hide:YES];
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入手机号码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            BOOL haveRightCellphone = [RegularTools validateMobile:cellphone];
            
            if (!haveRightCellphone) {
                
                [hud hide:YES];
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入正确的手机号码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            @weakify(self);
            [[JCNetWorking runNetWorking] sendMessageWithCellphone:cellphone Type:SendMessageTypeOther success:^(NSString *message, NSInteger number) {
                @strongify(self);
                
                [hud hide:YES];
                
                self.validationCode = number;
                
                JCRemindView * remindview = [JCRemindView remindWithMessage:message hideForTime:2 andHideBlock:nil];
                
                [remindview show];
                
                if ([message isEqualToString:@"发送成功"]) {
                    
                    [self timerClick];
                    
                }
                
            } orFailure:^(NSError *error) {
                
                [hud hide:YES];
                
                JCRemindView * remindview = [JCRemindView remindWithMessage:@"验证码发送错误，请重试" hideForTime:2 andHideBlock:nil];
                
                [remindview show];
                
            }];
            
        }];
    }
    return _validationCodeView;
}
-(BGYRegisterForInputView *)idCardView
{
    if (!_idCardView) {
        _idCardView = [[BGYRegisterForInputView alloc] init];
        _idCardView.mainPlaceholder = @"请输入身份证";
        _idCardView.haveLineDown = YES;
    }
    return _idCardView;
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
            
            [self.cellphoneView outOfFirstResponder];
            [self.validationCodeView outOfFirstResponder];
            [self.idCardView outOfFirstResponder];
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.labelText = @"正在核验信息...";
            
            NSString * cellphone = [self.cellphoneView getTheInputFieldText];

            NSInteger validationCode = [[self.validationCodeView getTheInputFieldText] integerValue];
            
            NSString * idCardCode = [self.idCardView getTheInputFieldText];
            
            if (!idCardCode.length) {
                
                [hud hide:YES];
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入验证码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            BOOL haveRightValidationCode = validationCode == self.validationCode?YES:NO;

            BOOL haveRightIdCardCode = [RegularTools validateIdentityCard:idCardCode];

            if (!haveRightValidationCode) {
                
                [hud hide:YES];
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入正确的验证码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            if (!haveRightIdCardCode) {
                
                [hud hide:YES];
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入正确的身份证号码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            @weakify(self);
            [[JCNetWorking runNetWorking] changeCellphoneWithNewNumber:cellphone idCardCode:idCardCode success:^(NSString *message) {
                @strongify(self);
                
                [hud hide:YES];
                
                JCLog(@"-- %@",message);
                
                if ([message isEqualToString:@"修改成功"]) {
                    [self.navigationController pushViewController:[BGYChangeCellphoneFinishViewController new] animated:YES];
                }else{
                    
                    JCRemindView * remindview = [JCRemindView remindWithMessage:message hideForTime:2 andHideBlock:nil];
                    
                    [remindview show];
                    
                }
                
            } orFailure:^(NSError *error) {
                
                [hud hide:YES];
                
                JCRemindView * remindview = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:2 andHideBlock:nil];
                
                [remindview show];
                
                JCLog(@" %@ ",error);

            }];

            
        }];
    }
    return _nextButton;
}


@end
