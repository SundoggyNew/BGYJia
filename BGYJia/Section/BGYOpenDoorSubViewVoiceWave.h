//
//  BGYOpenDoorSubViewVoiceWave.h
//  BGYJia
//
//  Created by LvJun on 16/3/9.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGYHomeKeyEntity.h"
@protocol  BGYOpenDoorSubViewVoiceWaveDelegate <NSObject>

-(void) VoiceWaveButtonHolding;
-(void) VoiceWaveButtonRelease;

@optional


@end

@interface BGYOpenDoorSubViewVoiceWave : UIView

@property(nonatomic,strong)   UIButton  * cCreateVoiceButton;
@property (nonatomic, strong) UIImageView *cIcon;
@property (nonatomic, strong) UIImageView *cVoiceProgress;
@property (nonatomic, strong) UILabel     *cComment;
@property (nonatomic, weak)   BGYHomeKeyEntity     *homeKetEntity;
@property (nonatomic,strong) id<BGYOpenDoorSubViewVoiceWaveDelegate> delegate;


@end
