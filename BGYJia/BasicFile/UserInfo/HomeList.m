//
//  HomeList.m
//
//  Created by  周深发 on 16/3/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HomeList.h"


NSString *const kHomeListKeyList = @"keyList";
NSString *const kHomeListImgUrl = @"imgUrl";
NSString *const kHomeListHouseID = @"HouseID";
NSString *const kHomeListHouseName = @"HouseName";
NSString *const kHomeListHouseCode = @"HouseCode";
NSString *const kHomeListKeyCount = @"KeyCount";


@interface HomeList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HomeList

@synthesize keyList = _keyList;
@synthesize imgUrl = _imgUrl;
@synthesize houseID = _houseID;
@synthesize houseName = _houseName;
@synthesize houseCode = _houseCode;
@synthesize keyCount = _keyCount;


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
    NSObject *receivedKeyList = [dict objectForKey:kHomeListKeyList];
    NSMutableArray *parsedKeyList = [NSMutableArray array];
    if ([receivedKeyList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedKeyList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedKeyList addObject:[KeyList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedKeyList isKindOfClass:[NSDictionary class]]) {
       [parsedKeyList addObject:[KeyList modelObjectWithDictionary:(NSDictionary *)receivedKeyList]];
    }

    self.keyList = [NSArray arrayWithArray:parsedKeyList];
            self.imgUrl = [self objectOrNilForKey:kHomeListImgUrl fromDictionary:dict];
            self.houseID = [[self objectOrNilForKey:kHomeListHouseID fromDictionary:dict] doubleValue];
            self.houseName = [self objectOrNilForKey:kHomeListHouseName fromDictionary:dict];
            self.houseCode = [self objectOrNilForKey:kHomeListHouseCode fromDictionary:dict];
            self.keyCount = [[self objectOrNilForKey:kHomeListKeyCount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForKeyList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.keyList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForKeyList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForKeyList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForKeyList] forKey:kHomeListKeyList];
    [mutableDict setValue:self.imgUrl forKey:kHomeListImgUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.houseID] forKey:kHomeListHouseID];
    [mutableDict setValue:self.houseName forKey:kHomeListHouseName];
    [mutableDict setValue:self.houseCode forKey:kHomeListHouseCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.keyCount] forKey:kHomeListKeyCount];

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
