//
//  BGYHouseListTableViewCell.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/3.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYHouseListTableViewCell.h"

@interface BGYHouseListTableViewCell ()

@property (nonatomic , strong) UILabel * mainLabel;

@end

@implementation BGYHouseListTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.mainLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    self.mainLabel.frame = CGRectMake(SELF_CONTENTVIEW_WIDTH*0.05, 0, SELF_CONTENTVIEW_WIDTH*0.95, SELF_CONTENTVIEW_HEIGHT);
}

- (void)drawRect:(CGRect)rect
{
    if (self.haveLineUp) {
        
        [self drawlineUp:rect];
        
    }
    
    [self drawlineDown:rect];
}

-(void)drawlineUp:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [UIColorFromRGB(0xe1e1e1) setStroke];
    
    CGContextSetLineWidth(context, 1.0f);
    
    CGContextMoveToPoint(context, rect.size.width*0.05, 0);
    
    CGContextAddLineToPoint(context, rect.size.width*0.95, 0);
    
    CGContextStrokePath(context);
}
-(void)drawlineDown:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [UIColorFromRGB(0xe1e1e1) setStroke];
    
    CGContextSetLineWidth(context, 1.0f);
    
    CGContextMoveToPoint(context, rect.size.width*0.05, rect.size.height);
    
    CGContextAddLineToPoint(context, rect.size.width*0.95, rect.size.height);
    
    CGContextStrokePath(context);
}


#pragma mark - set methods

-(void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    
    self.mainLabel.text = _titleString;
}

-(void)setHaveLineUp:(BOOL)haveLineUp
{
    _haveLineUp = haveLineUp;
    
    [self setNeedsDisplay];
}


#pragma mark - initializes attributes
-(UILabel *)mainLabel
{
    if (!_mainLabel) {
        _mainLabel = [[UILabel alloc] init];
        _mainLabel.textColor = UIColorFromRGB(0xcccccd);
    }
    return _mainLabel;
}

@end
