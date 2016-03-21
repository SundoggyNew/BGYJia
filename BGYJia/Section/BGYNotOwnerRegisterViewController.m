//
//  BGYNotOwnerRegisterViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/4.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYNotOwnerRegisterViewController.h"
#import "BGYRegisterForSetPswViewController.h"

#import "BGYRegisterSelecedCellView.h"
#import "BGYRegisterForInputView.h"
#import "BGYHousePickerView.h"
#import "BGYBuildListModel.h"
#import "BGYNotOwnerRegisterViewModel.h"
#import "BGYChoseModel.h"

@interface BGYNotOwnerRegisterViewController ()

@property (nonatomic , strong) TPKeyboardAvoidingScrollView * backgroundView;

@property (nonatomic , strong) BGYRegisterSelecedCellView * provincesChoseCell;

@property (nonatomic , strong) BGYRegisterSelecedCellView * communityChoseCell;

@property (nonatomic , strong) BGYRegisterSelecedCellView * storiedBuildingChoseCell;

@property (nonatomic , strong) BGYRegisterSelecedCellView * unitChoseCell;

@property (nonatomic , strong) BGYRegisterSelecedCellView * roomNumberChoseCell;

@property (nonatomic , strong) BGYRegisterForInputView * nameInputCell;

@property (nonatomic , strong) BGYRegisterForInputView * idCardNumberInputCell;

@property (nonatomic , strong) BGYRegisterForInputView * phoneNumberInputCell;

@property (nonatomic , strong) UIButton * nextButton;

@property (nonatomic , strong) BGYNotOwnerRegisterViewModel * mainViewModel;

@property (nonatomic , strong) BGYBuildBaseModel * model;

@end

@implementation BGYNotOwnerRegisterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    @weakify(self);
//    [[JCNetWorking runNetWorking] getAllHouseInfoWithsuccess:^(NSDictionary *dictionary) {
//        @strongify(self);
//        
//        JCLog(@" %@ ",dictionary);
//        
//        self.model = [[BGYBuildBaseModel alloc] initWithDictionary:dictionary];
//        
//    } orFailure:^(NSError *error) {
//        
//        JCLog(@" %@ ",error);
//        
//    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainViewModel = [BGYNotOwnerRegisterViewModel new];
    
    [self setUpNotOwnerRegisterSystemUI];
    
    [self setUpNotOwnerRegisterUI];
    
    
    
}
-(void)setUpNotOwnerRegisterSystemUI
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

-(void)setUpNotOwnerRegisterUI
{
    [self.view addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.provincesChoseCell];
    [self.backgroundView addSubview:self.communityChoseCell];
    [self.backgroundView addSubview:self.storiedBuildingChoseCell];
    [self.backgroundView addSubview:self.unitChoseCell];
    [self.backgroundView addSubview:self.roomNumberChoseCell];
    
    [self.backgroundView addSubview:self.nameInputCell];
    [self.backgroundView addSubview:self.idCardNumberInputCell];
    [self.backgroundView addSubview:self.phoneNumberInputCell];
    
    [self.backgroundView addSubview:self.nextButton];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.provincesChoseCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.backgroundView.mas_top).with.offset(26);
        make.width.equalTo(self.backgroundView.mas_width);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.communityChoseCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.provincesChoseCell.mas_bottom);
        make.width.equalTo(self.backgroundView.mas_width);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.storiedBuildingChoseCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.communityChoseCell.mas_bottom);
        make.width.equalTo(self.backgroundView.mas_width);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.unitChoseCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.storiedBuildingChoseCell.mas_bottom);
        make.width.equalTo(self.backgroundView.mas_width);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.roomNumberChoseCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.unitChoseCell.mas_bottom);
        make.width.equalTo(self.backgroundView.mas_width);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.nameInputCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.roomNumberChoseCell.mas_bottom).with.offset(26);
        make.width.equalTo(self.backgroundView);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.idCardNumberInputCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.nameInputCell.mas_bottom);
        make.width.equalTo(self.backgroundView);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.phoneNumberInputCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading);
        make.top.equalTo(self.idCardNumberInputCell.mas_bottom);
        make.width.equalTo(self.backgroundView);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.117333333);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backgroundView.mas_leading).with.offset(12.5);
        make.top.equalTo(self.phoneNumberInputCell.mas_bottom).with.offset(30.5);
        make.height.equalTo(self.backgroundView.mas_width).multipliedBy(0.122666667);
        make.width.equalTo(self.backgroundView.mas_width).multipliedBy(0.933333333);
    }];
}

