//
//  APIHeader.h
//  BGYJia
//
//  Created by 全民尚网 on 16/3/9.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#ifndef APIHeader_h
#define APIHeader_h
// 网段                                       http://cloud.shang-wifi.com  http://hboa.shang-wifi.com:8090/
#define API_HEAD                        @"http://hboa.shang-wifi.com:8090"

// 注册API
#define REGISTER_URL_STRING             [NSString stringWithFormat:@"%@%@",API_HEAD,@"/app_user/app/userRegister.do"]

// 登录API
#define LOGIN_URL_STRING                [NSString stringWithFormat:@"%@%@",API_HEAD,@"/app_user/app/userLogin.do"]

// 更改用户资料API
#define UPDATE_USER_INFO_URL_STRING     [NSString stringWithFormat:@"%@%@",API_HEAD,@"/app_user/app/updateUser.do"]

// 通过手机号码查询个人账户信息
#define CELLPHONE_FOR_INFO              [NSString stringWithFormat:@"%@%@",API_HEAD,@"/app_user/app/getUserInfo.do"]

// 修改密码API
#define CHANGE_PASSWORD_URL_STRING      [NSString stringWithFormat:@"%@%@",API_HEAD,@"/app_user/app/updatePassword.do"]

// 检测手机号是否存在接口
#define SEARCH_CELLPHONENUMBER          [NSString stringWithFormat:@"%@%@",API_HEAD,@"/app_user/app/checkCellphone.do"]

// 检测身份证号码是否存在
#define SEARCH_IDCARDNUMBER             [NSString stringWithFormat:@"%@%@",API_HEAD,@"/app_user/app/checkIdCard.do"]

// 解挂验证个人信息
#define VALIDATE_USER_INFO              [NSString stringWithFormat:@"%@%@",API_HEAD,@"/app_user/app/checkUnlockInfo.do"]

// 个人挂失
#define APPLY_LOSS                      [NSString stringWithFormat:@"%@%@",API_HEAD,@"/app_user/app/lossUser.do"]

// 解除挂失接口
#define REMOVE_LOSS                     [NSString stringWithFormat:@"%@%@",API_HEAD,@"/app_user/app/unlockUser.do"]

// 个人注销登录接口
#define LOGOUT_URL_STRING               [NSString stringWithFormat:@"%@%@",API_HEAD,@"/app_user/app/userLogout.do"]

// 更换手机号接口
#define CHANGE_CELLPHONE                [NSString stringWithFormat:@"%@%@",API_HEAD,@"/app_user/app/updateCellphone.do"]

// 发送短信
#define GET_UNREAD_MESSAGE_COOUNT       [NSString stringWithFormat:@"%@%@",API_HEAD,@"/sms/app/sendMsg.do"]

// 会员主界面
#define VIP_MAIN_API                    [NSString stringWithFormat:@"%@%@",API_HEAD,@"/common/mobile/member/phoneredirect.do"]

// 充值主界面
#define WALLET_MAIN_API                 [NSString stringWithFormat:@"%@%@",API_HEAD,@"/common/mobile/purse/phoneredirect.do"]

// 访客主界面
#define VISITOR_MAIN_API                [NSString stringWithFormat:@"%@%@",API_HEAD,@"/app_Visitor/app/getVisitorList.do"]

// 获取所有楼栋单元房
#define GET_ALL_HOUSE_INFO              [NSString stringWithFormat:@"%@%@",API_HEAD,@"/buildUnitRoom/app/getRoomList.do"]

// 获取个人房屋信息获取接口
#define GET_PERSONAL_HOUSE_INFO         [NSString stringWithFormat:@"%@%@",API_HEAD,@"/app_user/app/getUserHouseInfo.do"]

// 获取未读消息数量接口 - 会员
#define GET_UNREAD_INFO_NUMBER          [NSString stringWithFormat:@"%@%@",API_HEAD,@"/app_Message/app/getUnreadCount.do"]

// 头部消息链接地址
#define GET_USER_MESSAGE_API            [NSString stringWithFormat:@"%@%@",API_HEAD,@"/common/mobile/message/phoneredirect.do"]

// 头部历史链接地址
#define VISITOR_HISTORY_API             [NSString stringWithFormat:@"%@%@",API_HEAD,@"/common/mobile/visitorRecord/phoneredirect.do"]


#endif /* APIHeader_h */
