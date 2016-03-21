//
//  BGYTabBarButton.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/4.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYTabBarButton.h"

@interface BGYTabBarButton ()

@property (nonatomic , strong) UIView * redView;

@end

@implementation BGYTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:self.redView];
        
        self.haveMessageToCheck = NO;

    }
    return self;
}

/**
 *  只要覆盖了这个方法,按钮就不存在高亮状态
 */
- (void)setHighlighted:(BOOL)highlighted
{
    //    [super setHighlighted:highlighted];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.redView.frame = CGRectMake(self.imageView.frame.origin.x+self.imageView.frame.size.width*2.0/3.0, self.imageView.frame.origin.y, self.imageView.frame.size.width/3.0, self.imageView.frame.size.width/3.0);
    
    self.redView.layer.cornerRadius = self.imageView.frame.size.width/6.0;
    
}

-(void)setHaveMessageToCheck:(BOOL)haveMessageToCheck
{
    _haveMessageToCheck = haveMessageToCheck;
    
    self.redView.backgroundColor = _haveMessageToCheck?[UIColor redColor]:[UIColor clearColor];
    
    [self layoutSubviews];
}





#pragma mark - initializes attributes

-(UIView *)redView
{
    if (!_redView) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = [UIColor redColor];
        _redView.layer.masksToBounds = YES;
    }
    return _redView;
}

@end
