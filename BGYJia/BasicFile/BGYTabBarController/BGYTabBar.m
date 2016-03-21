//
//  BGYTabBar.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/4.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYTabBar.h"
#import "BGYTabBar.h"
#import "BGYTabBarButton.h"

@interface BGYTabBar()
/**
 *  记录当前选中的按钮
 */
@property (nonatomic, weak) BGYTabBarButton *selectedButton;
@end

@implementation BGYTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)addTabButtonWithName:(NSString *)name selName:(NSString *)selName
{
    BGYTabBarButton *button = [BGYTabBarButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = UIColorFromRGB(0x2e3540);
    
    [button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selName] forState:UIControlStateSelected];
    
    [self addSubview:button];
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }
    
    if (self.subviews.count == 4) {
        button.haveMessageToCheck = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = (int)self.subviews.count;
    for (int i = 0; i<count; i++) {
        BGYTabBarButton *button = self.subviews[i];
        button.tag = i;
        
        // 设置frame
        CGFloat buttonY = 0;
        CGFloat buttonW = self.frame.size.width / count;
        CGFloat buttonH = self.frame.size.height;
        CGFloat buttonX = i * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
    
    [self checkHide];
}

-(void)checkHide
{
//    HideInfo * hide = [HideInfo runInfo];
//    
//    BGYTabBarButton *oneButton = self.subviews[0];
//    BGYTabBarButton *button = self.subviews[2];
//    
//    if (hide.hide) {
//        [oneButton setImage:[UIImage imageNamed:@"index_black"] forState:UIControlStateNormal];
//        [oneButton setImage:[UIImage imageNamed:@"index"] forState:UIControlStateSelected];
//        
//        [button setImage:[UIImage imageNamed:@"icon-shang-black"] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"icon-shang-light"] forState:UIControlStateSelected];
//        
//    }else{
//        
//        [oneButton setImage:[UIImage imageNamed:@"TabBar1"] forState:UIControlStateNormal];
//        [oneButton setImage:[UIImage imageNamed:@"TabBar1Sel"] forState:UIControlStateSelected];
//        
//        [button setImage:[UIImage imageNamed:@"TabBar3"] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"TabBar3Sel"] forState:UIControlStateSelected];
//        
//    }
    
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(BGYTabBarButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    
    self.selectedButton.selected = NO;
    
    button.selected = YES;
    
    self.selectedButton = button;
}

-(void)selectedIndex:(NSInteger)index
{
    BGYTabBarButton *button = self.subviews[index];
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    
    self.selectedButton.selected = NO;
    
    button.selected = YES;
    
    self.selectedButton = button;
    
}
@end
