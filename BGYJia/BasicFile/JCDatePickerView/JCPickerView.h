//
//  JCPickerView.h
//  JCActionView
//
//  Created by JohnsonChou on 16/3/6.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCPickerView : UIView

-(void)showWithFinish:(VSBlock)finish orCancel:(VVBlock)cancel;

@end
