//
//  BGYInputTextView.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYInputTextView.h"

@interface BGYInputTextView ()

@property (nonatomic , strong) UIImageView * leftImageView;

@property (nonatomic , strong) UITextField * mainTextField;

@end

@implementation BGYInputTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.leftImageView];
        
        [self addSubview:self.mainTextField];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftImageView.frame = CGRectMake(0.074*SELF_WIDTH,
                                          0.293*SELF_HEIGHT,
                                          0.0575*SELF_WIDTH,
                                          0.404*SELF_HEIGHT);
    
    self.mainTextField.frame = CGRectMake(0.212*SELF_WIDTH,
                                          0.293*SELF_HEIGHT,
                                          0.550*SELF_WIDTH,
                                          0.404*SELF_HEIGHT);
}

-(instancetype)initWithLeftImage:(UIImage *)leftImage andPlaceholder:(NSString *)placeholder
{
    self = [self init];
    if (self) {
        
        self.leftImageView.image = leftImage;
        
        self.mainTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
    }
    return self;
}

- (NSString *)getTheInputFieldText {
    return self.mainTextField.text;
}

- (void)setTheInputFieldText:(NSString *)text {
    self.mainTextField.text = text;
}

- (BOOL)outOfFirstResponder {
    return [self.mainTextField resignFirstResponder];
}

#pragma mark - set method

-(void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    
    self.mainTextField.secureTextEntry = _secureTextEntry;
}

#pragma mark - initializes attributes

-(UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}
-(UITextField *)mainTextField
{
    if (!_mainTextField) {
        _mainTextField = [[UITextField alloc] init];
    }
    return _mainTextField;
}

@end
