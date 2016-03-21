//
//  BGYChangeCellphoneViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/7.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYChangeCellphoneViewController.h"
#import "BGYChangeNewCellphoneViewController.h"

@interface BGYChangeCellphoneViewController ()

@property (nonatomic , strong) UILabel * cellphoneLabel;

@property (nonatomic , strong) UILabel * remindLabel;

@property (nonatomic , strong) UIButton * finishButton;

@end

@implementation BGYChangeCellphoneViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    User * user = [User runUser];
    
    self.cellphoneLabel.text = [NSString stringWithFormat:@"您的手机号:%@",user.cellphone];

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpChangeCellphoneSystemUI];
    
    [self setUpChangeCellphoneUI];
}

-(void)setUpChangeCellphoneSystemUI
{
    self.titleViewString = @"手机号";
    
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f8);
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
}

-(void)setUpChangeCellphoneUI
{
    [self.view addSubview:self.cellphoneLabel];
    [self.view addSubview:self.remindLabel];
    [self.view addSubview:self.finishButton];
    
    [self.cellphoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.top.equalTo(self.view.mas_top).with.offset(SELF_VIEW_HEIGHT*0.154);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).with.offset(12.5);
        make.top.equalTo(self.cellphoneLabel.mas_bottom).with.offset(50);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.122666667);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.933333333);

    }];
    
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).with.offset(12.5);
        make.top.equalTo(self.remindLabel.mas_bottom).with.offset(5);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.122666667);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.933333333);
    }];
}







#pragma mark - initializes attributes

-(UILabel *)cellphoneLabel
{
    if (!_cellphoneLabel) {
        _cellphoneLabel = [[UILabel alloc] init];
        _cellphoneLabel.textColor = [UIColor blackColor];
        _cellphoneLabel.font = [UIFont systemFontOfSize:23.0f];
        _cellphoneLabel.textAlignment = NSTextAlignmentCenter;
        _cellphoneLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _cellphoneLabel;
}

-(UILabel *)remindLabel
{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] init];
        _remindLabel.numberOfLines = 2;
        _remindLabel.textColor = UIColorFromRGB(0x99999c);
        _remindLabel.font = [UIFont systemFontOfSize:23.0f];
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.adjustsFontSizeToFitWidth = YES;
        _remindLabel.text = @"一个手机号只能作为一个账号的登录名，如更改手机号码，\n您在物业的房产车辆登记手机也将随之更改";
    }
    return _remindLabel;
}

-(UIButton *)finishButton
{
    if (!_finishButton) {
        _finishButton = [[UIButton alloc] init];
        [_finishButton setTitle:@"更换手机号" forState:UIControlStateNormal];
        [_finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishButton.backgroundColor = MAIN_COLOR;
        _finishButton.layer.masksToBounds = YES;
        _finishButton.layer.cornerRadius = 8.0f;
        
        @weakify(self);
        [[_finishButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.navigationController pushViewController:[BGYChangeNewCellphoneViewController new] animated:YES];
            
        }];
    }
    return _finishButton;
}

@end
