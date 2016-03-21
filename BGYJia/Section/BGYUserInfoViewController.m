//
//  BGYUserInfoViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/4.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYUserInfoViewController.h"
#import "BGYChangeCellphoneViewController.h"
#import "BGYChangeRealNameViewController.h"
#import "BGYChangeIdCardCodeViewController.h"

#import "BGYSelectedWithRImageView.h"
#import "BGYRegisterSelecedCellView.h"
#import "BGYWithoutRImageView.h"
#import "JCPickerView.h"

@interface BGYUserInfoViewController ()<JCActionViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic , strong) BGYSelectedWithRImageView * headImageView;

@property (nonatomic , strong) BGYRegisterSelecedCellView * cellphoneView;

@property (nonatomic , strong) BGYRegisterSelecedCellView * birthdayView;

@property (nonatomic , strong) UILabel * remindLabel;

@property (nonatomic , strong) BGYRegisterSelecedCellView * nameView;

@property (nonatomic , strong) BGYRegisterSelecedCellView * idCardView;

@end

@implementation BGYUserInfoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadUI];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpUserInfoSystemUI];
    
    [self setUpUserInfoUI];
}

-(void)setUpUserInfoSystemUI
{
    self.titleViewString = @"我的信息";
    
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f8);
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];

}

-(void)setUpUserInfoUI
{
    [self.view addSubview:self.headImageView];
    [self.view addSubview:self.cellphoneView];
    [self.view addSubview:self.birthdayView];
    
    [self.view addSubview:self.remindLabel];
    
    [self.view addSubview:self.nameView];
    [self.view addSubview:self.idCardView];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.top.equalTo(self.view.mas_top).with.offset(80);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.184);
    }];
    
    [self.cellphoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.top.equalTo(self.headImageView.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.118666667);
    }];
    
    [self.birthdayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.top.equalTo(self.cellphoneView.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.118666667);
    }];
    
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.top.equalTo(self.birthdayView.mas_bottom);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.205333333);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.08);
    }];
    
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.top.equalTo(self.remindLabel.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.118666667);
    }];
    
    [self.idCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.top.equalTo(self.nameView.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.118666667);
    }];
}

#pragma mark - private method

-(void)reloadUI
{
    User * user = [User runUser];
    
    self.headImageView.rightImage = user.userImage;
    
    self.cellphoneView.rightTitleString = user.cellphone;
    
    self.birthdayView.rightTitleString = user.birthday;
    
    self.nameView.rightTitleString = user.realName;
    if (user.idcard.length < 18) {
        return;
    }
    NSString * secIdCardCode = [NSString stringWithFormat:@"%@*************%@",[user.idcard substringWithRange:NSMakeRange(0, 3)],[user.idcard substringWithRange:NSMakeRange(16, 2)]];
    
    self.idCardView.rightTitleString = secIdCardCode;
    
}

#pragma mark - jcactionView delegate 

-(void)jcActionView:(JCActionView *)actionView selectedWithTitle:(NSString *)title index:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = YES;
            
            [self presentViewController:picker animated:YES completion:NULL];
        }
            break;
        case 1:
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing = YES;
            
            [self presentViewController:picker animated:YES completion:NULL];

        }
            break;
    }
}

#pragma mark - UIImagePickerController Delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage * theImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    @weakify(self);
    [[JCNetWorking runNetWorking] updateHeadImageWithHeadImage:theImage success:^(NSDictionary *dictionary) {
        @strongify(self);
        
        JCLog(@" change head image : %@ ",dictionary);
        
        [self reloadUI];
        
    } orFailure:^(NSError *error) {
        @strongify(self);
        
        JCLog(@"change head image connection error : %@",error);
        
    }];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - initializes attributes
-(BGYSelectedWithRImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[BGYSelectedWithRImageView alloc] init];
        _headImageView.titleString = @"头像";
        _headImageView.haveLineDown = YES;
        
        @weakify(self);
        [_headImageView didReceiveTapClickBlog:^{
            @strongify(self);
            
            JCActionView * actionView = [[JCActionView alloc] initWithDelegate:self cancelTitle:@"取消" Titles:@"拍照",@"从手机相册选择", nil];
            
            [actionView show];
            
        }];
    }
    return _headImageView;
}
-(BGYRegisterSelecedCellView *)cellphoneView
{
    if (!_cellphoneView) {
        _cellphoneView = [[BGYRegisterSelecedCellView alloc] init];
        _cellphoneView.titleString = @"手机号";
        User *user = [User runUser];
        _cellphoneView.rightTitleString = user.cellphone;
        _cellphoneView.haveLineDown = YES;
        
        @weakify(self);
        [_cellphoneView didReceiveTapClickBlog:^{
            @strongify(self);
            
            [self.navigationController pushViewController:[BGYChangeCellphoneViewController new] animated:YES];
            
        }];
    }
    return _cellphoneView;
}
-(BGYRegisterSelecedCellView *)birthdayView
{
    if (!_birthdayView) {
        _birthdayView = [[BGYRegisterSelecedCellView alloc] init];
        _birthdayView.titleString = @"出生日期";
        _birthdayView.rightTitleString = @"1993.08.11";
        _birthdayView.haveLineDown = YES;
        
        @weakify(self);
        [_birthdayView didReceiveTapClickBlog:^{
            @strongify(self);
            
            JCPickerView * datePicker = [[JCPickerView alloc] init];
            
            @weakify(self);
            [datePicker showWithFinish:^(NSString *message) {
                @strongify(self);
                
                JCLog(@"message:%@", message);
                
                [[JCNetWorking runNetWorking] changeUserInfoWithKey:@"birthday" value:message success:^(NSDictionary *dictionary) {
                    
                    [self reloadUI];
                    
                } orFailure:^(NSError *error) {
                    
                    JCLog(@" change birthday error");
                    
                }];
                
            } orCancel:^{
                @strongify(self);
                
                JCLog(@" cancel date picker");
                
            }];
            
        }];
    }
    return _birthdayView;
}
-(UILabel *)remindLabel
{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] init];
        _remindLabel.adjustsFontSizeToFitWidth = YES;
        _remindLabel.textAlignment = NSTextAlignmentRight;
        _remindLabel.text = @"身份信息";
        _remindLabel.textColor = UIColorFromRGB(0x989898);
        _remindLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _remindLabel;
}
-(BGYRegisterSelecedCellView *)nameView
{
    if (!_nameView) {
        _nameView = [[BGYRegisterSelecedCellView alloc] init];
        _nameView.haveLineDown = YES;
        _nameView.titleString = @"真实姓名";
        _nameView.rightTitleString = @"齐天大圣郭德华";
        
        @weakify(self);
        [_nameView didReceiveTapClickBlog:^{
            @strongify(self);
            
            [self.navigationController pushViewController:[BGYChangeRealNameViewController new] animated:YES];
            
        }];
    }
    return _nameView;
}
-(BGYRegisterSelecedCellView *)idCardView
{
    if (!_idCardView) {
        _idCardView = [[BGYRegisterSelecedCellView alloc] init];
        _idCardView.haveLineDown = YES;
        _idCardView.titleString = @"证件号码";
        _idCardView.rightTitleString = @"441*************73";
        
        @weakify(self);
        [_idCardView didReceiveTapClickBlog:^{
            @strongify(self);
            
            [self.navigationController pushViewController:[BGYChangeIdCardCodeViewController new] animated:YES];
            
        }];
    }
    return _idCardView;
}

@end
