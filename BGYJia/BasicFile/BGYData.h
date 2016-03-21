//
//  BGYData.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/16.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicModel.h"

@interface BGYData : BGYBasicModel

@property (nonatomic, assign) double dataIdentifier;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSArray *villageList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
