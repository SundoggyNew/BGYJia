//
//  BGYBasicView.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  view 基类。
 */
@interface BGYBasicView : UIView

/** 上划线 */
@property (nonatomic , assign) BOOL haveLineUp;

/** 下划线 */
@property (nonatomic , assign) BOOL haveLineDown;

/** 线颜色 */
@property (nonatomic , strong) UIColor * lineColor;

@end
