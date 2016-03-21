//
//  KeyList.m
//
//  Created by  周深发 on 16/3/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "KeyList.h"


NSString *const kKeyListLockID = @"LockID";
NSString *const kKeyListLockCode = @"LockCode";
NSString *const kKeyListHCode = @"hCode";
NSString *const kKeyListDkey = @"dkey";
NSString *const kKeyListEnterpriseId = @"EnterpriseId";
NSString *const kKeyListEnterpriseKey = @"EnterpriseKey";
NSString *const kKeyListKeyStatus = @"KeyStatus";
NSString *const kKeyListKeyType = @"KeyType";
NSString *const kKeyListDCode = @"dCode";
NSString *const kKeyListLockName = @"LockName";


@interface KeyList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation KeyList

@synthesize lockID = _lockID;
@synthesize lockCode = _lockCode;
@synthesize hCode = _hCode;
@synthesize dkey = _dkey;
@synthesize enterpriseId = _enterpriseId;
@synthesize enterpriseKey = _enterpriseKey;
@synthesize keyStatus = _keyStatus;
@synthesize keyType = _keyType;
@synthesize dCode = _dCode;
@synthesize lockName = _lockName;


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
            self.lockID = [[self objectOrNilForKey:kKeyListLockID fromDictionary:dict] doubleValue];
            self.lockCode = [[self objectOrNilForKey:kKeyListLockCode fromDictionary:dict] doubleValue];
            self.hCode = [self objectOrNilForKey:kKeyListHCode fromDictionary:dict];
            self.dkey = [self objectOrNilForKey:kKeyListDkey fromDictionary:dict];
            self.enterpriseId = [[self objectOrNilForKey:kKeyListEnterpriseId fromDictionary:dict] doubleValue];
            self.enterpriseKey = [self objectOrNilForKey:kKeyListEnterpriseKey fromDictionary:dict];
            self.keyStatus = [[self objectOrNilForKey:kKeyListKeyStatus fromDictionary:dict] doubleValue];
            self.keyType = [[self objectOrNilForKey:kKeyListKeyType fromDictionary:dict] doubleValue];
            self.dCode = [self objectOrNilForKey:kKeyListDCode fromDictionary:dict];
            self.lockName = [self objectOrNilForKey:kKeyListLockName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lockID] forKey:kKeyListLockID];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lockCode] forKey:kKeyListLockCode];
    [mutableDict setValue:self.hCode forKey:kKeyListHCode];
    [mutableDict setValue:self.dkey forKey:kKeyListDkey];
    [mutableDict setValue:[NSNumber numberWithDouble:self.enterpriseId] forKey:kKeyListEnterpriseId];
    [mutableDict setValue:self.enterpriseKey forKey:kKeyListEnterpriseKey];
    [mutableDict setValue:[NSNumber numberWithDouble:self.keyStatus] forKey:kKeyListKeyStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.keyType] forKey:kKeyListKeyType];
    [mutableDict setValue:self.dCode forKey:kKeyListDCode];
    [mutableDict setValue:self.lockName forKey:kKeyListLockName];

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
