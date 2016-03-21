//
//  BGYLineButton.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/7.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYLineButton.h"

@implementation BGYLineButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.haveLineUp      = NO;
        self.haveLineDown    = NO;
        self.haveLineLeft    = NO;
        self.haveLineRight   = NO;
        self.lineColor       = UICOLOR_RGB(233, 233, 233, 1);
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
    
    if (self.haveLineLeft) {
        [self drawlineLeft:rect];
    }
    
    if (self.haveLineRight) {
        [self drawlineRight:rect];
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

-(void)drawlineLeft:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.lineColor setStroke];
    
    CGContextSetLineWidth(context, 1.0f);
    
    CGContextMoveToPoint(context, 0, 0);
    
    CGContextAddLineToPoint(context, 0, rect.size.height);
    
    CGContextStrokePath(context);
}

-(void)drawlineRight:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.lineColor setStroke];
    
    CGContextSetLineWidth(context, 1.0f);
    
    CGContextMoveToPoint(context, rect.size.width, 0);
    
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
-(void)setHaveLineLeft:(BOOL)haveLineLeft
{
    _haveLineLeft = haveLineLeft;
    
    [self setNeedsDisplay];
}
-(void)setHaveLineRight:(BOOL)haveLineRight
{
    _haveLineRight = haveLineRight;
    
    [self setNeedsDisplay];
}
-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    
    [self setNeedsDisplay];
}

@end
