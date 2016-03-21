//
//  BGYBuildList.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/16.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicModel.h"

@interface BGYBuildList : BGYBasicModel

@property (nonatomic, assign) double buildListIdentifier;
@property (nonatomic, strong) NSArray *buildUnitList;
@property (nonatomic, strong) NSString *buildName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;


@end
