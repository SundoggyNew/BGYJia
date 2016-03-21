//
//  BList.h
//
//  Created by  周深发 on 16/3/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BList : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double typeId;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *dkey;
@property (nonatomic, assign) double lockID;
@property (nonatomic, assign) double houseCode;
@property (nonatomic, strong) NSString *houseName;
@property (nonatomic, assign) double houseID;
@property (nonatomic, strong) NSString *bkey;
@property (nonatomic, strong) NSString *dCode;
@property (nonatomic, strong) NSString *lockName;
@property (nonatomic, strong) NSString *bMac;
@property (nonatomic, assign) double lockCode;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
