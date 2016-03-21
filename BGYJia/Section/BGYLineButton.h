//
//  BGYLineButton.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/7.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicButton.h"

@interface BGYLineButton : BGYBasicButton

/** 上划线 */
@property (nonatomic , assign) BOOL haveLineUp;

/** 下划线 */
@property (nonatomic , assign) BOOL haveLineDown;

/** 左划线 */
@property (nonatomic , assign) BOOL haveLineLeft;

/** 右划线 */
@property (nonatomic , assign) BOOL haveLineRight;

/** 线颜色 */
@property (nonatomic , strong) UIColor * lineColor;


@end
