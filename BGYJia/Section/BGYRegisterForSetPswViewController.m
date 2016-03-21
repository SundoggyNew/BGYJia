//
//  BGYRegisterForSetPswViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/3.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYRegisterForSetPswViewController.h"
#import "BGYHouseListViewController.h"
#import "BGYRegisterNotOwnerFinishViewController.h"

#import "BGYRegisterForInputView.h"

#import "BGYChoseModel.h"

@interface BGYRegisterForSetPswViewController ()

@property (nonatomic , strong) TPKeyboardAvoidingScrollView * backgroundView;

@property (nonatomic , strong) UIView * houseListView;

@property (nonatomic , strong) UILabel * remindLabel;

@property (nonatomic , strong) UILabel * houseListLabel;

@property (nonatomic , strong) UIButton * moreButton;

@property (nonatomic , strong) BGYRegisterForInputView * setPasswordInputView;

@property (nonatomic , strong) UIButton * finishButton;

@property (nonatomic , strong) NSArray *housesArray;

@end

@implementation BGYRegisterForSetPswViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    @weakify(self);
    [self getMoreDataWithCellphone:self.cellphone idcard:self.idcard CompletionHandle:^(NSError *error) {
        @strongify(self);
        
        if (self.housesArray.count > 2) {
            BGYChoseModel *house1 = self.housesArray[0];
            BGYChoseModel *house2 = self.housesArray[1];
            self.houseListLabel.text = [NSString stringWithFormat:@"%@\n%@", house1.name, house2.name];
        } else if (self.housesArray.count == 2) {
            
            BGYChoseModel *house1 = self.housesArray[0];
            BGYChoseModel *house2 = self.housesArray[1];
            self.houseListLabel.text = [NSString stringWithFormat:@"%@\n%@", house1.name, house2.name];
            self.moreButton.hidden = YES;
            
        } else if (self.housesArray.count == 1) {
            
            BGYChoseModel *house1 = self.housesArray[0];
            self.houseListLabel.text = [NSString stringWithFormat:@"%@", house1.name];
            self.moreButton.hidden = YES;
            
        } else if (self.housesArray.count == 0) {
            self.houseListLabel.text = @"您的名下无碧桂园的房产";
            self.moreButton.hidden = YES;
        }
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpRegisterForSetPswSystemUI];
    
    [self setUpRegisterForSetPswUI];
}

-(void)setUpRegisterForSetPswSystemUI
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

-(void)setUpRegisterForSetPswUI
{
    [self.view addSubview:self.backgroundView];
    
    
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    if (self.type == REGISTER_TYPE_OWNER) {
        
        [self.backgroundView addSubview:self.houseListView];
        [self.houseListView addSubview:self.remindLabel];
        [self.houseListView addSubview:self.houseListLabel];
        [self.houseListView addSubview:self.moreButton];
        
        [self.backgroundView addSubview:self.setPasswordInputView];
        [self.backgroundView addSubview:self.finishButton];
        
        [self.houseListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.backgroundView);
            make.top.equalTo(self.backgroundView).with.offset(0);
            make.width.equalTo(self.backgroundView.mas_width);
            make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.244);
        }];
        
        [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.houseListView);
            make.top.equalTo(self.houseListView.mas_top).with.offset(SELF_VIEW_HEIGHT*0.005);
            make.leading.equalTo(self.houseListView.mas_leading).with.offset(SELF_VIEW_WIDTH*0.034666667);
            make.height.equalTo(self.houseListView.mas_height).multipliedBy(0.327868852);
        }];
        
        [self.houseListLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.remindLabel.mas_bottom);
            make.leading.equalTo(self.houseListView.mas_leading).with.offset(SELF_VIEW_WIDTH*0.034666667);
            make.bottom.equalTo(self.houseListView.mas_bottom);
            make.width.equalTo(self.houseListView.mas_width).multipliedBy(0.75);
        }];
        
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.houseListLabel.mas_trailing);
            make.top.equalTo(self.remindLabel.mas_bottom).with.offset(SELF_VIEW_HEIGHT*0.005);
            make.bottom.equalTo(self.houseListView.mas_bottom);
            make.trailing.equalTo(self.houseListView.mas_trailing);
        }];
        
        [self.setPasswordInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.backgroundView);
            make.top.equalTo(self.houseListView.mas_bottom).with.offset(SELF_VIEW_HEIGHT*0.019490255);
            make.width.equalTo(self.backgroundView);
            make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
        }];
        
    }else{
        
        [self.backgroundView addSubview:self.setPasswordInputView];
        [self.backgroundView addSubview:self.finishButton];
        
        [self.setPasswordInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.backgroundView);
            make.top.equalTo(self.backgroundView.mas_top).with.offset(26);
            make.width.equalTo(self.backgroundView);
            make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
        }];
            
    }
    
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading).with.offset(12.5);
        make.top.equalTo(self.setPasswordInputView.mas_bottom).with.offset(30.5);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.122666667);
        make.width.equalTo(self.backgroundView.mas_width).multipliedBy(0.933333333);
    }];
    
}

