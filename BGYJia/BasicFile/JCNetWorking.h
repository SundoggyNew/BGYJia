//
//  JCNetWorking.h
//  TestDemo
//
//  Created by JohnsonChou on 16/2/16.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,SendMessageType) {
    /*
     0:其他；1：注册；2：忘记密码；3:解除挂失；
     */
    SendMessageTypeOther = 0,
    SendMessageTypeRegister,
    SendMessageTypeForgotPassword,
    SendMessageTypeRemoveLoss,
};

/**
 *  网络启动器
 */
@interface JCNetWorking : NSObject




/**
 *  便利构造器
 */
+(instancetype)runNetWorking;




#pragma mark - 注册、登录、更改密码、解挂、注销登录
/**
 *  检测手机号是否存在
 */
-(void)searchCellphoneExist:(NSString *)cellphone
                    Success:(VDBlock)successBlock
                  orFailure:(VEBlock)errorBlock;




/**
 *  检测身份证号码是否存在
 */
-(void)searchIDCardExist:(NSString *)idcard
                 Success:(VDBlock)successBlock
               orFailure:(VEBlock)errorBlock;




/**
 *  登录
 */
-(void)loginWithAccount:(NSString *)account
               passWord:(NSString *)password
            loginMethod:(NSInteger)loginMethod
                success:(VDBlock)successBlock
              orFailure:(VEBlock)errorBlock;




/**
 *  注册
 */
-(void)registerWithCellphone:(NSString *)cellphone
                    passWord:(NSString *)password
                        role:(NSInteger)role
                      idcard:(NSString *)idcard
                    realName:(NSString *)realName
                  provinceId:(NSString *)provinceId
                   villageId:(NSString *)villageId
                     buildId:(NSString *)buildId
                 buildUnitId:(NSString *)buildUnitId
                     success:(VDBlock)successBlock
                   orFailure:(VEBlock)errorBlock;




/**
 *  重设密码
 */
-(void)resetPasswordWithCellphone:(NSString *)cellphone
                         passWord:(NSString *)password
                          success:(VDBlock)successBlock
                        orFailure:(VEBlock)errorBlock;



/**
 *  由手机号码查询个人账户信息
 */
-(void)searchInfoSuccess:(VUBlock)successBlock
               orFailure:(VEBlock)errorBlock;




/**
 *  个人挂失
 */
-(void)reportOfTheLossOfCellphone:(NSString *)cellphone
                          success:(VNBlock)successBlock
                        orFailure:(VEBlock)errorBlock;





/**
 *  解挂验证个人信息
 */
-(void)searchUserInfoWithCellphone:(NSString *)cellphone
                          realname:(NSString *)realname
                            idCard:(NSString *)idCardCode
                           success:(VNBlock)successBlock
                         orFailure:(VEBlock)errorBlock;




/**
 *  解除挂失接口
 */
-(void)removeLossWithCellphone:(NSString *)cellphone
                      password:(NSString *)password
                        idCard:(NSString *)idCardCode
                       success:(VNBlock)successBlock
                     orFailure:(VEBlock)errorBlock;




/**
 *  个人注销登录接口
 */
-(void)logoutWithsuccess:(VDBlock)successBlock
               orFailure:(VEBlock)errorBlock;




/**
 *  获取所有楼栋单元房
 */
-(void)getAllHouseInfoWithAreaType:(NSString *)areaType
                          parentId:(NSInteger)parentId
                           success:(VABlock)successBlock
                         orFailure:(VEBlock)errorBlock;




/**
 *  获取个人房屋信息
 */
-(void)getPersonalHouseInfoWithCellphone:(NSString *)cellphone
                                  idcard:(NSString *)idcard
                                 success:(VDBlock)successBlock
                               orFailure:(VEBlock)errorBlock;




#pragma mark - 个人信息更改相关
/**
 *  更改头像
 */
-(void)updateHeadImageWithHeadImage:(UIImage *)image
                            success:(VDBlock)successBlock
                          orFailure:(VEBlock)errorBlock;





/**
 *  更改用户个人信息（姓名、年龄、性别）
 */
-(void)changeUserInfoWithKey:(NSString *)key
                       value:(id)value
                     success:(VDBlock)successBlock
                   orFailure:(VEBlock)errorBlock;





/**
 *  更换手机号
 */
-(void)changeCellphoneWithNewNumber:(NSString *)cellphone
                         idCardCode:(NSString *)idCardCode
                            success:(VSBlock)successBlock
                          orFailure:(VEBlock)errorBlock;

/**
 *  发送短信
 */
-(void)sendMessageWithCellphone:(NSString *)cellphone
                           Type:(SendMessageType)type
                        success:(VDSBlock)successBlock
                      orFailure:(VEBlock)errorBlock;


/**
 *  获取未读消息数量接口
 */
-(void)getUnreadMessageWithsuccess:(VDBlock)successBlock
                         orFailure:(VEBlock)errorBlock;




@end