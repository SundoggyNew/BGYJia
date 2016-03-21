//
//  KeyList.h
//
//  Created by  周深发 on 16/3/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface KeyList : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double lockID;
@property (nonatomic, assign) double lockCode;
@property (nonatomic, strong) NSString *hCode;
@property (nonatomic, strong) NSString *dkey;
@property (nonatomic, assign) double enterpriseId;
@property (nonatomic, strong) NSString *enterpriseKey;
@property (nonatomic, assign) double keyStatus;
@property (nonatomic, assign) double keyType;
@property (nonatomic, strong) NSString *dCode;
@property (nonatomic, strong) NSString *lockName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
