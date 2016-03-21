//
//  BGYWithoutRImageView.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/7.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYWithoutRImageView.h"

@interface BGYWithoutRImageView ()

/** 左侧标题 */
@property (nonatomic , strong) UILabel                * leftTitleLabel;

@property (nonatomic , strong) UILabel                * rightTitleLabel;

/** tap 手势 */
@property (nonatomic , strong) UITapGestureRecognizer * tap;

/** 全面积覆盖响应事件 */
@property (nonatomic , copy  ) VVBlock                tapClickBlog;

@end

@implementation BGYWithoutRImageView

-(void)dealloc
{
    self.tapClickBlog = nil;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.leftTitleLabel];
        [self addSubview:self.rightTitleLabel];
        [self addGestureRecognizer:self.tap];
        self.userInteractionEnabled = YES;
        self.inTapClick = YES;
        self.fontSize = 15.0f;
    }
    return self;
}

-(void)layoutSubviews
{
    self.leftTitleLabel.frame = CGRectMake(SELF_WIDTH*0.05,
                                           0,
                                           SELF_WIDTH*0.3,
                                           SELF_HEIGHT);

    self.rightTitleLabel.frame = CGRectMake(SELF_WIDTH*0.550,
                                            SELF_HEIGHT*0.10,
                                            SELF_WIDTH*0.400,
                                            SELF_HEIGHT*0.80);
}

-(void)didReceiveTapClick:(UITapGestureRecognizer *)tap
{
    if (self.tapClickBlog) {
        self.tapClickBlog();
    }
}
-(void)didReceiveTapClickBlog:(void (^)(void))tapEventBlog
{
    self.tapClickBlog = tapEventBlog;
}
-(void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    
    self.leftTitleLabel.text = _titleString;
}
-(void)setInTapClick:(BOOL)inTapClick
{
    _inTapClick = inTapClick;
    
    self.tap.enabled = _inTapClick;
}
-(void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    
    self.leftTitleLabel.font = [UIFont systemFontOfSize:self.fontSize];
}
-(void)setRightTitleString:(NSString *)rightTitleString
{
    _rightTitleString = rightTitleString;
    
    self.rightTitleLabel.text = _rightTitleString;
}
#pragma mark - initializes attributes
-(UILabel *)leftTitleLabel
{
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] init];
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        _leftTitleLabel.font = [UIFont systemFontOfSize:20.0f];
        _leftTitleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _leftTitleLabel;
}
-(UILabel *)rightTitleLabel
{
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] init];
        _rightTitleLabel.textAlignment = NSTextAlignmentRight;
        _rightTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        _rightTitleLabel.textColor = [UIColor lightGrayColor];
        _rightTitleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _rightTitleLabel;
}
-(UITapGestureRecognizer *)tap
{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                       action:@selector(didReceiveTapClick:)];
    }
    return _tap;
}

@end
