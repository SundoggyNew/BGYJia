//
//  JCRemindView.h
//  JCRemindView
//
//  Created by JohnsonChou on 15/12/14.
//  Copyright © 2015年 Bradley Johnson. All rights reserved.
//

typedef void(^finishBlock)(void);

#import <UIKit/UIKit.h>

@interface JCRemindView : UIView

@property (nonatomic , strong) NSString * remindString;

@property (nonatomic , assign) NSInteger time;

@property (nonatomic , copy) finishBlock finish;

-(void)show;

-(void)hide;

+(instancetype)remindWithMessage:(NSString *)remindMessage hideForTime:(NSInteger)time andHideBlock:(finishBlock)eventBlock;


@end