#pragma mark - private methods

-(void)loginAfterRegisterSuccess:(VVBlock)successBlock andFailure:(VEBlock)failureBlock;
{
    [[JCNetWorking runNetWorking] loginWithAccount:self.cellphone passWord:[self.setPasswordInputView getTheInputFieldText] loginMethod:0 success:^(NSDictionary *dictionary) {
        
        if (successBlock) {
            successBlock();
        }
        
        JCLog(@"  -- %@",dictionary);
        
        if ([[dictionary objectForKey:@"errorcode"] integerValue] == 0) {
            
            User * user = [User runUser];
            
            [user setUpWithDictionary:dictionary];
            user.password = [self.setPasswordInputView getTheInputFieldText];
            [user saveToDB];
            
            JCRemindView * remindView = [JCRemindView remindWithMessage:@"登录成功" hideForTime:1 andHideBlock:^{
                
                BGYTabBarController * tabbar = [BGYTabBarController runTabBar];
                
                UIWindow *window                  = [[UIApplication sharedApplication].windows objectAtIndex:0];
                
                window.rootViewController         = tabbar;
                
            }];
            
            [remindView show];
            
        }else{
            
            JCRemindView * remindView = [JCRemindView remindWithMessage:@"登录信息发生错误，请重试" hideForTime:3 andHideBlock:nil];
            
            [remindView show];
        }
        
    } orFailure:^(NSError *error) {
        
        if (failureBlock) {
            failureBlock(error);
        }
        
        JCRemindView * remindView = [JCRemindView remindWithMessage:@"登录信息错误，请重试" hideForTime:3 andHideBlock:nil];
        
        [remindView show];
        
    }];
}

- (void)getMoreDataWithCellphone:(NSString *)cellphone
                          idcard:(NSString *)idcard
                CompletionHandle:(VEBlock)completionHandle {
    @weakify(self);
    [[JCNetWorking runNetWorking] getPersonalHouseInfoWithCellphone:cellphone idcard:idcard success:^(NSDictionary *dictionary) {
        @strongify(self);
        
        NSArray *dataArray = [dictionary objectForKey:@"data"];
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (NSDictionary *dic in dataArray) {
            
            BGYChoseModel *houseModel = [BGYChoseModel new];
            
            houseModel.name = [dic objectForKey:@"houseName"];
            
            [mutableArray addObject:houseModel];
            
        }
        
        self.housesArray = [mutableArray copy];
        
        if (completionHandle) {
            completionHandle(nil);
        }
        
    } orFailure:^(NSError *error) {
        if (completionHandle) {
            completionHandle(error);
        }
    }];
}

#pragma mark - public method

+(instancetype)newWithType:(REGISTER_TYPE)type
{
    BGYRegisterForSetPswViewController * registerForSetPswVC = [BGYRegisterForSetPswViewController new];
    
    registerForSetPswVC.type = type;
    
    return registerForSetPswVC;
}


#pragma mark - initializes attributes

-(TPKeyboardAvoidingScrollView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[TPKeyboardAvoidingScrollView alloc] init];
    }
    return _backgroundView;
}

-(UIView *)houseListView
{
    if (!_houseListView) {
        _houseListView = [[UIView alloc] init];
        _houseListView.backgroundColor = [UIColor whiteColor];
    }
    return _houseListView;
}
-(UILabel *)remindLabel
{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] init];
        _remindLabel.text = @"你的房产：";
        _remindLabel.textColor = UIColorFromRGB(0x6d6d6d);
    }
    return _remindLabel;
}
-(UILabel *)houseListLabel
{
    if (!_houseListLabel) {
        _houseListLabel = [[UILabel alloc] init];
        _houseListLabel.text = nil;
        _houseListLabel.numberOfLines = 2;
        _houseListLabel.textColor = UIColorFromRGB(0xc9c9cc);
    }
    return _houseListLabel;
}

