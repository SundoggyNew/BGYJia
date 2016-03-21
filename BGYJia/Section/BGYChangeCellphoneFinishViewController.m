//
//  BGYChangeCellphoneFinishViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/7.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//
#import "BGYChangeCellphoneFinishViewController.h"

@interface BGYChangeCellphoneFinishViewController ()

@property (nonatomic , strong) UILabel     * remindLabel;

@property (nonatomic , strong) UIImageView * remindImageView;

@property (nonatomic , strong) UIButton    * finishButton;

@property (nonatomic , strong) NSString    * cellphone;

@end

@implementation BGYChangeCellphoneFinishViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

+(instancetype)newWithCellPhone:(NSString *)cellphone
{
    BGYChangeCellphoneFinishViewController * finishVC = [BGYChangeCellphoneFinishViewController new];
    finishVC.cellphone = cellphone;
    
    NSString * text = [NSString stringWithFormat:@"新手机登录名设置成功\n下次请使用%@登录\n登录密码不变",cellphone];
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x99999c) range:NSMakeRange(0, 16)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x99999c) range:NSMakeRange(27, 9)];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30.0f] range:NSMakeRange(16, 11)];
    
    finishVC.remindLabel.attributedText = attributedString;
    
    return finishVC;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpChangeNewCellphoneSystemUI];
    
    [self setUpChangeNewCellphoneUI];
}

-(void)setUpChangeNewCellphoneSystemUI
{
    self.titleViewString = @"更换绑定手机";
    
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
    [self.view addSubview:self.remindImageView];
    [self.view addSubview:self.remindLabel];
    [self.view addSubview:self.finishButton];
    
    [self.remindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(SELF_VIEW_HEIGHT*0.15);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.294666667);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.18);
    }];
    
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).with.offset(12.5);
        make.top.equalTo(self.remindImageView.mas_bottom).with.offset(SELF_VIEW_HEIGHT*0.10);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.122666667);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.933333333);
    }];
    
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).with.offset(12.5);
        make.top.equalTo(self.remindLabel.mas_bottom).with.offset(20);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.122666667);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.933333333);
    }];
}







#pragma mark -  set method










#pragma mark - initializes attributes

-(UIImageView *)remindImageView
{
    if (!_remindImageView) {
        _remindImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone_icon"]];
    }
    return _remindImageView;
}
-(UILabel *)remindLabel
{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] init];
        _remindLabel.numberOfLines = 3;
        _remindLabel.font = [UIFont systemFontOfSize:23.0f];
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.adjustsFontSizeToFitWidth = YES;
        
        NSString * text = @"新手机登录名设置成功\n下次请使用18476658843登录\n登录密码不变";
        
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        [attributedString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x99999c) range:NSMakeRange(0, 16)];
        [attributedString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x99999c) range:NSMakeRange(27, 9)];
        
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30.0f] range:NSMakeRange(16, 11)];
        
        _remindLabel.attributedText = attributedString;
    }
    return _remindLabel;
}

-(UIButton *)finishButton
{
    if (!_finishButton) {
        _finishButton = [[UIButton alloc] init];
        [_finishButton setTitle:@"确定" forState:UIControlStateNormal];
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
