//
//  BGYTabBarController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/4.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYTabBarController.h"
#import "BGYTabBar.h"

#import "BGYOpenDoorViewController.h"
#import "BGYVisitorViewController.h"
#import "BGYWalletViewController.h"
#import "BGYVIPViewController.h"

@interface BGYTabBarController () <BGYTabBarDelegate>

@property (nonatomic , strong)  BGYTabBar *myTabBar;

@end
static BGYTabBarController * tabBar;
@implementation BGYTabBarController

+(instancetype)runTabBar
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabBar = [BGYTabBarController new];
    });
    
    return tabBar;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationController * openDoorNav = [[UINavigationController alloc] initWithRootViewController:[BGYOpenDoorViewController new]];
    
    UINavigationController * visitorNav = [[UINavigationController alloc] initWithRootViewController:[BGYVisitorViewController new]];
    
    UINavigationController * walletNav = [[UINavigationController alloc] initWithRootViewController:[BGYWalletViewController new]];
    
    UINavigationController * vipNav = [[UINavigationController alloc] initWithRootViewController:[BGYVIPViewController new]];
    
    self.viewControllers = @[openDoorNav,visitorNav,walletNav,vipNav];
    
    self.myTabBar = [[BGYTabBar alloc] init];
    self.myTabBar.delegate = self;
    self.myTabBar.frame = self.tabBar.bounds;
    self.myTabBar.backgroundColor = [UIColor whiteColor];
    [self.tabBar addSubview:self.myTabBar];
    
    for (int i = 0; i < self.viewControllers.count; i++) {
        NSString *name = [NSString stringWithFormat:@"TabBar%d", i + 1];
        NSString *selName = [NSString stringWithFormat:@"TabBar%dSel", i + 1];
        
        [self.myTabBar addTabButtonWithName:name selName:selName];
    }
    
    
}

-(void)selectedIndex:(NSInteger)index
{
    [self.myTabBar selectedIndex:index];
}

#pragma mark - BGYTabBar delegate method
- (void)tabBar:(BGYTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to
{
    
    self.selectedIndex = to;
    
}


@end
