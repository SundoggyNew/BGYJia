//
//  JCActionView.m
//  JCActionView
//
//  Created by JohnsonChou on 16/3/3.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//
#define CELL_HEIGHT 0.086*[[UIScreen mainScreen] bounds].size.height
#define CELL_SPACE_DEEP 15
#define CELL_SPACE_BETWEEN 10

#import "JCActionView.h"

@interface JCActionView ()

@property (nonatomic , strong) UIView * backgroundView;

@property (nonatomic , strong) UIButton * cancelButton;

@property (nonatomic , strong) NSMutableArray * otherButtonTitles;

@property (nonatomic , assign) NSInteger cellNumber;

@property (nonatomic , strong) UITapGestureRecognizer * deepTap;

@end

@implementation JCActionView

-(void)dealloc
{
    self.delegate = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setUpFixedUI];
    }
    return self;
}

-(void)layoutSubviews
{
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    
    CGFloat needHeight = CELL_HEIGHT*(self.cellNumber + 1)+CELL_SPACE_BETWEEN+CELL_SPACE_DEEP;
    
    self.backgroundView.frame = CGRectMake(0, height - needHeight, width, needHeight);
    
    self.cancelButton.frame = CGRectMake(width*0.025, needHeight - CELL_HEIGHT - CELL_SPACE_DEEP, width*0.95, CELL_HEIGHT);
}

#pragma mark - public methods

-(instancetype)initWithDelegate:(id)delegate cancelTitle:(NSString *)cancelTitle Titles:(NSString *)otherTitles, ...
{
    self = [self init];
    if (self) {
        
        self.delegate = delegate;
        
        [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
        
        va_list args;
        va_start(args, otherTitles);
        if (otherTitles) {
            [self.otherButtonTitles addObject:otherTitles];
            while (1) {
                NSString *otherButtonTitle = va_arg(args, NSString *);
                if (otherButtonTitle == nil) {
                    break;
                } else {
                    [self.otherButtonTitles addObject:otherButtonTitle];
                }
            }
        }
        va_end(args);

        self.cellNumber = self.otherButtonTitles.count;
        
        if (self.cellNumber) {
            
            [self setUpCreateUI];
            
        }
    }
    return self;
}

-(void)show
{
    self.frame = [[UIScreen mainScreen] bounds];
    
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    
    [window addSubview:self];
    
    [self showAnimation];
}


#pragma mark - private methods

-(void)setUpFixedUI
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];

    [self addGestureRecognizer:self.deepTap];
    
    self.userInteractionEnabled = YES;
    
    [self addSubview:self.backgroundView];
    
    [self.backgroundView addSubview:self.cancelButton];
    
}

-(void)setUpCreateUI
{
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    
    UIView * otherButtonView = [UIView new];
    otherButtonView.backgroundColor = [UIColor redColor];
    otherButtonView.layer.masksToBounds      = YES;
    otherButtonView.layer.cornerRadius       = 5.0f;
    otherButtonView.frame = CGRectMake(width*0.025, 0, width*0.95, CELL_HEIGHT*self.otherButtonTitles.count);
    
    for (NSInteger index = 0; index < self.otherButtonTitles.count; index++) {
        
        UIButton * actionButton                          = [[UIButton alloc] init];
        actionButton.backgroundColor          = [UIColor whiteColor];
        actionButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [actionButton setTitle:[self.otherButtonTitles objectAtIndex:index] forState:UIControlStateNormal];
        [actionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [actionButton addTarget:self action:@selector(didReceiveOtherButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        actionButton.frame = CGRectMake(0, CELL_HEIGHT*index, width*0.95, CELL_HEIGHT);
        
        [otherButtonView addSubview:actionButton];
        
        if (index != self.otherButtonTitles.count - 1) {
            UIView * lineView = [UIView new];
            lineView.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:212/255.0 alpha:1];
            lineView.frame = CGRectMake(0, CELL_HEIGHT*(index + 1)-1, width*0.95, 1);
            [otherButtonView addSubview:lineView];
        }
        
    }
    
    [self.backgroundView addSubview:otherButtonView];
}

-(void)showAnimation
{
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    
    CGFloat needHeight = CELL_HEIGHT*(self.cellNumber + 1)+CELL_SPACE_BETWEEN+CELL_SPACE_DEEP;
    
    self.backgroundView.frame = CGRectMake(0, height, width, needHeight);
    
    [UIView animateWithDuration:0.35 animations:^{
        
        self.backgroundView.frame = CGRectMake(0, height - needHeight, width, needHeight);
        
    } completion:^(BOOL finished) {
        
        self.backgroundView.frame = CGRectMake(0, height - needHeight, width, needHeight);
        
    }];
}

-(void)hideAnimation:(VVBlock)finishBlock
{
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    
    CGFloat needHeight = CELL_HEIGHT*(self.cellNumber + 1)+CELL_SPACE_BETWEEN+CELL_SPACE_DEEP;
    
    @weakify(self);
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self);
        self.backgroundView.frame = CGRectMake(0, height, width, needHeight);
        
    } completion:^(BOOL finished) {
        @strongify(self);
        self.backgroundView.frame = CGRectMake(0, height, width, needHeight);
        
        [self removeFromSuperview];
        
        if (finishBlock) {
            finishBlock();
        }
        
    }];
}

-(void)didReceiveTapClick:(UITapGestureRecognizer *)tap
{
    [self hideAnimation:nil];
}

-(void)didReceiveCancelButtonClick:(UIButton *)button
{
    [self hideAnimation:nil];
}

-(void)didReceiveOtherButtonClick:(UIButton *)button
{
    for (NSInteger index = 0; index < self.otherButtonTitles.count; index++) {
        
        if ([button.titleLabel.text isEqualToString:[self.otherButtonTitles objectAtIndex:index]]) {
            
            @weakify(self);
            [self hideAnimation:^{
                @strongify(self);
                
                if ([self.delegate respondsToSelector:@selector(jcActionView:selectedWithTitle:index:)]) {
                    [self.delegate jcActionView:self selectedWithTitle:button.titleLabel.text index:index];
                }
                
            }];

        }
    }
    
}


#pragma mark - initializes attributes

-(UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor clearColor];
    }
    return _backgroundView;
}

-(UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton                          = [[UIButton alloc] init];
        _cancelButton.backgroundColor          = [UIColor whiteColor];
        _cancelButton.layer.masksToBounds      = YES;
        _cancelButton.layer.cornerRadius       = 5.0f;
        _cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithRed:251/255.0 green:72/255.0 blue:101/255.0 alpha:1] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(didReceiveCancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
-(UITapGestureRecognizer *)deepTap
{
    if (!_deepTap) {
        _deepTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didReceiveTapClick:)];
    }
    return _deepTap;
}
-(NSMutableArray *)otherButtonTitles
{
    if (!_otherButtonTitles) {
        _otherButtonTitles = [[NSMutableArray alloc] init];
    }
    return _otherButtonTitles;
}

@end
