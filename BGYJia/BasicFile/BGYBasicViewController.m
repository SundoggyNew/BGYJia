//
//  BGYBasicViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicViewController.h"

@interface BGYBasicViewController ()

//UIViewController 标题
@property (nonatomic,strong) UILabel * titleViewLabel;

@end

@implementation BGYBasicViewController


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //提示进入 ViewController 类，供调试
    JCLog(@"Into the %@",NSStringFromClass([self class]));
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self setUpSystemUI];
}
/**
 *  设置系统控件UI
 */
-(void)setUpSystemUI
{
    self.navigationItem.titleView = self.titleViewLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navgationLeftButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navgationRightButton];
}
/**
 *  截取父类设置标题方法
 *
 *  @param title 标题字符串
 */
-(void)setTitleViewString:(NSString *)titleViewString
{
    _titleViewString = titleViewString;
    
    self.titleViewLabel.text = titleViewString;
}

#pragma mark - Initializes attributes
-(UILabel *)titleViewLabel
{
    if (!_titleViewLabel) {
        _titleViewLabel = [[UILabel alloc] init];
        _titleViewLabel.bounds = CGRectMake(0, 0, 60, 40);
        _titleViewLabel.center = self.navigationItem.titleView.center;
        _titleViewLabel.textColor = [UIColor blackColor];
        _titleViewLabel.font = [UIFont systemFontOfSize:19.f];
        _titleViewLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleViewLabel;
}
-(UIButton *)navgationLeftButton
{
    if (!_navgationLeftButton) {
        _navgationLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        _navgationLeftButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        _navgationLeftButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
        [_navgationLeftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _navgationLeftButton;
}
-(UIButton *)navgationRightButton
{
    if (!_navgationRightButton) {
        _navgationRightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        _navgationRightButton.titleLabel.textAlignment = NSTextAlignmentRight;
        _navgationRightButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
        [_navgationRightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _navgationRightButton;
}

@end
