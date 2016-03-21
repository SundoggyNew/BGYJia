//
//  BGYBuildUnitList.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/16.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicModel.h"

@interface BGYBuildUnitList : BGYBasicModel

@property (nonatomic, assign) double buildUnitListIdentifier;
@property (nonatomic, strong) NSString *roomNumber;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;


@end
