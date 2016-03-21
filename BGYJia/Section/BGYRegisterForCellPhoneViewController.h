//
//  BGYRegisterForCellPhoneViewController.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//
#import "BGYBasicViewController.h"

@interface BGYRegisterForCellPhoneViewController : BGYBasicViewController

@property (nonatomic , assign) REGISTER_TYPE type;

+(instancetype)newWithType:(REGISTER_TYPE)type;

@end
