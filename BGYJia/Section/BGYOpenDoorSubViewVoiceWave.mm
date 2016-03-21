//
//  BGYOpenDoorSubViewVoiceWave.m
//  BGYJia
//
//  Created by LvJun on 16/3/9.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//
#import "BGYOpenDoorSubViewVoiceWave.h"
#import "CarduoAudioTool.h"

static NSMutableArray *images ;

@interface BGYOpenDoorSubViewVoiceWave ()<CarduoAudioToolDelegate>

@property (nonatomic ,strong) CarduoAudioTool *carduoAudioTool;
@end

@implementation BGYOpenDoorSubViewVoiceWave


#pragma mark -- life cycle
- (id)init {
    self = [super init];
    if (self)
    {
        [self setup];
        [self layoutUI];
        [self eventBinding];
        [self loadImages];
      
    }
    return self;
}

-(void) setup
{
    [self addSubview:self.cCreateVoiceButton];
    [self addSubview:self.cComment];
    [self addSubview:self.cVoiceProgress];
    self.backgroundColor =[UIColor whiteColor];
}

-(void) layoutUI
{
    [self.cCreateVoiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    [self.cComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.cCreateVoiceButton.mas_bottom).offset(10);
    }];
    
    [self.cVoiceProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.bottom.equalTo(self.cCreateVoiceButton.mas_top).offset(-5);
    }];
}

-(void) loadImages
{
    if (images == nil)
    {
        images = [[NSMutableArray alloc] init];
        for (int i = 1; i < 19; i++) {
            NSString *fileName = [NSString stringWithFormat:@"sb%d.jpg", i];
            UIImage *image = [UIImage imageNamed:fileName];
            [images addObject:image];
        }
    }
    [self.cVoiceProgress setImage:images[0]];
    [self.cVoiceProgress setAnimationImages:images];
    [self.cVoiceProgress setAnimationDuration:0.7f];
     [self.cVoiceProgress setAnimationRepeatCount:2];
     self.cVoiceProgress.userInteractionEnabled = NO;
}

#pragma mark - event binding

-(void) eventBinding
{
//    [self.cCreateVoiceButton addTarget:self action:@selector(OnCreateVoiceButtonHoldDown:) forControlEvents:UIControlEventTouchDown];
    [self.cCreateVoiceButton addTarget:self action:@selector(OnCreateVoiceButtonTap:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - event response
-(void) OnCreateVoiceButtonTap:(id)Sender
{
    if (!self.homeKetEntity)
    {
        return;
    }
    [self.carduoAudioTool stop];
    NSString *dcode = self.homeKetEntity.KeyList.dCode;
    NSString *dkey = self.homeKetEntity.KeyList.dkey;
    // 此key能开
//    [self.carduoAudioTool openTheDoorWithDeviceId:@"1" andContent:@"1d1"];

  [self.carduoAudioTool openTheDoorWithDeviceId:dcode andContent:dkey];
    [self.cVoiceProgress stopAnimating];
    [self.cVoiceProgress startAnimating];
    JCLog(@"OnCreateVoiceButtonTap dcode  %@  dkey %@",dcode,dkey);

}




#pragma mark - event response


//失败回调
-(void)carduoAudioFailed
{
    NSLog(@"carduoAudioFailed failed");
}

//成功回调
-(void)carduoAudioSuccess
{
    NSLog(@"carduoAudioFailed success");
}


#pragma mark -- getter

-(UILabel *) cComment
{
    if (_cComment == nil)
    {
        UILabel  *promotion = [UILabel new];
        promotion.textColor       = [UIColor grayColor];
//        promotion.backgroundColor = [UIColor yellowColor];
        promotion.textAlignment   = NSTextAlignmentRight;
        [promotion sizeToFit];
        [promotion setFont:[UIFont systemFontOfSize:16]];
        promotion.text            = @"按一下轻松开门";
        promotion.layer.cornerRadius = 7;
        _cComment = promotion;
        
    }
    return _cComment;
}
-(UIImageView *) cIcon
{
    if (!_cIcon)
    {
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shark"]];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        _cIcon = icon;
    }
    return  _cIcon;
}


-(UIImageView *) cVoiceProgress
{
    if (!_cVoiceProgress)
    {
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sb1.jpg"]];
        _cVoiceProgress = icon;
    }
    return  _cVoiceProgress;
}


-(UIButton *) cCreateVoiceButton
{
    if (!_cCreateVoiceButton)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"shenyin"] forState:UIControlStateNormal];//给button添加image
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _cCreateVoiceButton = button;
        //        _cPreButton.hidden = YES;
        
    }
    return  _cCreateVoiceButton;
}

-(CarduoAudioTool *) carduoAudioTool
{
    if (!_carduoAudioTool)
    {
        CarduoAudioTool *tool = [[CarduoAudioTool alloc]init];
        tool.delegate = self;
        tool.maxTimes = 6;
        _carduoAudioTool = tool;
        
    }
    return  _carduoAudioTool;
}





@end
