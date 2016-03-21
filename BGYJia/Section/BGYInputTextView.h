//
//  BGYInputTextView.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicView.h"

@interface BGYInputTextView : BGYBasicView

@property (nonatomic , assign) BOOL secureTextEntry;

-(instancetype)initWithLeftImage:(UIImage *)leftImage andPlaceholder:(NSString *)placeholder;




/**
 *  获取输入
 *
 *  @return 输入
 */
-(NSString *)getTheInputFieldText;




/**
 *  给textField的text赋值方法
 *
 *  @param text textField的text属性
 */
- (void)setTheInputFieldText:(NSString *)text;




/**
 *  退出输入
 *
 *  @return 退出输入
 */
-(BOOL)outOfFirstResponder;

@end
