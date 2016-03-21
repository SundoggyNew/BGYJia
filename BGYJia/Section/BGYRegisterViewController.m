//
//  BGYRegisterViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYRegisterViewController.h"
#import "BGYRegisterForCellPhoneViewController.h"

@interface BGYRegisterViewController ()

@property (nonatomic , strong) UIButton * theOwnerButton;

@property (nonatomic , strong) UIButton * notOwnerButton;

@end

@implementation BGYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpRegisterSystemUI];
    
    [self setUpRegisterUI];
}
-(void)setUpRegisterSystemUI
{
    self.titleViewString = @"注 册";
    
    self.view.backgroundColor = UIColorFromRGB(0xfa4964);
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}

-(void)setUpRegisterUI
{
    [self.view addSubview:self.theOwnerButton];
    [self.view addSubview:self.notOwnerButton];
    
    [self.theOwnerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.height.equalTo(@((SELF_VIEW_HEIGHT- 64 - 10)/2.0));
        make.width.equalTo(self.view.mas_width).with.offset(1);
    }];
    
    [self.notOwnerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.top.equalTo(self.theOwnerButton.mas_bottom).with.offset(11);
        make.width.equalTo(self.view.mas_width).with.offset(1);
        make.height.equalTo(@((SELF_VIEW_HEIGHT- 64 - 10)/2.0));
    }];
}




#pragma mark - initializes attributes
-(UIButton *)theOwnerButton
{
    if (!_theOwnerButton) {
        _theOwnerButton = [[UIButton alloc] init];
        [_theOwnerButton setTitle:@"你是业主？" forState:UIControlStateNormal];
        [_theOwnerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_theOwnerButton setBackgroundImage:[UIImage imageNamed:@"bg_top"] forState:UIControlStateNormal];
        _theOwnerButton.titleLabel.font = [UIFont systemFontOfSize:20.0f];
        
        @weakify(self);
        [[_theOwnerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.navigationController pushViewController:[BGYRegisterForCellPhoneViewController newWithType:REGISTER_TYPE_OWNER] animated:YES];
            
        }];
    }
    return _theOwnerButton;
}

-(UIButton *)notOwnerButton
{
    if (!_notOwnerButton) {
        _notOwnerButton = [[UIButton alloc] init];
        _notOwnerButton.titleLabel.numberOfLines = 2;
        _notOwnerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _notOwnerButton.titleLabel.font = [UIFont systemFontOfSize:20.0f];
        [_notOwnerButton setTitle:@"你是业主家人\n朋友、或者租客？" forState:UIControlStateNormal];
        [_notOwnerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_notOwnerButton setBackgroundImage:[UIImage imageNamed:@"bg_bot"] forState:UIControlStateNormal];

        @weakify(self);
        [[_notOwnerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.navigationController pushViewController:[BGYRegisterForCellPhoneViewController newWithType:REGISTER_TYPE_NOTOWNER] animated:YES];
            
        }];
    }
    return _notOwnerButton;
}

@end
