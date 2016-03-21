//
//  BGYRemoveCardLoseViewController.m
//  BGYJia
//
//  Created by 全民尚网 on 16/3/3.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYRemoveCardLoseViewController.h"
#import "BGYRemoveResetPwdViewController.h"

@interface BGYRemoveCardLoseViewController ()<UITableViewDataSource, UITableViewDelegate>

/** 承载键盘遮挡背景 View */
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *backScrollView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextField *accountTextField;

@property (nonatomic, strong) UITextField *nameTextField;

@property (nonatomic, strong) UITextField *idTextField;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation BGYRemoveCardLoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_RGB(245, 245, 248, 1);
    
    [self setUpNewRegisterSystemUI];
    
    [self setUpNewRegisterUI];
    
}

#pragma mark - private method

- (void)setUpNewRegisterSystemUI {
    self.titleViewString = @"解除挂失";
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.accountTextField resignFirstResponder];
        [self.nameTextField resignFirstResponder];
        [self.idTextField resignFirstResponder];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)setUpNewRegisterUI {
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.tableView];
    [self.backScrollView addSubview:self.tipLabel];
    [self.backScrollView addSubview:self.nextButton];
    
    [self.backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.backScrollView.mas_top).with.offset(17);
        make.width.equalTo(self.backScrollView.mas_width);
        make.height.mas_equalTo(132);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.tableView.mas_bottom);
        make.leading.equalTo(self.backScrollView.mas_leading).with.offset(15);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.07);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backScrollView.mas_centerX);
        make.top.equalTo(self.backScrollView.mas_top).with.offset(182);
        make.leading.equalTo(self.backScrollView.mas_leading).with.offset(15);
        make.height.equalTo(self.backScrollView.mas_width).multipliedBy(0.12);
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        self.accountTextField.frame = CGRectMake(15, 0, cell.bounds.size.width, 44);
        [cell.contentView addSubview:self.accountTextField];
        return cell;
    } else if (indexPath.row == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        self.nameTextField.frame = CGRectMake(15, 0, cell.bounds.size.width, 44);
        [cell.contentView addSubview:self.nameTextField];
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        self.idTextField.frame = CGRectMake(15, 0, cell.bounds.size.width, 44);
        [cell.contentView addSubview:self.idTextField];
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
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.bounces = NO;
    }
    return _tableView;
}

- (UITextField *)accountTextField {
    if (!_accountTextField) {
        _accountTextField = [[UITextField alloc] init];
        _accountTextField.placeholder = @"请输入挂失账户";
        _accountTextField.backgroundColor = [UIColor whiteColor];
    }
    return _accountTextField;
}

- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.placeholder = @"请输入姓名";
        _nameTextField.backgroundColor = [UIColor whiteColor];
    }
    return _nameTextField;
}

- (UITextField *)idTextField {
    if (!_idTextField) {
        _idTextField = [[UITextField alloc] init];
        _idTextField.placeholder = @"请输入身份证号码";
        _idTextField.backgroundColor = [UIColor whiteColor];
    }
    return _idTextField;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.backgroundColor = UICOLOR_RGB(245, 245, 248, 1);
        _tipLabel.font = [UIFont systemFontOfSize:13.0f];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.text = @"提示：完成本人身份验证后才能解除挂失";
        _tipLabel.numberOfLines = 2;
    }
    return _tipLabel;
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
            [self.nameTextField resignFirstResponder];
            [self.idTextField resignFirstResponder];
            
            NSString *account = self.accountTextField.text;
            NSString *name    = self.nameTextField.text;
            NSString *idcard  = self.idTextField.text;
            
            if (account.length == 0) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入挂失账户" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
                
            }
            
            if (idcard.length == 0) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入身份证号码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
                
            }
            
            if (name.length == 0) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入真实姓名" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
                
            }
            
            BOOL haveRightCellPhone = [RegularTools validateMobile:self.accountTextField.text];
            BOOL haveRightIDCard    = [RegularTools validateIdentityCard:self.idTextField.text];
            
            if (!haveRightCellPhone) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"挂失账户格式不正确" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            if (!haveRightIDCard) {
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请输入正确的身份证号码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            @weakify(self);
            [[JCNetWorking runNetWorking] searchUserInfoWithCellphone:self.accountTextField.text realname:self.nameTextField.text idCard:self.idTextField.text success:^(NSInteger number) {
                @strongify(self);
                
                if (number == 0) {
                    
                    BGYRemoveResetPwdViewController *vc = [BGYRemoveResetPwdViewController new];
                    
                    vc.idcard = self.idTextField.text;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                } else if (number == 2) {
                    
                    JCRemindView *remindView = [JCRemindView remindWithMessage:@"帐户不存在" hideForTime:3 andHideBlock:nil];
                    
                    [remindView show];
                    
                } else {
                    
                    JCRemindView *remindView = [JCRemindView remindWithMessage:@"帐户信息匹配不成功" hideForTime:3 andHideBlock:nil];
                    
                    [remindView show];
                }
                
            } orFailure:^(NSError *error) {
                
                JCRemindView *remindView = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
            }];
            
        }];
    }
    return _nextButton;
}

@end
