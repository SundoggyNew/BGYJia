//
//  BGYRegisterForInputView.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/3.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicView.h"

@interface BGYRegisterForInputView : BGYBasicView

@property (nonatomic , assign) BOOL haveRightButton;

@property (nonatomic , strong) NSString * mainPlaceholder;

@property (nonatomic , strong) NSString * text;

@property (nonatomic , strong) UIButton * rightButton;

@property (nonatomic , assign) BOOL secureTextEntry;




/**
 *  获取输入
 *
 *  @return 输入
 */
-(NSString *)getTheInputFieldText;


-(BOOL)outOfFirstResponder;

@end
