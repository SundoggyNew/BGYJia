//
//  BGYData.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/16.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYData.h"
#import "BGYVillageList.h"


NSString *const kDataBuildId = @"id";
NSString *const kDataProvinceName = @"provinceName";
NSString *const kDataVillageList = @"villageList";


@interface BGYData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BGYData

@synthesize dataIdentifier = _dataIdentifier;
@synthesize provinceName = _provinceName;
@synthesize villageList = _villageList;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.dataIdentifier = [[self objectOrNilForKey:kDataBuildId fromDictionary:dict] doubleValue];
        self.provinceName = [self objectOrNilForKey:kDataProvinceName fromDictionary:dict];
        NSObject *receivedVillageList = [dict objectForKey:kDataVillageList];
        NSMutableArray *parsedVillageList = [NSMutableArray array];
        if ([receivedVillageList isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedVillageList) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedVillageList addObject:[BGYVillageList modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedVillageList isKindOfClass:[NSDictionary class]]) {
            [parsedVillageList addObject:[BGYVillageList modelObjectWithDictionary:(NSDictionary *)receivedVillageList]];
        }
        
        self.villageList = [NSArray arrayWithArray:parsedVillageList];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataIdentifier] forKey:kDataBuildId];
    [mutableDict setValue:self.provinceName forKey:kDataProvinceName];
    NSMutableArray *tempArrayForVillageList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.villageList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForVillageList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForVillageList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForVillageList] forKey:kDataVillageList];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}
@end
