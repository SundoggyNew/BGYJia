//
//  BGYOpenDoorView.h
//  BGYJia
//
//  Created by 孙伟 on 16/3/8.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicView.h"

@interface BGYOpenDoorView : BGYBasicView

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, assign) BOOL haveImageView;

- (instancetype)initWithImageName:(NSString *)imageName andLabelStr:(NSString *)labelStr;

@end
