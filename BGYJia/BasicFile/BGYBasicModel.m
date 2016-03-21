//
//  BGYBasicModel.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicModel.h"

@interface BGYBasicModel ()

@property (nonatomic , strong) LKDBHelper * dbHelper;

@end

@implementation BGYBasicModel

+(NSString *)getTableName
{
    return NSStringFromClass([self class]);
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
