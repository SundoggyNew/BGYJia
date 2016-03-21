//
//  BGYBasicViewController.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  UIViewController 基类
 */
@interface BGYBasicViewController : UIViewController

/** navgation 左按钮 */
@property (nonatomic,strong) UIButton * navgationLeftButton;

/** navgation 右按钮 */
@property (nonatomic,strong) UIButton * navgationRightButton;

/** navgation 标题字符串 */
@property (nonatomic , strong) NSString * titleViewString;

@end
