//
//  UserKey.h
//
//  Created by  周深发 on 16/3/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BList.h"
#import "HomeList.h"

@interface UserKey : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *bList;
@property (nonatomic, strong) NSArray *homeList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
