//
//  BGYTabBar.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/4.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BGYTabBar;

@protocol BGYTabBarDelegate <NSObject>

@optional
- (void)tabBar:(BGYTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to;

@end

@interface BGYTabBar : UIView

@property (nonatomic, weak) id<BGYTabBarDelegate> delegate;

/**
 *  用来添加一个内部的按钮
 */
- (void)addTabButtonWithName:(NSString *)name selName:(NSString *)selName;


-(void)selectedIndex:(NSInteger)index;


@end
