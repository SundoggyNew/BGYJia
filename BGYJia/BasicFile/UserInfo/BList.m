//
//  BList.m
//
//  Created by  周深发 on 16/3/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "BList.h"


NSString *const kBListTypeId = @"TypeId";
NSString *const kBListImgUrl = @"imgUrl";
NSString *const kBListDkey = @"dkey";
NSString *const kBListLockID = @"LockID";
NSString *const kBListHouseCode = @"HouseCode";
NSString *const kBListHouseName = @"HouseName";
NSString *const kBListHouseID = @"HouseID";
NSString *const kBListBkey = @"bkey";
NSString *const kBListDCode = @"dCode";
NSString *const kBListLockName = @"LockName";
NSString *const kBListBMac = @"bMac";
NSString *const kBListLockCode = @"LockCode";


@interface BList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BList

@synthesize typeId = _typeId;
@synthesize imgUrl = _imgUrl;
@synthesize dkey = _dkey;
@synthesize lockID = _lockID;
@synthesize houseCode = _houseCode;
@synthesize houseName = _houseName;
@synthesize houseID = _houseID;
@synthesize bkey = _bkey;
@synthesize dCode = _dCode;
@synthesize lockName = _lockName;
@synthesize bMac = _bMac;
@synthesize lockCode = _lockCode;


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
            self.typeId = [[self objectOrNilForKey:kBListTypeId fromDictionary:dict] doubleValue];
            self.imgUrl = [self objectOrNilForKey:kBListImgUrl fromDictionary:dict];
            self.dkey = [self objectOrNilForKey:kBListDkey fromDictionary:dict];
            self.lockID = [[self objectOrNilForKey:kBListLockID fromDictionary:dict] doubleValue];
            self.houseCode = [[self objectOrNilForKey:kBListHouseCode fromDictionary:dict] doubleValue];
            self.houseName = [self objectOrNilForKey:kBListHouseName fromDictionary:dict];
            self.houseID = [[self objectOrNilForKey:kBListHouseID fromDictionary:dict] doubleValue];
            self.bkey = [self objectOrNilForKey:kBListBkey fromDictionary:dict];
            self.dCode = [self objectOrNilForKey:kBListDCode fromDictionary:dict];
            self.lockName = [self objectOrNilForKey:kBListLockName fromDictionary:dict];
            self.bMac = [self objectOrNilForKey:kBListBMac fromDictionary:dict];
            self.lockCode = [[self objectOrNilForKey:kBListLockCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.typeId] forKey:kBListTypeId];
    [mutableDict setValue:self.imgUrl forKey:kBListImgUrl];
    [mutableDict setValue:self.dkey forKey:kBListDkey];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lockID] forKey:kBListLockID];
    [mutableDict setValue:[NSNumber numberWithDouble:self.houseCode] forKey:kBListHouseCode];
    [mutableDict setValue:self.houseName forKey:kBListHouseName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.houseID] forKey:kBListHouseID];
    [mutableDict setValue:self.bkey forKey:kBListBkey];
    [mutableDict setValue:self.dCode forKey:kBListDCode];
    [mutableDict setValue:self.lockName forKey:kBListLockName];
    [mutableDict setValue:self.bMac forKey:kBListBMac];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lockCode] forKey:kBListLockCode];

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
