//
//  BGYSelectedWithRImageView.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/7.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicView.h"

@interface BGYSelectedWithRImageView : BGYBasicView

/** 标题字符串 */
@property (nonatomic , strong) NSString * titleString;

@property (nonatomic , strong) NSString * rightImage;

@property (nonatomic , assign) BOOL inTapClick;

@property (nonatomic , assign) BOOL haveRightImage;

@property (nonatomic , assign) CGFloat fontSize;




/**
 *  全面积覆盖响应方法
 *
 *  @param tapEventBlog 响应方法
 */
-(void)didReceiveTapClickBlog:(void(^)(void))tapEventBlog;


@end
