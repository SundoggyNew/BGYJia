//
//  BGYOpenDoorView.m
//  BGYJia
//
//  Created by 孙伟 on 16/3/8.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYOpenDoorView.h"

@interface BGYOpenDoorView()

@property (nonatomic, strong) UILabel *privateLabel;

@property (nonatomic, strong) UIImageView *privateImageView;

@end

@implementation BGYOpenDoorView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.button];
        [self addSubview:self.privateLabel];
//        if (self.haveImageView) {
            [self addSubview:self.privateImageView];
//        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.haveImageView) {
        
        self.privateImageView.center = CGPointMake(SELF_WIDTH * 0.5, SELF_HEIGHT * 0.165);
        
        CGSize size = CGSizeMake(SELF_HEIGHT * 0.39, SELF_HEIGHT * 0.194);
        
        self.privateImageView.bounds = (CGRect){CGPointZero, size};
        
        self.button.center = CGPointMake(SELF_WIDTH * 0.5, SELF_HEIGHT * 0.539);
        
        size = CGSizeMake(SELF_HEIGHT * 0.47, SELF_HEIGHT * 0.47);
        
        self.button.bounds = (CGRect){CGPointZero, size};
        
        self.privateLabel.frame = CGRectMake(SELF_WIDTH * 0.274, SELF_HEIGHT * 0.806, SELF_WIDTH * 0.452, SELF_WIDTH * 0.102);
        
    } else {
        
        self.button.center = CGPointMake(SELF_WIDTH * 0.5, SELF_HEIGHT * 0.441);
        
        CGSize size = CGSizeMake(SELF_HEIGHT * 0.47, SELF_HEIGHT * 0.47);
        
        self.button.bounds = (CGRect){CGPointZero, size};
        
//        self.button.frame = CGRectMake(SELF_WIDTH * 0.337, SELF_HEIGHT * 0.204, SELF_WIDTH * 0.326, SELF_WIDTH * 0.326);
        
        self.privateLabel.frame = CGRectMake(SELF_WIDTH * 0.274, SELF_HEIGHT * 0.741, SELF_WIDTH * 0.452, SELF_WIDTH * 0.102);
    }
    
}

- (instancetype)initWithImageName:(NSString *)imageName andLabelStr:(NSString *)labelStr {
    self = [self init];
    if (self) {
        [self.button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        self.privateLabel.text = labelStr;
    }
    return self;
}

#pragma mark - initializes attributes

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _button;
}

- (UILabel *)privateLabel {
    if (!_privateLabel) {
        _privateLabel = [[UILabel alloc] init];
        _privateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _privateLabel;
}

- (UIImageView *)privateImageView {
    if (!_privateImageView) {
        _privateImageView = [[UIImageView alloc] init];
        _privateImageView.image = [UIImage imageNamed:@"shenyin"];
    }
    return _privateImageView;
}

@end
