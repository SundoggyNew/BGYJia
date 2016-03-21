//
//  BGYFindPwdResetViewController.h
//  BGYJia
//
//  Created by 全民尚网 on 16/3/3.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicViewController.h"

@interface BGYFindPwdResetViewController : BGYBasicViewController

@property (nonatomic , strong) NSString *cellphone;

+ (instancetype)newWithMessage:(VVBlock)eventBlock;

@end