#pragma mark - initializes attributes

-(TPKeyboardAvoidingScrollView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[TPKeyboardAvoidingScrollView alloc] init];
    }
    return _backgroundView;
}
-(BGYRegisterSelecedCellView *)provincesChoseCell
{
    if (!_provincesChoseCell) {
        _provincesChoseCell = [[BGYRegisterSelecedCellView alloc] init];
        _provincesChoseCell.titleString = @"省份";
        _provincesChoseCell.rightTitleString = @"请选择";
        _provincesChoseCell.haveRightImage = YES;
        _provincesChoseCell.haveLineDown = YES;
        
        @weakify(self);
        [_provincesChoseCell didReceiveTapClickBlog:^{
            @strongify(self);
            
            @weakify(self);
            [[JCNetWorking runNetWorking] getAllHouseInfoWithAreaType:@"1" parentId:0 success:^(NSArray *array) {
                @strongify(self);
                
                BGYHousePickerView * pickerView = [BGYHousePickerView new];
                
                pickerView.dataArray = [NSArray arrayWithArray:array];
                
                @weakify(self);
                [pickerView showWithFinish:^(BGYChoseModel * model) {
                    @strongify(self);
                    
                    self.provincesChoseCell.rightTitleString = model.name;
                    
                    self.mainViewModel.provinceId = model.theId;
                    
                } orCancel:^{
                    
                }];
                
            } orFailure:^(NSError *error) {
                
                JCRemindView * remind = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:2 andHideBlock:nil];
                
                [remind show];
                
            }];
            
        }];
    }
    return _provincesChoseCell;
}
-(BGYRegisterSelecedCellView *)communityChoseCell
{
    if (!_communityChoseCell) {
        _communityChoseCell = [[BGYRegisterSelecedCellView alloc] init];
        _communityChoseCell.titleString = @"小区";
        _communityChoseCell.rightTitleString = @"请选择";
        _communityChoseCell.haveRightImage = YES;
        _communityChoseCell.haveLineDown = YES;
        
        @weakify(self);
        [_communityChoseCell didReceiveTapClickBlog:^{
            @strongify(self);
            
            @weakify(self);
            [[JCNetWorking runNetWorking] getAllHouseInfoWithAreaType:@"2" parentId:self.mainViewModel.provinceId success:^(NSArray *array) {
                @strongify(self);
                
                BGYHousePickerView * pickerView = [BGYHousePickerView new];
                
                pickerView.dataArray = [NSArray arrayWithArray:array];
                
                @weakify(self);
                [pickerView showWithFinish:^(BGYChoseModel * model) {
                    @strongify(self);
                    
                    self.communityChoseCell.rightTitleString = model.name;
                    
                    self.mainViewModel.villageId = model.theId;
                    
                } orCancel:^{
                    
                }];
                
            } orFailure:^(NSError *error) {
                
                JCRemindView * remind = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:2 andHideBlock:nil];
                
                [remind show];
                
            }];
            
        }];

    }
    return _communityChoseCell;
}
-(BGYRegisterSelecedCellView *)storiedBuildingChoseCell
{
    if (!_storiedBuildingChoseCell) {
        _storiedBuildingChoseCell = [[BGYRegisterSelecedCellView alloc] init];
        _storiedBuildingChoseCell.titleString = @"楼栋";
        _storiedBuildingChoseCell.rightTitleString = @"请选择";
        _storiedBuildingChoseCell.haveRightImage = YES;
        _storiedBuildingChoseCell.haveLineDown = YES;
        
        @weakify(self);
        [_storiedBuildingChoseCell didReceiveTapClickBlog:^{
            @strongify(self);
            
            @weakify(self);
            [[JCNetWorking runNetWorking] getAllHouseInfoWithAreaType:@"3" parentId:self.mainViewModel.villageId success:^(NSArray *array) {
                @strongify(self);
                
                BGYHousePickerView * pickerView = [BGYHousePickerView new];
                
                pickerView.dataArray = [NSArray arrayWithArray:array];
                
                @weakify(self);
                [pickerView showWithFinish:^(BGYChoseModel * model) {
                    @strongify(self);
                    
                    self.storiedBuildingChoseCell.rightTitleString = model.name;
                    
                    self.mainViewModel.buildId = model.theId;
                    
                } orCancel:^{
                    
                }];
                
            } orFailure:^(NSError *error) {
                
                JCRemindView * remind = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:2 andHideBlock:nil];
                
                [remind show];
                
            }];
            
        }];
    }
    return _storiedBuildingChoseCell;
}
-(BGYRegisterSelecedCellView *)unitChoseCell
{
    if (!_unitChoseCell) {
        _unitChoseCell = [[BGYRegisterSelecedCellView alloc] init];
        _unitChoseCell.titleString = @"单元";
        _unitChoseCell.rightTitleString = @"请选择";
        _unitChoseCell.haveRightImage = YES;
        _unitChoseCell.haveLineDown = YES;
        
        @weakify(self);
        [_unitChoseCell didReceiveTapClickBlog:^{
            @strongify(self);
            
            @weakify(self);
            [[JCNetWorking runNetWorking] getAllHouseInfoWithAreaType:@"4" parentId:self.mainViewModel.buildId success:^(NSArray *array) {
                @strongify(self);
                
                BGYHousePickerView * pickerView = [BGYHousePickerView new];
                
                pickerView.dataArray = [NSArray arrayWithArray:array];
                
                @weakify(self);
                [pickerView showWithFinish:^(BGYChoseModel * model) {
                    @strongify(self);
                    
                    self.unitChoseCell.rightTitleString = model.name;
                    
                    self.mainViewModel.unitId = model.theId;
                    
                } orCancel:^{
                    
                }];
                
            } orFailure:^(NSError *error) {
                
                JCRemindView * remind = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:2 andHideBlock:nil];
                
                [remind show];
                
            }];
            
        }];
    }
    return _unitChoseCell;
}
-(BGYRegisterSelecedCellView *)roomNumberChoseCell
{
    if (!_roomNumberChoseCell) {
        _roomNumberChoseCell = [[BGYRegisterSelecedCellView alloc] init];
        _roomNumberChoseCell.titleString = @"房号";
        _roomNumberChoseCell.rightTitleString = @"请选择";
        _roomNumberChoseCell.haveRightImage = YES;
        _roomNumberChoseCell.haveLineDown = YES;
        
        @weakify(self);
        [_roomNumberChoseCell didReceiveTapClickBlog:^{
            @strongify(self);
            
            @weakify(self);
            [[JCNetWorking runNetWorking] getAllHouseInfoWithAreaType:@"5" parentId:self.mainViewModel.unitId success:^(NSArray *array) {
                @strongify(self);
                
                BGYHousePickerView * pickerView = [BGYHousePickerView new];
                
                pickerView.dataArray = [NSArray arrayWithArray:array];
                
                @weakify(self);
                [pickerView showWithFinish:^(BGYChoseModel * model) {
                    @strongify(self);
                    
                    self.roomNumberChoseCell.rightTitleString = model.name;
                    
                    self.mainViewModel.buildUnitId = model.theId;
                    
                } orCancel:^{
                    
                }];
                
            } orFailure:^(NSError *error) {
                
                JCRemindView * remind = [JCRemindView remindWithMessage:@"连接错误，请重试" hideForTime:2 andHideBlock:nil];
                
                [remind show];
                
            }];
            
        }];
    }
    return _roomNumberChoseCell;
}
-(BGYRegisterForInputView *)nameInputCell
{
    if (!_nameInputCell) {
        _nameInputCell = [[BGYRegisterForInputView alloc] init];
        _nameInputCell.mainPlaceholder = @"请输入姓名";
    }
    return _nameInputCell;
}
-(BGYRegisterForInputView *)idCardNumberInputCell
{
    if (!_idCardNumberInputCell) {
        _idCardNumberInputCell = [[BGYRegisterForInputView alloc] init];
        _idCardNumberInputCell.mainPlaceholder = @"请输入身份证号码";
    }
    return _idCardNumberInputCell;
}
-(BGYRegisterForInputView *)phoneNumberInputCell
{
    if (!_phoneNumberInputCell) {
        _phoneNumberInputCell = [[BGYRegisterForInputView alloc] init];
        _phoneNumberInputCell.mainPlaceholder = @"请输入业主手机号码";
    }
    return _phoneNumberInputCell;
}

