//
//  Data.h
//
//  Created by  周深发 on 16/3/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccessData.h"

@interface User : NSObject <NSCoding, NSCopying>

/** 用户ID */
@property (nonatomic, assign) double dataIdentifier;

/** 账户状态 */
@property (nonatomic, assign) double state;

/** 手机号 */
@property (nonatomic, strong) NSString *cellphone;

/** MAC地址 */
@property (nonatomic, strong) NSString *mac;

/** 真实姓名 */
@property (nonatomic, strong) NSString *realName;

/** 账户余额 */
@property (nonatomic, assign) double money;

/** 身份证号 */
@property (nonatomic, strong) NSString *idcard;

/** 用户住房集合 */
@property (nonatomic, strong) NSArray *userHouseList;

/** 是否消息提醒 */
@property (nonatomic, assign) double isMsgTip;

/** 生日 */
@property (nonatomic, strong) NSString *birthday;

/** 用户门禁数据 */
@property (nonatomic, strong) AccessData *accessData;

/** 头像 */
@property (nonatomic, strong) NSString *userImage;

/** 用户角色 */
@property (nonatomic, assign) double role;

/** 账户积分 */
@property (nonatomic, assign) double score;

/** jsessionid */
@property (nonatomic, strong) NSString *jsessionid;

/** 密码 */
@property (nonatomic , strong) NSString * password;



/** 是否有数据 */
@property (nonatomic , assign , getter = isHaveData) BOOL haveData;


/**
 *  类构造方法
 *
 *  @return 本类对象
 */
+(instancetype)runUser;




-(void)setUpWithDictionary:(NSDictionary *)dict;



@end
