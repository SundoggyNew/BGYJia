//
//  BGYVillageList.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/16.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYVillageList.h"

NSString *const kVillageListVillageName = @"villageName";
NSString *const kVillageListId          = @"id";
NSString *const kVillageListTelephone   = @"telephone";
NSString *const kVillageListBuildList   = @"buildList";
NSString *const kVillageListPrincipal   = @"principal";
NSString *const kVillageListLocation    = @"location";


@interface BGYVillageList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BGYVillageList

@synthesize villageName = _villageName;
@synthesize villageListIdentifier = _villageListIdentifier;
@synthesize telephone = _telephone;
@synthesize buildList = _buildList;
@synthesize principal = _principal;
@synthesize location = _location;


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
        self.villageName = [self objectOrNilForKey:kVillageListVillageName fromDictionary:dict];
        self.villageListIdentifier = [[self objectOrNilForKey:kVillageListId fromDictionary:dict] doubleValue];
        self.telephone = [self objectOrNilForKey:kVillageListTelephone fromDictionary:dict];
        self.buildList = [self objectOrNilForKey:kVillageListBuildList fromDictionary:dict];
        self.principal = [self objectOrNilForKey:kVillageListPrincipal fromDictionary:dict];
        self.location = [self objectOrNilForKey:kVillageListLocation fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.villageName forKey:kVillageListVillageName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.villageListIdentifier] forKey:kVillageListId];
    [mutableDict setValue:self.telephone forKey:kVillageListTelephone];
    NSMutableArray *tempArrayForBuildList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.buildList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBuildList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBuildList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBuildList] forKey:kVillageListBuildList];
    [mutableDict setValue:self.principal forKey:kVillageListPrincipal];
    [mutableDict setValue:self.location forKey:kVillageListLocation];
    
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