-(UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton setTitle:@"更多 >" forState:UIControlStateNormal];
        [_moreButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        
        @weakify(self);
        [[_moreButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
           
            [self.setPasswordInputView outOfFirstResponder];
            
            BGYHouseListViewController *vc = [BGYHouseListViewController new];
            vc.dataArr = self.housesArray;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
    }
    return _moreButton;
}
-(BGYRegisterForInputView *)setPasswordInputView
{
    if (!_setPasswordInputView) {
        _setPasswordInputView = [[BGYRegisterForInputView alloc] init];
        _setPasswordInputView.mainPlaceholder = @"请设置6 ~ 16位字符的登录密码";
        _setPasswordInputView.haveRightButton = YES;
        _setPasswordInputView.haveLineDown = YES;
        _setPasswordInputView.lineColor = UIColorFromRGB(0xe0e0e1);
        _setPasswordInputView.secureTextEntry = YES;
        
        [_setPasswordInputView.rightButton setImage:[UIImage imageNamed:@"eye_1"] forState:UIControlStateNormal];
        [_setPasswordInputView.rightButton setImage:[UIImage imageNamed:@"eye_2"] forState:UIControlStateSelected];
        [_setPasswordInputView.rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -40)];
        
        @weakify(self);
        [[_setPasswordInputView.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            self.setPasswordInputView.rightButton.selected = !self.setPasswordInputView.rightButton.selected;
            
            self.setPasswordInputView.secureTextEntry = !self.setPasswordInputView.rightButton.selected;
            
        }];
    }
    return _setPasswordInputView;
}

