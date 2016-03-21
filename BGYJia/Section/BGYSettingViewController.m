//
//  BGYSettingViewController.m
//  BGYJia
//
//  Created by 全民尚网 on 16/3/4.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYSettingViewController.h"
#import "BGYSettingTableViewCell.h"
#import "BGYResetPwdVerifyViewController.h"
#import "BGYRapidLossAccountViewController.h"
#import "BGYAboutUsViewController.h"
#import "BGYLoginViewController.h"

@interface BGYSettingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BGYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleViewString = @"系统设置";
    
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f8);
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf5f5f8);
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1 || section == 4 || section == 5) {
        return 1;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BGYSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BGYSettingTableViewCell reuseIdentifier]];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"重置登录密码";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"快速挂失";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"图片设置(2G/3G/4G网络下显示图片)";
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            UISwitch *indicatorSwitch = [[UISwitch alloc] init];
            indicatorSwitch.onTintColor = [UIColor redColor];
            cell.accessoryView = indicatorSwitch;
        } else {
            cell.textLabel.text = @"消息提醒设置(用户消息、活动推送等)";
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            UISwitch *indicatorSwitch = [[UISwitch alloc] init];
            indicatorSwitch.onTintColor = [UIColor redColor];
            cell.accessoryView = indicatorSwitch;
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"清除缓存";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.textLabel.text = @"系统更新";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    } else if (indexPath.section == 4) {
        cell.textLabel.text = @"关于我们";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
        UIView* content = castView.contentView;
        UIColor* color = UIColorFromRGB(0xf5f5f8);
        content.backgroundColor = color;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
        UIView* content = castView.contentView;
        UIColor* color = UIColorFromRGB(0xf5f5f8);
        content.backgroundColor = color;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self.navigationController pushViewController:[BGYResetPwdVerifyViewController new] animated:YES];
    } else if (indexPath.section == 1) {
        [self.navigationController pushViewController:[BGYRapidLossAccountViewController new] animated:YES];
    } else if (indexPath.section == 4) {
        [self.navigationController pushViewController:[BGYAboutUsViewController new] animated:YES];
    } else if (indexPath.section == 5) {
        
        DQAlertView * alert = [[DQAlertView alloc] initWithTitle:@"提示" message:@"注销登录" cancelButtonTitle:@"确定" otherButtonTitle:@"取消"];
        
        @weakify(self);
        alert.cancelButtonAction = ^{
            @strongify(self);
         
            User * user = [User runUser];
            
//            [user clean];
            [user deleteToDB];
            
            [[JCNetWorking runNetWorking] logoutWithsuccess:^(NSDictionary *dictionary) {
                
                if ([[dictionary objectForKey:@"errorcode"] integerValue] == 0) {
                    
                    JCLog(@"success");
                    
                } else {
                    
                    JCLog(@"注销失败");
                    
                }
                
            } orFailure:^(NSError *error) {
                
            }];
            
            [self.navigationController popToRootViewControllerAnimated:NO];
            
            [[BGYTabBarController runTabBar] selectedIndex:0];
            
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[BGYLoginViewController new]];
            
            UIWindow *window                  = [[UIApplication sharedApplication].windows objectAtIndex:0];
            
            window.rootViewController         = nav;
            
        };
        
        [alert show];
        
    }
    
    if (indexPath.section == 3 && indexPath.row == 0) {
        
        NSString * msg = [NSString stringWithFormat:@"共有 %.2f M 的图片缓存",[[SDImageCache sharedImageCache] getSize]/1024.00/1024.00];
        
        DQAlertView * alert = [[DQAlertView alloc] initWithTitle:@"清除缓存" message:msg cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
        
        alert.otherButtonAction = ^(){
            
            [[SDImageCache sharedImageCache] clearDisk];
            
            DQAlertView * alertTwo = [[DQAlertView alloc] initWithTitle:@"清除缓存" message:@"清除完成" cancelButtonTitle:@"确定" otherButtonTitle:nil];
            
            [alertTwo show];
        };
        
        [alert show];
        
    }
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - initializes attributes

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[BGYSettingTableViewCell class] forCellReuseIdentifier:[BGYSettingTableViewCell reuseIdentifier]];
    }
    return _tableView;
}

@end