-(UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] init];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextButton.backgroundColor = MAIN_COLOR;
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.cornerRadius = 8.0f;
        
        @weakify(self);
        [[_nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.nameInputCell outOfFirstResponder];
            [self.idCardNumberInputCell outOfFirstResponder];
            [self.phoneNumberInputCell outOfFirstResponder];
            
            if (![self.nameInputCell getTheInputFieldText].length) {
                
                JCRemindView * remind = [JCRemindView remindWithMessage:@"请输入姓名" hideForTime:2 andHideBlock:nil];
                
                [remind show];
                
                return ;
            }
            
            if (![self.idCardNumberInputCell getTheInputFieldText].length) {
                
                JCRemindView * remind = [JCRemindView remindWithMessage:@"请输入身份证号码" hideForTime:2 andHideBlock:nil];
                
                [remind show];
                
                return ;
            }
            
            if (![self.phoneNumberInputCell getTheInputFieldText].length) {
                
                JCRemindView * remind = [JCRemindView remindWithMessage:@"请输入业主手机号码" hideForTime:2 andHideBlock:nil];
                
                [remind show];
                
                return ;
            }
            
            BOOL haveRightIdCard = [RegularTools validateIdentityCard:[self.idCardNumberInputCell getTheInputFieldText]];
            BOOL haveRightCellphone = [RegularTools validateMobile:[self.phoneNumberInputCell getTheInputFieldText]];
            
            if (!haveRightIdCard) {
                
                JCRemindView * remind = [JCRemindView remindWithMessage:@"请输入正确的身份证号码" hideForTime:2 andHideBlock:nil];
                
                [remind show];
                
                return ;
            }
            
            if (!haveRightCellphone) {
                
                JCRemindView * remind = [JCRemindView remindWithMessage:@"请输入正确的手机号码" hideForTime:2 andHideBlock:nil];
                
                [remind show];
                
                return ;
            }
            
            BGYRegisterForSetPswViewController *vc = [BGYRegisterForSetPswViewController newWithType:REGISTER_TYPE_NOTOWNER];
            vc.cellphone                           = self.cellphone;
            vc.idcard                              = [self.idCardNumberInputCell getTheInputFieldText];
            vc.realName                            = [self.nameInputCell getTheInputFieldText];
            vc.provinceId                          = self.mainViewModel.provinceId;
            vc.villageId                           = self.mainViewModel.villageId;
            vc.buildId                             = self.mainViewModel.buildId;
            vc.unitId                              = self.mainViewModel.unitId;
            vc.buildUnitId                         = self.mainViewModel.buildUnitId;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
    }
    return _nextButton;
}


@end