-(UIButton *)finishButton
{
    if (!_finishButton) {
        _finishButton = [[UIButton alloc] init];
        [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
        [_finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishButton.backgroundColor = MAIN_COLOR;
        _finishButton.layer.masksToBounds = YES;
        _finishButton.layer.cornerRadius = 8.0f;
        
        @weakify(self);
        [[_finishButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.setPasswordInputView outOfFirstResponder];
            
            NSLog(@"cellphone:%@ type:%ld password:%@", self.cellphone, (long)self.type, [self.setPasswordInputView getTheInputFieldText]);
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            hud.labelText = @"正在努力注册...";
            
            NSString *password = [self.setPasswordInputView getTheInputFieldText];
            
            if (password.length == 0) {
                
                [hud hide:YES];
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请设置密码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
                
            }
            
            BOOL haveRightPassWord = [RegularTools validatePassword:[self.setPasswordInputView getTheInputFieldText]];
            
            if (!haveRightPassWord) {
                
                [hud hide:YES];
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"请设置6-16位字符的密码" hideForTime:3 andHideBlock:nil];
                
                [remindView show];
                
                return;
            }
            
            switch (self.type) {
                case REGISTER_TYPE_OWNER:
                {
                    
                    @weakify(self);
                    [[JCNetWorking runNetWorking] registerWithCellphone:self.cellphone passWord:[self.setPasswordInputView getTheInputFieldText] role:REGISTER_TYPE_OWNER idcard:nil realName:nil provinceId:nil villageId:nil buildId:nil buildUnitId:nil success:^(NSDictionary *dictionary) {
                        @strongify(self);
                        
                        JCLog(@" -- %@ ",dictionary);
                        
                        if ([[dictionary objectForKey:@"errorcode"] integerValue] == 0) {
                            
                            hud.labelText = @"注册成功,正在努力登录...";
                            
                            [self loginAfterRegisterSuccess:^{
                                
                                [hud hide:YES];
                                
                            } andFailure:^(NSError *error) {
                                
                                [hud hide:YES];
                                
                                JCLog(@"%@",error);
                                
                            }];
                            
                        }else if([[dictionary objectForKey:@"errorcode"] integerValue] == -1) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"注册失败" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if([[dictionary objectForKey:@"errorcode"] integerValue] == 5) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"该账号已存在，请直接登录" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if([[dictionary objectForKey:@"errorcode"] integerValue] == 6) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"该业主身份证信息未登记，请先到物业管理处进行登记" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if([[dictionary objectForKey:@"errorcode"] integerValue] == 7) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"该业主身份证信息已注册" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if([[dictionary objectForKey:@"errorcode"] integerValue] == 11) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"该身份证信息已存在" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if([[dictionary objectForKey:@"errorcode"] integerValue] == 12) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"没有传人任何房屋参数" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if([[dictionary objectForKey:@"errorcode"] integerValue] == 13) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"房屋所属省份ID不能为空" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if([[dictionary objectForKey:@"errorcode"] integerValue] == 14) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"房屋所属小区ID不能为空" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if([[dictionary objectForKey:@"errorcode"] integerValue] == 15) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"房屋所属楼栋单元ID不能为空" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if([[dictionary objectForKey:@"errorcode"] integerValue] == 16) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"房屋所属房间号ID不能为空" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"网络连接错误，请重试" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                        }
                        
                    } orFailure:^(NSError *error) {
                        
                        [hud hide:YES];
                        
                        JCRemindView * remindView = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:3 andHideBlock:nil];
                        
                        [remindView show];
                        
                    }];
                    
                }
                    break;
                case REGISTER_TYPE_NOTOWNER:
                {
                    
                    @weakify(self);
                    [[JCNetWorking runNetWorking] registerWithCellphone:self.cellphone
                                                               passWord:[self.setPasswordInputView getTheInputFieldText]
                                                                   role:REGISTER_TYPE_NOTOWNER
                                                                 idcard:self.idcard
                                                               realName:self.realName
                                                             provinceId:[NSString stringWithFormat:@"%.f",self.provinceId]
                                                              villageId:[NSString stringWithFormat:@"%.f",self.villageId]
                                                                buildId:[NSString stringWithFormat:@"%.f",self.buildId]
                                                            buildUnitId:[NSString stringWithFormat:@"%.f",self.buildUnitId]
                                                                success:^(NSDictionary *dictionary) {
                        @strongify(self);
                                                                    
                                                                    JCLog(@"%@",dictionary);
                        
                        if ([[dictionary objectForKey:@"errorcode"] integerValue] == 0) {
                            
                            [hud hide:YES];
                            
                            [self.navigationController pushViewController:[BGYRegisterNotOwnerFinishViewController new] animated:YES];
                            
                        } else if ([[dictionary objectForKey:@"errorcode"] integerValue] == -1) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"注册失败" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if ([[dictionary objectForKey:@"errorcode"] integerValue] == 5) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"该账号已存在，请直接登录" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if ([[dictionary objectForKey:@"errorcode"] integerValue] == 6) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"该业主身份证信息未登记，请先到物业管理处进行登记" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if ([[dictionary objectForKey:@"errorcode"] integerValue] == 7) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"该业主身份证信息已注册" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if([[dictionary objectForKey:@"errorcode"] integerValue] == 11) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"该身份证信息已存在" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if([[dictionary objectForKey:@"errorcode"] integerValue] == 12) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"没有传人任何房屋参数" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if([[dictionary objectForKey:@"errorcode"] integerValue] == 13) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"房屋所属省份ID不能为空" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if([[dictionary objectForKey:@"errorcode"] integerValue] == 14) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"房屋所属小区ID不能为空" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if([[dictionary objectForKey:@"errorcode"] integerValue] == 15) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"房屋所属楼栋单元ID不能为空" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else if([[dictionary objectForKey:@"errorcode"] integerValue] == 16) {
                            
                            [hud hide:YES];
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"房屋所属房间号ID不能为空" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                            
                            
                        } else {
                            
                            [hud hide:YES];
                            
                            JCLog(@" %ld ",[[dictionary objectForKey:@"errorcode"] integerValue]);
                            
                            JCRemindView * remindView = [JCRemindView remindWithMessage:@"网络连接错误，请重试" hideForTime:3 andHideBlock:nil];
                            
                            [remindView show];
                        }
                        
                    } orFailure:^(NSError *error) {
                        
                        [hud hide:YES];
                        
                        JCRemindView * remindView = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:3 andHideBlock:nil];
                        
                        [remindView show];
                        
                    }];
                    
                }
                    break;
            }
            
        }];
    }
    return _finishButton;
}

@end
