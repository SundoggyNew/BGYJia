//
//  BGYOpenDoorSubViewShark.h
//  BGYJia
//
//  Created by LvJun on 16/3/9.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  BGYOpenDoorSubViewSharkDelegate <NSObject>

@property (nonatomic, strong) NSMutableArray  * dataArr;

@optional


@end

@interface BGYOpenDoorSubViewShark : UIView

@property (nonatomic, strong) UIImageView *cIcon;
@property (nonatomic, strong) UILabel     *cComment;
@property (nonatomic,strong) id<BGYOpenDoorSubViewSharkDelegate> delegate;

-(void)openBlueShake;

-(void) loadData;

@end
