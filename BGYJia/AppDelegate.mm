//
//  AppDelegate.m
//  BGYJia
//
//  Created by JohnsonChou on 16/2/28.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//
#import "AppDelegate.h"
#import "BGYLoginViewController.h"
#import "CarduoBluetooth.h"
#import "CarduoAudioTool.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setUpThirdSupportPart:launchOptions];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    User *user = [User runUser];
    
    NSString * password = user.password;
    
    JCLog(@"login param : %@ -- %@",user.cellphone,user.password);
    
    if (user.haveData) {
        
        self.window.rootViewController = [BGYTabBarController runTabBar];
        
        @weakify(self);
        [[JCNetWorking runNetWorking] loginWithAccount:user.cellphone passWord:password loginMethod:1 success:^(NSDictionary *dictionary) {
            @strongify(self);
            
            if ([[dictionary objectForKey:@"errorcode"] integerValue] == 0) {
                
                User * user = [User runUser];
                
                [user setUpWithDictionary:dictionary];
                [user saveToDB];
                
                self.window.rootViewController = [BGYTabBarController runTabBar];
                
            }else{
                
                JCRemindView * remindView = [JCRemindView remindWithMessage:@"登录信息发生错误，请重试" hideForTime:1 andHideBlock:^{
                    
                    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[BGYLoginViewController new]];
                    
                    self.window.rootViewController = nav;
                    
                }];
                
                [remindView show];
                
            }
            
            
        } orFailure:^(NSError *error) {
            @strongify(self);
            
            JCRemindView * remindView = [JCRemindView remindWithMessage:@"登录信息错误，请重试" hideForTime:2 andHideBlock:^{
                
                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[BGYLoginViewController new]];
                
                self.window.rootViewController = nav;
                
            }];
            
            [remindView show];
        }];
        
        
    } else {
        
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[BGYLoginViewController new]];
        
        self.window.rootViewController = nav;
        
    }
    
    return YES;
}

-(void)applicationWillResignActive:(UIApplication *)application
{
}
-(void)applicationDidEnterBackground:(UIApplication *)application
{
}
-(void)applicationWillEnterForeground:(UIApplication *)application
{
    JCLog(@"进入前台");
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}
-(void)applicationDidBecomeActive:(UIApplication *)application
{
}
-(void)applicationWillTerminate:(UIApplication *)application
{
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    //iOS 7及之后才能用，现在没人适配iOS6了吧...
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    JCLog(@"----------------------------- here is userInfo : %@ ",userInfo);
    
    if (application.applicationState == UIApplicationStateActive) {
        UILocalNotification *notification=[[UILocalNotification alloc] init];
        if (notification!=nil) {
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
            
            notification.fireDate=date ;
            notification.timeZone=[NSTimeZone defaultTimeZone];
            notification.alertBody= [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
            notification.soundName = UILocalNotificationDefaultSoundName;
            notification.userInfo = userInfo;
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
    }
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    JCLog(@"----------------------------- here is notification : %@ ",notification);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    JCLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
-(void)setUpThirdSupportPart:(NSDictionary *)launchOptions
{
    [CarduoBluetooth setupAppKey:@"S3sdY7t5rT4yU08oE2"];
    [CarduoAudioTool setAppKey:@"S3sdY7t5rT4yU08oE1"];
    
    [TalkingData sessionStarted:TablkingData_AppID withChannelId:@"AppStore"];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:@"0bd5a93e98b90b5b679e7379" channel:@"" apsForProduction:NO];
}

@end
