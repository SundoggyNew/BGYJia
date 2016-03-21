//
//  JCActionView.h
//  JCActionView
//
//  Created by JohnsonChou on 16/3/3.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol JCActionViewDelegate;

@interface JCActionView : UIView

@property (nonatomic , weak) id<JCActionViewDelegate> delegate;

-(instancetype)initWithDelegate:(id)delegate cancelTitle:(NSString *)cancelTitle Titles:(NSString *)otherTitles,...NS_REQUIRES_NIL_TERMINATION;

-(void)show;

@end


@protocol JCActionViewDelegate <NSObject>

-(void)jcActionView:(JCActionView *)actionView selectedWithTitle:(NSString *)title index:(NSInteger)index;

@end