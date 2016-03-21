//
//  BGYRegistSelecedCellView.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/4.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYRegisterSelecedCellView.h"

@interface BGYRegisterSelecedCellView ()

/** 左侧标题 */
@property (nonatomic , strong) UILabel                * leftTitleLabel;

@property (nonatomic , strong) UILabel                * rightTitleLabel;

/** 右侧图标 */
@property (nonatomic , strong) UIImageView            * rightImageView;

/** tap 手势 */
@property (nonatomic , strong) UITapGestureRecognizer * tap;

/** 全面积覆盖响应事件 */
@property (nonatomic , copy  ) VVBlock                tapClickBlog;


@end

@implementation BGYRegisterSelecedCellView

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
        [self addSubview:self.rightImageView];
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
    self.leftTitleLabel.frame = CGRectMake(self.bounds.size.width*0.05,
                                           0,
                                           self.bounds.size.width*0.3,
                                           self.bounds.size.height);
    
    self.rightImageView.frame = CGRectMake(self.bounds.size.width*0.925,
                                           self.bounds.size.height*0.35,
                                           self.bounds.size.width*0.025,
                                           self.bounds.size.height*0.3);
    
    self.rightTitleLabel.frame = CGRectMake(self.bounds.size.width*0.50,
                                            self.bounds.size.height*0.10,
                                            self.bounds.size.width*0.370,
                                            self.bounds.size.height*0.80);
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
-(void)setHaveRightImage:(BOOL)haveRightImage
{
    _haveRightImage = haveRightImage;
    
    self.rightImageView.hidden = !_haveRightImage;
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
        _rightTitleLabel.font = [UIFont systemFontOfSize:18.0f];
        _rightTitleLabel.textColor = [UIColor lightGrayColor];
        _rightTitleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _rightTitleLabel;
}
-(UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"icon_back"];
    }
    return _rightImageView;
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
