//
//  BGYVillageList.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/16.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicModel.h"

@interface BGYVillageList : BGYBasicModel

@property (nonatomic, strong) NSString *villageName;
@property (nonatomic, assign) double villageListIdentifier;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSArray *buildList;
@property (nonatomic, strong) NSString *principal;
@property (nonatomic, strong) NSString *location;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;


@end
