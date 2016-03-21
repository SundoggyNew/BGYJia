//
//  BGYBuildList.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/16.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBuildList.h"
#import "BGYBuildUnitList.h"


NSString *const kBuildListId = @"id";
NSString *const kBuildListBuildUnitList = @"buildUnitList";
NSString *const kBuildListBuildName = @"buildName";


@interface BGYBuildList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BGYBuildList

@synthesize buildListIdentifier = _buildListIdentifier;
@synthesize buildUnitList = _buildUnitList;
@synthesize buildName = _buildName;


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
        self.buildListIdentifier = [[self objectOrNilForKey:kBuildListId fromDictionary:dict] doubleValue];
        NSObject *receivedBuildUnitList = [dict objectForKey:kBuildListBuildUnitList];
        NSMutableArray *parsedBuildUnitList = [NSMutableArray array];
        if ([receivedBuildUnitList isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedBuildUnitList) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedBuildUnitList addObject:[BGYBuildUnitList modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedBuildUnitList isKindOfClass:[NSDictionary class]]) {
            [parsedBuildUnitList addObject:[BGYBuildUnitList modelObjectWithDictionary:(NSDictionary *)receivedBuildUnitList]];
        }
        
        self.buildUnitList = [NSArray arrayWithArray:parsedBuildUnitList];
        self.buildName = [self objectOrNilForKey:kBuildListBuildName fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.buildListIdentifier] forKey:kBuildListId];
    NSMutableArray *tempArrayForBuildUnitList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.buildUnitList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBuildUnitList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBuildUnitList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBuildUnitList] forKey:kBuildListBuildUnitList];
    [mutableDict setValue:self.buildName forKey:kBuildListBuildName];
    
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
