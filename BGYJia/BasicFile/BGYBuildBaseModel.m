//
//  BGYBuildBaseModel.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/16.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBuildBaseModel.h"


NSString *const kBaseClassErrormsg = @"errormsg";
NSString *const kBaseClassData = @"data";
NSString *const kBaseClassErrorcode = @"errorcode";

@interface BGYBuildBaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BGYBuildBaseModel

@synthesize errormsg = _errormsg;
@synthesize data = _data;
@synthesize errorcode = _errorcode;


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
        self.errormsg = [self objectOrNilForKey:kBaseClassErrormsg fromDictionary:dict];
        NSObject *receivedData = [dict objectForKey:kBaseClassData];
        NSMutableArray *parsedData = [NSMutableArray array];
        if ([receivedData isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedData) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedData addObject:[BGYData modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedData isKindOfClass:[NSDictionary class]]) {
            [parsedData addObject:[BGYData modelObjectWithDictionary:(NSDictionary *)receivedData]];
        }
        
        self.data = [NSArray arrayWithArray:parsedData];
        self.errorcode = [[self objectOrNilForKey:kBaseClassErrorcode fromDictionary:dict] doubleValue];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.errormsg forKey:kBaseClassErrormsg];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kBaseClassData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.errorcode] forKey:kBaseClassErrorcode];
    
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
