//
//  BGYRapidLossFinishViewController.m
//  BGYJia
//
//  Created by 全民尚网 on 16/3/7.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYRapidLossFinishViewController.h"
#import "BGYSettingTableViewCell.h"

@interface BGYRapidLossFinishViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UILabel *tipUpLabel;

@property (nonatomic, strong) UILabel *accountLabel;

@property (nonatomic, strong) UILabel *tipDownLabel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *completeButton;

@end

@implementation BGYRapidLossFinishViewController

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
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)setUpNewRegisterUI {
    [self.view addSubview:self.tipUpLabel];
    [self.view addSubview:self.accountLabel];
    [self.view addSubview:self.tipDownLabel];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.completeButton];
    
    [self.tipUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(72);
        make.leading.equalTo(self.view.mas_leading).with.offset(20);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.06);
    }];
    
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.tipUpLabel.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.4);
    }];
    
    [self.tipDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.accountLabel.mas_bottom).with.offset(3);
        make.leading.equalTo(self.view.mas_leading).with.offset(20);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.10);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.tipDownLabel.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_offset(132);
    }];
    
    [self.completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.tableView.mas_bottom).with.offset(35);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.93);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.12);
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BGYSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BGYSettingTableViewCell reuseIdentifier]];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"手机丢了?";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"钱少了?";
    } else {
        cell.textLabel.text = @"其他风险?";
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(40, 0, 44, 44);
    [button setImage:[UIImage imageNamed:@"pitch_on_black"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"pitch_on"] forState:UIControlStateSelected];
    cell.accessoryView = button;
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        button.selected = !button.selected;
        
    }];
    return cell;
}

#pragma mark - initializes

- (UILabel *)tipUpLabel {
    if (!_tipUpLabel) {
        _tipUpLabel = [[UILabel alloc] init];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"1填写挂失账号 > 2身份信息验证 > 3挂失成功"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(10,9)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0,9)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(19,6)];
        _tipUpLabel.attributedText = str;
        _tipUpLabel.adjustsFontSizeToFitWidth = YES;
        _tipUpLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipUpLabel;
}

- (UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel = [[UILabel alloc] init];
        _accountLabel.numberOfLines = 2;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"该账号已挂失被保护\n挂失账号：%@", self.account]];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30.0f] range:NSMakeRange(0,9)];
        _accountLabel.attributedText = str;
        _accountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _accountLabel;
}

- (UILabel *)tipDownLabel {
    if (!_tipDownLabel) {
        _tipDownLabel = [[UILabel alloc] init];
        _tipDownLabel.backgroundColor = UICOLOR_RGB(245, 245, 248, 1);
        _tipDownLabel.textColor = [UIColor lightGrayColor];
        _tipDownLabel.adjustsFontSizeToFitWidth = YES;
        _tipDownLabel.text = @"为了更好的服务，请协助选择挂失原因";
        _tipDownLabel.numberOfLines = 2;
    }
    return _tipDownLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.bounces = NO;
        [_tableView registerClass:[BGYSettingTableViewCell class] forCellReuseIdentifier:[BGYSettingTableViewCell reuseIdentifier]];
    }
    return _tableView;
}

- (UIButton *)completeButton {
    if (!_completeButton) {
        _completeButton = [[UIButton alloc] init];
        [_completeButton setTitle:@"确定" forState:UIControlStateNormal];
        [_completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_completeButton setBackgroundColor:UICOLOR_RGB(250, 73, 100, 1)];
        [_completeButton.layer setCornerRadius:5.0f];
        _completeButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        
        @weakify(self);
        [[_completeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }];
    }
    return _completeButton;
}

@end
