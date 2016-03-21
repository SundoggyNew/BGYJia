//
//  BGYBasicCollectionViewCell.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicCollectionViewCell.h"

@implementation BGYBasicCollectionViewCell

+(NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

@end
