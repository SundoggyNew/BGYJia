//
//  User.h
//  BGYJia
//
//  Created by 全民尚网 on 16/3/9.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  用户单例类（请使用类构造方法构建单例使用）
 */
@interface User : NSObject

/** 用户ID */
@property (nonatomic, strong) NSString *dataIdentifier;

/** 生日 */
@property (nonatomic, strong) NSString *birthday;

/** 真实姓名 */
@property (nonatomic, strong) NSString * realName;

/** 手机号 */
@property (nonatomic, strong) NSString *cellphone;

/** 头像 */
@property (nonatomic, strong) NSString *userImage;

/** 账户余额 */
@property (nonatomic, assign) float money;

/** 账户积分 */
@property (nonatomic, assign) float score;

/** 身份证号 */
@property (nonatomic, strong) NSString *idcard;

/** 用户角色 */
@property (nonatomic, assign) NSInteger role;

/** MAC地址 */
@property (nonatomic, strong) NSString *mac;

/** 是否消息提醒 */
@property (nonatomic, assign) NSInteger isMsgTip;

/** 用户密码 */
@property (nonatomic, strong) NSString *password;

/** 接收消息 */
@property (nonatomic , assign) BOOL acceptNotification;

/** 登录时获取sessionid */
@property (nonatomic, strong) NSString *jsessionid;

/** 是否有数据 */
@property (nonatomic , assign , getter = isHaveData) BOOL haveData;




/**
 *  类构造方法
 *
 *  @return 本类对象
 */
+(instancetype)runUser;




/**
 *  清除数据
 */
-(void)clean;




-(void)setValueWithDictionary:(NSDictionary *)dictionary;




-(void)updateDataToDataBaseSuccess:(void(^)(NSString * message))successBlock Failure:(void(^)(NSError * error))failureBlock;

@end
