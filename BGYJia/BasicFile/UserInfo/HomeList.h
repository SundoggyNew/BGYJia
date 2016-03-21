//
//  HomeList.h
//
//  Created by  周深发 on 16/3/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyList.h"

@interface HomeList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *keyList;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) double houseID;
@property (nonatomic, strong) NSString *houseName;
@property (nonatomic, assign) id houseCode;
@property (nonatomic, assign) double keyCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
