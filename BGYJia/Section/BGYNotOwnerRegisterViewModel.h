//
//  BGYNotOwnerRegisterViewModel.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/16.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicViewModel.h"
#import "BGYBuildListModel.h"

@interface BGYNotOwnerRegisterViewModel : BGYBasicViewModel

@property (nonatomic , assign) double provinceId;

@property (nonatomic , assign) double villageId;

@property (nonatomic , assign) double buildId;

@property (nonatomic , assign) double unitId;

@property (nonatomic , assign) double buildUnitId;


-(void)reloadData;

@end
