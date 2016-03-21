//
//  BGYRapidLossAccountViewController.m
//  BGYJia
//
//  Created by 全民尚网 on 16/3/7.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYRapidLossAccountViewController.h"
#import "BGYRapidLossCheckIDViewController.h"
#import "BGYBasicView.h"

@interface BGYRapidLossAccountViewController ()

/** 承载键盘遮挡背景 View */
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *backScrollView;

@property (nonatomic, strong) BGYBasicView *lossAccountView;

@property (nonatomic, strong) UITextField *accountTextField;

@property (nonatomic, strong) UILabel *tipUpLabel;

@property (nonatomic, strong) UILabel *tipDownLabel;

@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation BGYRapidLossAccountViewController

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
        
        [self.accountTextField resignFirstResponder];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)setUpNewRegisterUI {
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.lossAccountView];
    [self.lossAccountView addSubview:self.accountTextField];
    [self.backScrollView addSubview:self.tipUpLabel];
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
    
    [self.lossAccountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.backScrollView.mas_top).with.offset(35);
        make.width.equalTo(self.backScrollView.mas_width);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.12);
    }];
    
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 15, 1, 80));
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.lossAccountView.mas_bottom).with.offset(35);
        make.width.equalTo(self.backScrollView.mas_width).multipliedBy(0.93);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.12);
    }];
    
    [self.tipDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.nextButton.mas_bottom);
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
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(7,18)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,7)];
        _tipUpLabel.attributedText = str;
        _tipUpLabel.adjustsFontSizeToFitWidth = YES;
        _tipUpLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipUpLabel;
}

- (BGYBasicView *)lossAccountView {
    if (!_lossAccountView) {
        _lossAccountView = [[BGYBasicView alloc] init];
        _lossAccountView.backgroundColor = [UIColor whiteColor];
        _lossAccountView.haveLineDown = YES;
        _lossAccountView.lineColor = [UIColor lightGrayColor];
    }
    return _lossAccountView;
}

- (UITextField *)accountTextField {
    if (!_accountTextField) {
        _accountTextField = [[UITextField alloc] init];
        _accountTextField.placeholder = @"请输入挂失账号";
        _accountTextField.backgroundColor = [UIColor whiteColor];
    }
    return _accountTextField;
}

- (UIButton *)nextButton {
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
            
            [self.accountTextField resignFirstResponder];
            
            NSString *account = self.accountTextField.text;
            
            if (account.length == 0) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入挂失账号" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
                
            }
            
            BOOL haveRightCellPhone = [RegularTools validateMobile:self.accountTextField.text];
            
            if (!haveRightCellPhone) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入正确的挂失账号" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            @weakify(self);
            [[JCNetWorking runNetWorking] searchCellphoneExist:self.accountTextField.text Success:^(NSDictionary *dictionary) {
                @strongify(self);
                
                if ([[dictionary objectForKey:@"errorcode"] integerValue] == 2 || [[dictionary objectForKey:@"errorcode"] integerValue] == 3) {
                    
                    BGYRapidLossCheckIDViewController *vc = [BGYRapidLossCheckIDViewController new];
                    vc.account = self.accountTextField.text;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                } else {
                    
                    JCRemindView * remindView = [JCRemindView remindWithMessage:@"该挂失账号不存在" hideForTime:3 andHideBlock:nil];
                    
                    [remindView show];
                    
                }
                
            } orFailure:^(NSError *error) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"连接错误请重试" hideForTime:3 andHideBlock:nil];
                
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
        _tipDownLabel.text = @"请在手机丢失或出现资金风险时，及时挂失";
        _tipDownLabel.numberOfLines = 2;
    }
    return _tipDownLabel;
}

@end
