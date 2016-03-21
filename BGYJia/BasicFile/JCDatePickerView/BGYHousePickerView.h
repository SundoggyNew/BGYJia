//
//  BGYHousePickerView.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/16.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicView.h"

@interface BGYHousePickerView : BGYBasicView

@property (nonatomic , strong) NSArray * dataArray;

-(void)showWithFinish:(VIBlock)finish orCancel:(VVBlock)cancel;

@end
