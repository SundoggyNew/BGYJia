//
//  BGYChangeRealNameViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/12.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYChangeRealNameViewController.h"
#import "BGYRegisterForInputView.h"

@interface BGYChangeRealNameViewController ()

/** 承载键盘遮挡背景 View */
@property (nonatomic , strong) TPKeyboardAvoidingScrollView * backScrollView;

@property (nonatomic , strong) BGYRegisterForInputView * inputView;


@end

@implementation BGYChangeRealNameViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.inputView.text = [User runUser].realName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNameChangeSystemUI];
    
    [self setUpNameChangeUI];
    
}
-(void)setUpNameChangeSystemUI
{
    self.titleViewString = @"真实姓名";
    
    self.view.backgroundColor = UICOLOR_RGB(223, 227, 223, 1);
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
    [self.navgationRightButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.navgationRightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navgationRightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -50);
    [[self.navgationRightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.inputView outOfFirstResponder];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.labelText = @"正在更新用户名...";
        
        if ([self.inputView getTheInputFieldText].length < 1) {
            
            DQAlertView * alert = [[DQAlertView alloc] initWithTitle:@"用户名不能为空！" message:nil cancelButtonTitle:@"确定" otherButtonTitle:nil];
            
            [hud hide:YES];
            
            [alert show];
            
            return;
        }
        
        @weakify(self);
        [[JCNetWorking runNetWorking] changeUserInfoWithKey:@"realName" value:[self.inputView getTheInputFieldText] success:^(NSDictionary *dictionary) {
            @strongify(self);
            
            [hud hide:YES];
            
            JCLog(@"%@",dictionary);
            
            if ([[dictionary objectForKey:@"errorcode"] integerValue] == 0) {
                
                @weakify(self);
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"更改成功" hideForTime:1 andHideBlock:^{
                    @strongify(self);
                
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }];
                                
                [remindView show];
            }else{
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"修改失败，请重试" hideForTime:2 andHideBlock:nil];
                
                [remindView show];
                
            }

            
            
        } orFailure:^(NSError *error) {
            @strongify(self);
            
            JCRemindView * remindView = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:2 andHideBlock:nil];
            
            [remindView show];
            
        }];
    }];
}

-(void)setUpNameChangeUI
{
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.inputView];
    
    [self.backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(70);
        make.height.equalTo(self.inputView.mas_width).multipliedBy(0.2);
    }];
}










#pragma mark - initializes attributes
-(TPKeyboardAvoidingScrollView *)backScrollView
{
    if (!_backScrollView) {
        _backScrollView = [[TPKeyboardAvoidingScrollView alloc] init];
    }
    return _backScrollView;
}
-(BGYRegisterForInputView *)inputView
{
    if (!_inputView) {
        _inputView = [[BGYRegisterForInputView alloc] init];
        _inputView.haveRightButton = NO;
    }
    return _inputView;
}

@end
