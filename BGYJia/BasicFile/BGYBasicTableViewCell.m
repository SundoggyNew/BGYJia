//
//  BGYBasicTableViewCell.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicTableViewCell.h"

@implementation BGYBasicTableViewCell

+(NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

@end
