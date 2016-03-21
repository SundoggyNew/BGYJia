//
//  BGYRegisterForInputView.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/3.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYRegisterForInputView.h"

@interface BGYRegisterForInputView ()

@property (nonatomic , strong) UITextField * mainTextField;

@end

@implementation BGYRegisterForInputView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addSubview:self.mainTextField];
        
        [self addSubview:self.rightButton];
        
    }
    return self;
}

-(void)layoutSubviews
{
    CGRect mainTextFieldRect;
    CGRect rightButtonRect;
    
    if (self.haveRightButton) {
        
        mainTextFieldRect = CGRectMake(SELF_WIDTH*0.05, 0, SELF_WIDTH*0.65, SELF_HEIGHT);
        rightButtonRect = CGRectMake(SELF_WIDTH*0.7, SELF_HEIGHT*0.15, SELF_WIDTH*0.25, SELF_HEIGHT*0.7);
        
    }else{
        
        mainTextFieldRect = CGRectMake(SELF_WIDTH*0.05, 0, SELF_WIDTH, SELF_HEIGHT);
        rightButtonRect = CGRectMake(0, 0, 0, 0);
        
    }
    
    self.mainTextField.frame = mainTextFieldRect;
    
    self.rightButton.frame   = rightButtonRect;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [UIColorFromRGB(0xe0e0e1) setStroke];
    
    CGContextSetLineWidth(context, 1.0f);
    
    CGContextMoveToPoint(context, 24, rect.size.height);
    
    CGContextAddLineToPoint(context, rect.size.width-24, rect.size.height);
    
    CGContextStrokePath(context);
    
}

#pragma mark - public methods

- (NSString *)getTheInputFieldText {
    return self.mainTextField.text;
}

-(BOOL)outOfFirstResponder
{
    return [self.mainTextField resignFirstResponder];
}

#pragma mark - set methods

-(void)setHaveRightButton:(BOOL)haveRightButton
{
    _haveRightButton = haveRightButton;
    
    [self layoutSubviews];
}

-(void)setMainPlaceholder:(NSString *)mainPlaceholder
{
    _mainPlaceholder = mainPlaceholder;
    
    self.mainTextField.placeholder = _mainPlaceholder;
}

-(void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    
    self.mainTextField.secureTextEntry = _secureTextEntry;
}

-(void)setText:(NSString *)text
{
    _text = text;
    
    self.mainTextField.text = _text;
}
#pragma mark - initializes attributes

-(UITextField *)mainTextField
{
    if (!_mainTextField) {
        _mainTextField = [[UITextField alloc] init];
    }
    return _mainTextField;
}
-(UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
    }
    return _rightButton;
}

@end
