//
//  BGYBasicView.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYBasicView.h"

@implementation BGYBasicView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.haveLineUp = NO;
        self.haveLineDown = NO;
        self.lineColor = UICOLOR_RGB(233, 233, 233, 1);
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    if (self.haveLineUp) {
        [self drawlineUp:rect];
    }
    
    if (self.haveLineDown) {
        [self drawlineDown:rect];
    }
}

-(void)drawlineUp:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.lineColor setStroke];
    
    CGContextSetLineWidth(context, 1.0f);
    
    CGContextMoveToPoint(context, 0, 0);
    
    CGContextAddLineToPoint(context, rect.size.width, 0);
    
    CGContextStrokePath(context);
}
-(void)drawlineDown:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.lineColor setStroke];
    
    CGContextSetLineWidth(context, 1.0f);
    
    CGContextMoveToPoint(context, 0, rect.size.height);
    
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    
    CGContextStrokePath(context);
}

#pragma mark - set method
-(void)setHaveLineUp:(BOOL)haveLineUp
{
    _haveLineUp = haveLineUp;
    
    [self setNeedsDisplay];
}
-(void)setHaveLineDown:(BOOL)haveLineDown
{
    _haveLineDown = haveLineDown;
    
    [self setNeedsDisplay];
}
-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    
    [self setNeedsDisplay];
}

@end
