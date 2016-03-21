//
//  JCPickerView.m
//  JCActionView
//
//  Created by JohnsonChou on 16/3/6.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//
#import "JCPickerView.h"

@interface JCPickerView ()

@property (nonatomic , strong) UIView                 * backgroundView;

@property (nonatomic , strong) UIView                 * headView;

@property (nonatomic , strong) UILabel                * dateLabel;

@property (nonatomic , strong) UIButton               * sureButton;

@property (nonatomic , strong) UIDatePicker           * pickerView;

@property (nonatomic , strong) UITapGestureRecognizer * tap;

@property (nonatomic , copy  ) VSBlock                finishBlock;

@property (nonatomic , copy  ) VVBlock                cancelBlock;

@end

@implementation JCPickerView

-(void)dealloc
{
    self.finishBlock = nil;
    self.cancelBlock = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundView.layer.masksToBounds = YES;
        self.backgroundView.layer.cornerRadius = 8.0f;
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        [self addSubview:self.backgroundView];
        
        [self.backgroundView addSubview:self.pickerView];
        
        [self.backgroundView addSubview:self.headView];
        [self.headView addSubview:self.dateLabel];
        [self.headView addSubview:self.sureButton];
        
        [self addGestureRecognizer:self.tap];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    self.backgroundView.bounds = CGRectMake(0, 0, width*0.8, height*0.25);
    self.backgroundView.center = self.center;
    
    CGFloat bgWidth = self.backgroundView.bounds.size.width;
    CGFloat bgHeight = self.backgroundView.bounds.size.height;
    
    self.headView.frame = CGRectMake(0, 0, bgWidth, bgHeight*0.25);
    
    self.pickerView.frame = CGRectMake(0, bgHeight*0.25, bgWidth, bgHeight*0.75);
    
    self.dateLabel.frame = CGRectMake(0, 0, bgWidth*0.8, bgHeight*0.25);
    
    self.sureButton.frame = CGRectMake(bgWidth*0.8, 0, bgWidth*0.2, bgHeight*0.25);
}


#pragma mark - public method

-(void)showWithFinish:(void (^)(NSString *))finish orCancel:(void (^)(void))cancel
{
    self.frame = [[UIScreen mainScreen] bounds];
    
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    
    [window addSubview:self];
    
    self.finishBlock = finish;
    self.cancelBlock = cancel;
    
}

-(void)hide
{
    [self removeFromSuperview];
}

#pragma mark - private method

-(void)didReceiveTapClick:(UITapGestureRecognizer *)tap
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
    [self hide];
    
}

-(void)didReceiveFinishButtonClick:(UIButton *)button
{
    NSDate * date = self.pickerView.date;

    NSString * dateString = [[[NSString stringWithFormat:@"%@",date] componentsSeparatedByString:@" "] objectAtIndex:0];
    
    dateString = [[dateString componentsSeparatedByString:@"-"] componentsJoinedByString:@"."];
    
    if (self.finishBlock) {
        self.finishBlock(dateString);
    }
    
    [self hide];
}



#pragma mark - initializes attributes

-(UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backgroundView;
}
-(UIDatePicker *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIDatePicker alloc] init];
        _pickerView.datePickerMode = UIDatePickerModeDate;
    }
    return _pickerView;
}

-(UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = [UIColor colorWithRed:219/255.0 green:222/255.0 blue:224/255.0 alpha:1];
    }
    return _headView;
}

-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.text = @"           年          月            日";
    }
    return _dateLabel;
}

-(UIButton *)sureButton
{
    if (!_sureButton) {
        _sureButton = [[UIButton alloc] init];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_sureButton setTitle:@"完成" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor colorWithRed:251/255.0 green:60/255.0 blue:95/255.0 alpha:1] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(didReceiveFinishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

-(UITapGestureRecognizer *)tap
{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didReceiveTapClick:)];
    }
    return _tap;
}


@end
