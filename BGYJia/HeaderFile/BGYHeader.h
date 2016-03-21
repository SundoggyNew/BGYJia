//
//  BGYHeader.h
//  BGYJia
//
//  Created by JohnsonChou on 16/2/29.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#ifndef BGYHeader_h
#define BGYHeader_h

#pragma mark - Cocoapod 导入第三方框架
#import "AFNetworking.h"                        //网络连接库
#import "FMDB.h"                                //数据库存储库
#import "Masonry.h"                             //适配库
#import "UIImageView+WebCache.h"                //图片加载库
#import "TPKeyboardAvoidingTableView.h"         //滑动键盘遮挡TableView
#import "TPKeyboardAvoidingScrollView.h"        //滑动键盘遮挡ScrollView
#import "TPKeyboardAvoidingCollectionView.h"    //滑动键盘遮挡CollectionView
#import "ReactiveCocoa.h"                       //链式响应编程
#import "DQAlertView.h"                         //提示器
#import "MBProgressHUD.h"                       //HUD
#import "LKDBHelper.h"                          //FMDB二次操作库
#import "MJRefresh.h"                           //刷新控件
#import "DateTools/DateTools.h"
#import "DateTools/NSDate+DateTools.h"
#import "WebViewJavascriptBridge.h"
#import "JPUSHService.h"

#import "TalkingData.h"

#pragma mark - 宏

#define TablkingData_AppID @"6F8A93AF41D795C206AF7AE88DE40C0D"

// Log输出宏
#ifdef DEBUG
#   define JCLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define JCLog(...)
#endif

// 快速定义颜色宏
#define UICOLOR_RGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

typedef NS_ENUM(NSInteger,REGISTER_TYPE) {
    REGISTER_TYPE_OWNER = 0,
    REGISTER_TYPE_NOTOWNER,
};

// 主色调
#define MAIN_COLOR  UIColorFromRGB(0xfa4964)

#define SCREEN_WIDTH                    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT                   [UIScreen mainScreen].bounds.size.height
#define SELF_VIEW_WIDTH                 self.view.bounds.size.width
#define SELF_VIEW_HEIGHT                self.view.bounds.size.height
#define SELF_WIDTH                      self.bounds.size.width
#define SELF_HEIGHT                     self.bounds.size.height
#define SELF_CONTENTVIEW_WIDTH          self.contentView.bounds.size.width
#define SELF_CONTENTVIEW_HEIGHT         self.contentView.bounds.size.height

#pragma mark - 参数宏

#pragma mark - 自写第三方库

#import "DataModels.h"                            //用户库
//#import "RegularTools.h"                        //正则验证式
//#import "BBActionSheet.h"                       //动作列表
//#import "JCActionSheet.h"                       //动作列表
//#import "JCLoginViewController.h"               //登录前页
//#import "MJTabBarController.h"
#import "JCRemindView.h"                        //提示
//#import "HideInfo.h"                            //隐藏信息
#import "JCActionView.h"
#import "BGYTabBarController.h"
#import "RegularTools.h"
//#import "BGYPageButton.h"

#pragma mark - 头文件
//#import "StringHeader.h"
#import "BlockHeader.h"
#import "APIHeader.h"



#import "JCNetWorking.h"


#endif
