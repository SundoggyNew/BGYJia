//
//  CarduoAudioTool.h
//  CarduoAudioTool
//
//  Created by KDB on 15/12/11.
//  Copyright © 2015年 WZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "myViewDelegate.h"

/**
 *  代理回调
 */
@protocol CarduoAudioToolDelegate <NSObject>
-(void)carduoAudioSuccess;
-(void)carduoAudioFailed;
@end

@interface CarduoAudioTool : NSObject
@property (nonatomic ,weak) id<CarduoAudioToolDelegate> delegate;
@property (nonatomic ,assign) NSInteger maxTimes;//默认10次(不能低于两次)

+(void)setAppKey:(NSString *)appKey;
/**
 *  开门方法
 *
 *  @param deviceId 设别ID
 *  @param content  密码
 */
-(void)openTheDoorWithDeviceId:(NSString *)deviceId andContent:(NSString *)content;
/**
 *  停止发送
 */
-(void)stop;
@end
