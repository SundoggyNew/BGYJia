//
//  BGYBuildBaseModel.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/16.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicModel.h"
#import "BGYData.h"

@interface BGYBuildBaseModel : BGYBasicModel

@property (nonatomic, strong) NSString *errormsg;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) double errorcode;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;


@end
