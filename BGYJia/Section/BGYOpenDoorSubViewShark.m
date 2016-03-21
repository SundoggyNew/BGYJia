//
//  BGYOpenDoorSubViewShark.m
//  BGYJia
//
//  Created by LvJun on 16/3/9.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYOpenDoorSubViewShark.h"
#import "CarduoBluetooth.h"
#import "UIView+Shake.h"
#import "BGYBlueKeyEntity.h"
@interface BGYOpenDoorSubViewShark ()<CarduoBluetoothToolDelegate>

@property (nonatomic ,strong) CarduoBluetooth *tool;
@property (nonatomic, strong) NSMutableArray  * dataArr;

@end

@implementation BGYOpenDoorSubViewShark

#pragma mark -- life cycle
- (id)init {
    self = [super init];
    if (self)
    {
        [self setup];
        [self layoutUI];
    }
    return self;
}

-(void) setup
{
    [self addSubview:self.cIcon];
    [self addSubview:self.cComment];
    self.backgroundColor =[UIColor whiteColor];
    self.tool = [[CarduoBluetooth alloc]init];
    self.tool.delegate = self;

}

-(void) layoutUI
{
    [self.cIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    
    [self.cComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.cIcon.mas_bottom).offset(10);
    }];
}


//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self open];
//}

#pragma mark -- CarduoBluetoothToolDelegate
-(void)openBlueShake
{
    
    if ([self.dataArr count] <= 0) {
        return;
    }
    
    [self.cIcon shake:30    // 10 times
            withDelta:10     // 5 points wide
                speed:0.1    // 30ms per shake
       shakeDirection:ShakeDirectionHorizontal
     ];

   NSMutableArray *bluetoothKeys = [[NSMutableArray alloc] init];
    for (BGYBlueKeyEntity *entity in self.dataArr)
    {
          BluetoothKey *model =   [[BluetoothKey alloc] initWithVillageID:entity.bList.dCode macAddress:entity.bList.bMac bluetoothPWD:entity.bList.bkey userCardPWD:[NSString stringWithFormat:@"%d",(int)entity.enterpriseId]];
         [bluetoothKeys addObject:model];
    }

    [self.tool openTheDoorWithKeys:bluetoothKeys];
    
    
  
}
-(void)carduoBluetoothToolDidFailedWithError:(NSString *)error
{
    NSLog(@"error %@",error);
}
-(void)carduoBluetoothToolDidSuccessfullyOpen
{
    NSLog(@"success");
}



-(void) loadData
{
    /**
     *   蓝牙开锁参数
         villageId 填的内容是dCode对应的消息
         bluetoothPWD 对应的是bkey
         userCardPWD 对应值查找方法(首先找到当前houseid和dcode，然后去houselist的keylist里找houseid和dcode对应的Enterpriseid,这个Enterpriseid就是userCardPWD)
     *
     **/
 
    
    
    NSArray *data =   [User runUser].accessData.value.userKey.bList;
    
    for (BList *bluekeyinfo in data)
    {
        double houseId = bluekeyinfo.houseID;
        NSString *dcode = bluekeyinfo.dCode;
        NSArray *data =   [User runUser].accessData.value.userKey.homeList;
        
        for (HomeList *homeList in data)
        {
            if (homeList.houseID != houseId) {
                continue;
            }
            NSArray *keyArr = homeList.keyList;
            for ( KeyList *keyData  in keyArr ) {
                NSString *_dcode = keyData.dCode;
                if (_dcode != nil && [_dcode isEqualToString:dcode ]) {
                    BGYBlueKeyEntity *entity = [BGYBlueKeyEntity new];
                    entity.bList = bluekeyinfo;
                    entity.enterpriseId = keyData.enterpriseId;
                    [self.dataArr addObject:entity];
                }
            }
        }
    }
}

#pragma mark -- getter
-(UILabel *) cComment
{
    if (_cComment == nil)
    {
        UILabel  *promotion = [UILabel new];
        promotion.textColor       = [UIColor grayColor];
        promotion.textAlignment   = NSTextAlignmentRight;
        [promotion sizeToFit];
        [promotion setFont:[UIFont systemFontOfSize:16]];
        promotion.text            = @"摇一摇开门";
        promotion.layer.cornerRadius = 7;
        _cComment = promotion;
        
    }
    return _cComment;
}

-(UIImageView *) cIcon
{
    if (!_cIcon)
    {
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yao_yao"]];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        _cIcon = icon;
    }
    return  _cIcon;
}
-(NSMutableArray  *) dataArr
{
    if (!_dataArr)
    {
        _dataArr = [NSMutableArray new];
        
    }
    return  _dataArr;
}

@end
