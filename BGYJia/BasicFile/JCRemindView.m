//
//  JCRemindView.m
//  JCRemindView
//
//  Created by JohnsonChou on 15/12/14.
//  Copyright © 2015年 Bradley Johnson. All rights reserved.
//
#import "JCRemindView.h"

@interface JCRemindView ()

@property (nonatomic , strong) UILabel * remindLabel;

@property (nonatomic , assign) NSInteger goOutAnimation;

@property (nonatomic , assign , getter=isShow) BOOL show;

@end

static JCRemindView * remindView;

@implementation JCRemindView

-(void)dealloc
{
    self.finish = nil;
}

+(instancetype)defaultRemind
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        remindView = [JCRemindView new];
    });
    
    return remindView;
}

+(instancetype)remindWithMessage:(NSString *)remindMessage hideForTime:(NSInteger)time andHideBlock:(finishBlock)eventBlock
{
    JCRemindView * remindView = [JCRemindView defaultRemind];
    
    if (!remindView.isShow) {
        remindView.remindString = remindMessage;
        remindView.time = time;
        remindView.finish = eventBlock;
    }
    
    return remindView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8f];
        
        self.layer.masksToBounds = YES;
        
        self.layer.cornerRadius  = 5.0f;
        
        [self addSubview:self.remindLabel];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.remindLabel.frame = self.bounds;
}

#pragma mark - public methods

-(void)show
{
    if (self.isShow) {
        return;
    }
    
    NSDictionary * attributes = @{NSFontAttributeName:self.remindLabel.font};
    
    CGSize mainSize = [self.remindLabel.text boundingRectWithSize:CGSizeMake(1000, 35)
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:attributes
                                                          context:nil].size;
    
    self.bounds = CGRectMake(0,0,mainSize.width+10,35);
    
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    
    [window addSubview:self];
    
    [self upAnimation]; 
    
    [self hide];
}

-(void)hide
{
    __block int timeout = (int)self.time;
    
    @weakify(self);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        @strongify(self);
        
        if(timeout<=0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self downAnimation];
                
            });
        }else{
            int seconds = timeout % (self.time + 1);
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSLog(@" --- %@ --- ",strTime);
                
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);
}

-(void)upAnimation
{
    self.show = YES;
    
    CABasicAnimation * animationForPosition = [CABasicAnimation animationWithKeyPath:@"position"];
    
    animationForPosition.fromValue           = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT)];
    animationForPosition.toValue             = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT*0.75)];
    
    CABasicAnimation * animationForOpacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animationForOpacity.fromValue           = @(0);
    animationForOpacity.toValue             = @(1);
    
    CAAnimationGroup * showAnimationGroup = [CAAnimationGroup animation];
    showAnimationGroup.duration            = 0.5;
    showAnimationGroup.fillMode            = kCAFillModeForwards;
    showAnimationGroup.removedOnCompletion = NO;
    showAnimationGroup.delegate            = self;
    
    showAnimationGroup.animations = [NSArray arrayWithObjects:animationForPosition,animationForOpacity, nil];
    
    [self.layer addAnimation:showAnimationGroup forKey:@"group"];
}

-(void)downAnimation
{
    CABasicAnimation * animationForOpacity  = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animationForOpacity.fromValue           = @(1);
    animationForOpacity.toValue             = @(0);
    animationForOpacity.duration            = 0.75;
    animationForOpacity.fillMode            = kCAFillModeForwards;
    animationForOpacity.removedOnCompletion = NO;
    animationForOpacity.delegate            = self;
    
    [self.layer addAnimation:animationForOpacity forKey:@"opacity"];
}

-(void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"animation start");
    self.goOutAnimation++;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animation stop : %@",flag?@"YES":@"NO");
    
    self.goOutAnimation++;
    
    if (self.goOutAnimation == 4) {
        self.goOutAnimation = 0;
        
        if (self.finish) {
            self.finish();
        }
        
        [self removeFromSuperview];
        
        self.show = NO;
    }
    
}

#pragma mark -  set methods

-(void)setRemindString:(NSString *)remindString
{
    _remindString = remindString;
    
    self.remindLabel.text = _remindString;
}

#pragma mark - initializes attributes
-(UILabel *)remindLabel
{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] init];
        _remindLabel.textColor = [UIColor whiteColor];
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.font = [UIFont systemFontOfSize:18.0f];
    }
    return _remindLabel;
}


@end
