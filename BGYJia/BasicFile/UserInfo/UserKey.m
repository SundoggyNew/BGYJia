//
//  UserKey.m
//
//  Created by  周深发 on 16/3/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "UserKey.h"


NSString *const kUserKeyBList = @"bList";
NSString *const kUserKeyHomeList = @"homeList";


@interface UserKey ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserKey

@synthesize bList = _bList;
@synthesize homeList = _homeList;


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
    NSObject *receivedBList = [dict objectForKey:kUserKeyBList];
    NSMutableArray *parsedBList = [NSMutableArray array];
    if ([receivedBList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBList addObject:[BList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBList isKindOfClass:[NSDictionary class]]) {
       [parsedBList addObject:[BList modelObjectWithDictionary:(NSDictionary *)receivedBList]];
    }

    self.bList = [NSArray arrayWithArray:parsedBList];
    NSObject *receivedHomeList = [dict objectForKey:kUserKeyHomeList];
    NSMutableArray *parsedHomeList = [NSMutableArray array];
    if ([receivedHomeList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHomeList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHomeList addObject:[HomeList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHomeList isKindOfClass:[NSDictionary class]]) {
       [parsedHomeList addObject:[HomeList modelObjectWithDictionary:(NSDictionary *)receivedHomeList]];
    }

    self.homeList = [NSArray arrayWithArray:parsedHomeList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForBList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.bList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBList] forKey:kUserKeyBList];
    NSMutableArray *tempArrayForHomeList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.homeList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHomeList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHomeList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHomeList] forKey:kUserKeyHomeList];

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
