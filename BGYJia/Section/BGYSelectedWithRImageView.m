//
//  BGYSelectedWithRImageView.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/7.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYSelectedWithRImageView.h"

@interface BGYSelectedWithRImageView ()

/** 左侧标题 */
@property (nonatomic , strong) UILabel                * leftTitleLabel;


@property (nonatomic , strong) UIImageView                * rightImageView;

/** 右侧图标 */
@property (nonatomic , strong) UIImageView            * rightIndicateImageView;

/** tap 手势 */
@property (nonatomic , strong) UITapGestureRecognizer * tap;

/** 全面积覆盖响应事件 */
@property (nonatomic , copy  ) VVBlock                tapClickBlog;

@end

@implementation BGYSelectedWithRImageView


-(void)dealloc
{
    self.tapClickBlog = nil;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.leftTitleLabel];
        [self addSubview:self.rightImageView];
        [self addSubview:self.rightIndicateImageView];
        [self addGestureRecognizer:self.tap];
        self.userInteractionEnabled = YES;
        self.inTapClick = YES;
        self.haveRightImage = YES;
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
    
    self.rightIndicateImageView.frame = CGRectMake(SELF_WIDTH*0.925,
                                           SELF_HEIGHT*0.35,
                                           SELF_WIDTH*0.025,
                                           SELF_HEIGHT*0.3);
    
    self.rightImageView.frame = CGRectMake(SELF_WIDTH*0.700,
                                            (SELF_HEIGHT - SELF_WIDTH*0.16)/2.0,
                                            SELF_WIDTH*0.16,
                                            SELF_WIDTH*0.16);
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
#pragma mark - set methods

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
-(void)setHaveRightImage:(BOOL)haveRightImage
{
    _haveRightImage = haveRightImage;
    
    self.rightIndicateImageView.hidden = !_haveRightImage;
}
-(void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    
    self.leftTitleLabel.font = [UIFont systemFontOfSize:self.fontSize];
}
-(void)setRightImage:(NSString *)rightImage
{
    _rightImage = rightImage;
    
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:_rightImage]];
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
-(UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.layer.masksToBounds = YES;
        _rightImageView.layer.cornerRadius = 3.0f;
        _rightImageView.backgroundColor = MAIN_COLOR;
    }
    return _rightImageView;
}
-(UIImageView *)rightIndicateImageView
{
    if (!_rightIndicateImageView) {
        _rightIndicateImageView = [[UIImageView alloc] init];
        _rightIndicateImageView.image = [UIImage imageNamed:@"icon_back"];
    }
    return _rightIndicateImageView;
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
