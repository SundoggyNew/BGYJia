//
//  Value.h
//
//  Created by  周深发 on 16/3/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserKey.h"


@interface Value : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *appUserKeyTempTim;
@property (nonatomic, strong) UserKey *userKey;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, assign) double state;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
