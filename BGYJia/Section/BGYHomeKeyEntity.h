//
//  BGYHomeKetEntity.h
//  BGYJia
//
//  Created by LvJun on 16/3/15.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeList.h"
#import "KeyList.h"
@interface BGYHomeKeyEntity : NSObject

@property (nonatomic, strong) HomeList *homeList;
@property (nonatomic, strong) KeyList  *KeyList;

@end
