//
//  BlockHeader.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/4.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#ifndef BlockHeader_h
#define BlockHeader_h

typedef void(^VSBlock)(NSString * message);

typedef void(^VEBlock)(NSError * error);

typedef void(^VVBlock)(void);

typedef void(^VBBlock)(BOOL boolValue);

typedef void(^VDateBlock)(NSDate * date);

typedef void(^VIBlock)(id model);

typedef void(^VDBlock)(NSDictionary * dictionary);

typedef void(^VDNBlock)(NSDictionary * dictionary , NSInteger integer);

typedef void(^VUBlock)(User * user);

typedef void(^VNBlock)(NSInteger number);

typedef void(^VDSBlock)(NSString * message , NSInteger number);

typedef void(^VABlock)(NSArray * array);

#endif
