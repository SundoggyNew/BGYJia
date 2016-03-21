//
//  BGYRegisterNotOwnerFinishViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/4.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYRegisterNotOwnerFinishViewController.h"

@interface BGYRegisterNotOwnerFinishViewController ()

@property (nonatomic , strong) UILabel * remindLabel;

@property (nonatomic , strong) UIButton * finishButton;

@end

@implementation BGYRegisterNotOwnerFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBGYRegisterNotOwnerFinishSystemUI];
    
    [self setUpBGYRegisterNotOwnerFinishUI];
}
-(void)setUpBGYRegisterNotOwnerFinishSystemUI
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

-(void)setUpBGYRegisterNotOwnerFinishUI
{
    [self.view addSubview:self.remindLabel];
    [self.view addSubview:self.finishButton];
    
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).with.offset(SELF_VIEW_WIDTH*0.173333333);
        make.top.equalTo(self.view.mas_top).with.offset(SELF_VIEW_HEIGHT*0.203928036);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.653333333);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).with.offset(12.5);
        make.top.equalTo(self.remindLabel.mas_bottom).with.offset(70);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.122666667);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.933333333);
    }];
}










#pragma mark - initializes attributes

-(UILabel *)remindLabel
{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] init];
        _remindLabel.numberOfLines = 2;
        _remindLabel.textColor = UIColorFromRGB(0x99999c);
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.text = @"您的注册申请已经提交给业主\n审核通过后可用账号密码登录";
    }
    return _remindLabel;
}

-(UIButton *)finishButton
{
    if (!_finishButton) {
        _finishButton = [[UIButton alloc] init];
        [_finishButton setTitle:@"知道了" forState:UIControlStateNormal];
        [_finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishButton.backgroundColor = MAIN_COLOR;
        _finishButton.layer.masksToBounds = YES;
        _finishButton.layer.cornerRadius = 8.0f;
        
        @weakify(self);
        [[_finishButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }];
    }
    return _finishButton;
}

@end
