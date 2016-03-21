//
//  BGYOpenDoorViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYOpenDoorViewController.h"
#import "BGYOpenDoorSubViewShark.h"
#import "BGYOpenDoorSubViewVoiceWave.h"
#import "BGYOpenDoorSubViewAddressListView.h"


@interface BGYOpenDoorViewController ()<BGYOpenDoorSubViewSharkDelegate,BGYOpenDoorSubViewVoiceWaveDelegate,BGYOpenDoorSubViewAddressListViewDelegate>

@property (nonatomic, strong) BGYOpenDoorSubViewShark           *cBGYOpenDoorSubViewShark;
@property (nonatomic, strong) BGYOpenDoorSubViewVoiceWave       *cBGYOpenDoorSubViewVoiceWave;
@property (nonatomic, strong) BGYOpenDoorSubViewAddressListView *cAddressListView;

@end

@implementation BGYOpenDoorViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    [self layoutUI];
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    [self becomeFirstResponder];
    
    [self.cAddressListView loadData];
    [self.cBGYOpenDoorSubViewShark loadData];
}

-(void)setup
{
    self.titleViewString = @"开门";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.cBGYOpenDoorSubViewShark];
    [self.view addSubview:self.cBGYOpenDoorSubViewVoiceWave];
    [self.view addSubview:self.cAddressListView];
}


-(void) layoutUI
{
    float BOX_HEIGHT = (SCREEN_HEIGHT -  self.navigationController.navigationBar.frame.size.height - 49 - 5 -OPENDOOR_HEIGHT-5 ) *.5;
    
    [self.cBGYOpenDoorSubViewShark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(self.navigationController.navigationBar.frame.size.height);
            make.height.mas_equalTo(BOX_HEIGHT);
            make.centerX.equalTo(self.view.mas_centerX).offset(0);
            make.width.equalTo(self.view);
    }];
    
    [self.cBGYOpenDoorSubViewVoiceWave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cBGYOpenDoorSubViewShark.mas_bottom).offset(5);
        make.height.mas_equalTo(BOX_HEIGHT);;
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.equalTo(self.view);
    }];
    
    [self.cAddressListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cBGYOpenDoorSubViewVoiceWave.mas_bottom).offset(5);
        make.height.mas_equalTo(OPENDOOR_HEIGHT);;
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.equalTo(self.view.mas_width).offset(0);
    }];
}


#pragma mark - MotionShake
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    JCLog(@"motionBegan");
    self.cBGYOpenDoorSubViewVoiceWave.userInteractionEnabled = NO;
    return;
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    JCLog(@"motionCancelled");
    self.cBGYOpenDoorSubViewVoiceWave.userInteractionEnabled = YES;
    return;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake)
    {
        JCLog(@"motionEnded");
        self.cBGYOpenDoorSubViewVoiceWave.userInteractionEnabled = YES;
        [self.cBGYOpenDoorSubViewShark openBlueShake];

    }
    return;
}



#pragma mark -- BGYOpenDoorSubViewAddressListViewDelegate
-(void) keyListDidScrollTo:(int) index
{
    self.cBGYOpenDoorSubViewVoiceWave.homeKetEntity = [self.cAddressListView.dataArr objectAtIndex:index];
}

#pragma mark -- BGYOpenDoorSubViewVoiceWaveDelegate
-(void) VoiceWaveButtonHolding
{
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = NO;
}
-(void) VoiceWaveButtonRelease
{
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;

}



#pragma mark -- getter

-(BGYOpenDoorSubViewShark *) cBGYOpenDoorSubViewShark
{
    if (!_cBGYOpenDoorSubViewShark)
    {
        _cBGYOpenDoorSubViewShark =   [[BGYOpenDoorSubViewShark alloc] init];
        _cBGYOpenDoorSubViewShark.delegate = self;
    }
    return  _cBGYOpenDoorSubViewShark;
}

-(BGYOpenDoorSubViewVoiceWave *) cBGYOpenDoorSubViewVoiceWave
{
    if (!_cBGYOpenDoorSubViewVoiceWave)
    {
        _cBGYOpenDoorSubViewVoiceWave =   [[BGYOpenDoorSubViewVoiceWave alloc] init];
        _cBGYOpenDoorSubViewVoiceWave.delegate = self;
    }
    return  _cBGYOpenDoorSubViewVoiceWave;
}

-(BGYOpenDoorSubViewAddressListView *) cAddressListView
{
    if (!_cAddressListView)
    {
        _cAddressListView =   [[BGYOpenDoorSubViewAddressListView alloc] init];
        _cAddressListView.delegate = self;
    }
    return  _cAddressListView;
}


@end
