//
//  BGYRegisterForSetPswViewController.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/3.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicViewController.h"



@interface BGYRegisterForSetPswViewController : BGYBasicViewController

@property (nonatomic , assign) REGISTER_TYPE type;

@property (nonatomic , strong) NSString *cellphone;

@property (nonatomic , strong) NSString *idcard;

@property (nonatomic , strong) NSString *realName;

@property (nonatomic , assign) double provinceId;

@property (nonatomic , assign) double villageId;

@property (nonatomic , assign) double buildId;

@property (nonatomic , assign) double unitId;

@property (nonatomic , assign) double buildUnitId;


+(instancetype)newWithType:(REGISTER_TYPE)type;

@end
