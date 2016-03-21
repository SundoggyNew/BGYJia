//
//  Value.m
//
//  Created by  周深发 on 16/3/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Value.h"

NSString *const kValueID = @"ID";
NSString *const kValueMobile = @"Mobile";
NSString *const kValueAppUserKeyTempTim = @"AppUserKeyTempTim";
NSString *const kValueUserKey = @"userKey";
NSString *const kValueToken = @"token";
NSString *const kValueState = @"State";


@interface Value ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Value

@synthesize iDProperty = _iDProperty;
@synthesize mobile = _mobile;
@synthesize appUserKeyTempTim = _appUserKeyTempTim;
@synthesize userKey = _userKey;
@synthesize token = _token;
@synthesize state = _state;


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
            self.iDProperty = [[self objectOrNilForKey:kValueID fromDictionary:dict] doubleValue];
            self.mobile = [self objectOrNilForKey:kValueMobile fromDictionary:dict];
            self.appUserKeyTempTim = [self objectOrNilForKey:kValueAppUserKeyTempTim fromDictionary:dict];
            self.userKey = [UserKey modelObjectWithDictionary:[dict objectForKey:kValueUserKey]];
            self.token = [self objectOrNilForKey:kValueToken fromDictionary:dict];
            self.state = [[self objectOrNilForKey:kValueState fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kValueID];
    [mutableDict setValue:self.mobile forKey:kValueMobile];
    [mutableDict setValue:self.appUserKeyTempTim forKey:kValueAppUserKeyTempTim];
    [mutableDict setValue:[self.userKey dictionaryRepresentation] forKey:kValueUserKey];
    [mutableDict setValue:self.token forKey:kValueToken];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kValueState];

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
