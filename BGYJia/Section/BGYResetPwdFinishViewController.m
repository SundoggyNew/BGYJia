//
//  BGYResetPwdFinishViewController.m
//  BGYJia
//
//  Created by 全民尚网 on 16/3/7.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYResetPwdFinishViewController.h"
#import "BGYLoginViewController.h"

@interface BGYResetPwdFinishViewController ()

@property (nonatomic, strong) UIImageView *tipImageView;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UIButton *completeButton;

@end

@implementation BGYResetPwdFinishViewController

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
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)setUpNewRegisterUI {
    
    [self.view addSubview:self.tipImageView];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.completeButton];
    
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(114);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.tipImageView.mas_bottom).with.offset(8);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.13);
    }];
    
    [self.completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.tipLabel.mas_bottom).with.offset(35);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.93);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.12);
    }];
    
}

#pragma mark - initializes attributes

- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc] init];
        _tipImageView.image = [UIImage imageNamed:@"true"];
    }
    return _tipImageView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"重置登录密码成功";
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UIButton *)completeButton
{
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
            
            [self.navigationController popToRootViewControllerAnimated:NO];
            
            [[BGYTabBarController runTabBar] selectedIndex:0];
            
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[BGYLoginViewController new]];
            
            UIWindow *window                  = [[UIApplication sharedApplication].windows objectAtIndex:0];
            
            window.rootViewController         = nav;
            
        }];
    }
    return _completeButton;
}

@end
