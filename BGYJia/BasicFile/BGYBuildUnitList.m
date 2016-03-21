//
//  BGYBuildUnitList.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/16.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBuildUnitList.h"


NSString *const kBuildUnitListId = @"id";
NSString *const kBuildUnitListRoomNumber = @"roomNumber";


@interface BGYBuildUnitList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BGYBuildUnitList

@synthesize buildUnitListIdentifier = _buildUnitListIdentifier;
@synthesize roomNumber = _roomNumber;


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
        self.buildUnitListIdentifier = [[self objectOrNilForKey:kBuildUnitListId fromDictionary:dict] doubleValue];
        self.roomNumber = [self objectOrNilForKey:kBuildUnitListRoomNumber fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.buildUnitListIdentifier] forKey:kBuildUnitListId];
    [mutableDict setValue:self.roomNumber forKey:kBuildUnitListRoomNumber];
    
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
