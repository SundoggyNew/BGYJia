//
//  BGYAboutUsViewController.m
//  BGYJia
//
//  Created by 全民尚网 on 16/3/8.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYAboutUsViewController.h"

@interface BGYAboutUsViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *tipDownLabel;

@end

@implementation BGYAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UICOLOR_RGB(245, 245, 248, 1);
    
    [self setUpNewRegisterSystemUI];
    
    [self setUpNewRegisterUI];
}

#pragma mark - private method

- (void)setUpNewRegisterSystemUI {
    self.titleViewString = @"关于我们";
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

- (void)setUpNewRegisterUI {
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.tipDownLabel];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(130);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.267);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.331);
    }];
    
    [self.tipDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-70);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.12);
    }];
    
}

#pragma mark - initializes attributes

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"logo2"];
    }
    return _imageView;
}

- (UILabel *)tipDownLabel {
    if (!_tipDownLabel) {
        _tipDownLabel = [[UILabel alloc] init];
        _tipDownLabel.text = @"服务条款 | 免责声明";
        _tipDownLabel.backgroundColor = UICOLOR_RGB(245, 245, 248, 1);
        _tipDownLabel.textColor = [UIColor lightGrayColor];
        _tipDownLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipDownLabel;
}

@end
