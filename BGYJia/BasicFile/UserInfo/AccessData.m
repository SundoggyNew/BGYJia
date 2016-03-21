//
//  AccessData.m
//
//  Created by  周深发 on 16/3/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "AccessData.h"


NSString *const kAccessDataMessage = @"Message";
NSString *const kAccessDataState = @"State";
NSString *const kAccessDataValue = @"Value";


@interface AccessData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AccessData

@synthesize message = _message;
@synthesize state = _state;
@synthesize value = _value;


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
            self.message = [self objectOrNilForKey:kAccessDataMessage fromDictionary:dict];
            self.state = [[self objectOrNilForKey:kAccessDataState fromDictionary:dict] doubleValue];
            self.value = [Value modelObjectWithDictionary:[dict objectForKey:kAccessDataValue]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kAccessDataMessage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kAccessDataState];
    [mutableDict setValue:[self.value dictionaryRepresentation] forKey:kAccessDataValue];

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
