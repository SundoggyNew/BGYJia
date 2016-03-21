//
//  JCNetWorking.m
//  TestDemo
//
//  Created by JohnsonChou on 16/2/16.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//
#import "JCNetWorking.h"
#import <CommonCrypto/CommonDigest.h>
#import "BGYChoseModel.h"

@interface JCNetWorking ()

@end

static JCNetWorking * netWorking;
@implementation JCNetWorking

+(instancetype)runNetWorking
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorking = [JCNetWorking new];
    });
    
    return netWorking;
}

#pragma mark - public method

///**
// *  积分充值类型接口
// */
//-(void)getIntegralTypeDataSuccess:(VDBlock)successBlock
//                        orFailure:(VEBlock)errorBlock
//{
//    [self jcGetDataWithUrl:INTEGRAL_TYPE_API parameters:nil Success:^(NSDictionary *dictionary) {
//        
//        if (successBlock) {
//            successBlock(dictionary);
//        }
//        
//    } orFailure:^(NSError *error) {
//        
//        if (errorBlock) {
//            errorBlock(error);
//        }
//        
//    }];
//    
//    
//}
//
///**
// *  躲避官方审查接口
// */
//-(void)hiddenUINetworkingBefore:(VVBlock)beforeBlock
//                        success:(VBBlock)successBlock
//                        failure:(VEBlock)errorBlock
//{
//    if (beforeBlock) {
//        beforeBlock();
//    }
//    
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    
//    [dic setValue:VERSION forKey:@"version"];
//    
//    [self jcGetDataWithUrl:HIDDEN_OR_NOT_API parameters:dic Success:^(NSDictionary *dictionary) {
//        
//        BOOL state = [[dictionary objectForKey:@"state"] boolValue];
//        
//        if (successBlock) {
//            successBlock(state);
//        }
//        
//    } orFailure:^(NSError *error) {
//        
//        if (errorBlock) {
//            errorBlock(error);
//        }
//        
//    }];
//}
//
/**
 *  检测手机号是否存在
 */
-(void)searchCellphoneExist:(NSString *)cellphone
                    Success:(VDBlock)successBlock
                  orFailure:(VEBlock)errorBlock
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setValue:cellphone forKey:@"cellphone"];
    
    [self jcGetDataWithUrl:SEARCH_CELLPHONENUMBER parameters:dic sessionConnection:NO Success:^(NSDictionary *dictionary) {
        
        if (successBlock) {
            successBlock(dictionary);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
}

/**
 *  检测身份证号码是否存在
 */
-(void)searchIDCardExist:(NSString *)idcard
                 Success:(VDBlock)successBlock
               orFailure:(VEBlock)errorBlock {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:idcard forKey:@"idcard"];
    
    [self jcGetDataWithUrl:SEARCH_IDCARDNUMBER parameters:dic sessionConnection:NO Success:^(NSDictionary *dictionary) {
        
        if (successBlock) {
            successBlock(dictionary);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
}

/**
 *  登录
 */
-(void)loginWithAccount:(NSString *)account
               passWord:(NSString *)password
            loginMethod:(NSInteger)loginMethod
                success:(VDBlock)successBlock
              orFailure:(VEBlock)errorBlock
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setValue:account forKey:@"cellphone"];
    [dic setValue:password forKey:@"password"];
    [dic setValue:@(1) forKey:@"terminalType"];
    [dic setValue:@(loginMethod) forKey:@"loginMethod"];
    
    @weakify(self);
    [self jcGetDataWithUrl:LOGIN_URL_STRING parameters:dic sessionConnection:NO Success:^(NSDictionary *dictionary) {
        @strongify(self);
        
         if ([[dictionary objectForKey:@"errorcode"] integerValue] == 0) {
             
             [JPUSHService setTags:nil alias:account fetchCompletionHandle:nil];
             
         }
        
        if (successBlock) {
            successBlock(dictionary);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
    
}

/**
 *  由手机号码查询个人账户信息
 */
-(void)searchInfoSuccess:(VUBlock)successBlock
               orFailure:(VEBlock)errorBlock
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    User * user = [User runUser];
    
    [dic setValue:user.cellphone forKey:@"cellphone"];
    
    [self jcGetDataWithUrl:CELLPHONE_FOR_INFO parameters:dic sessionConnection:YES Success:^(NSDictionary *dictionary) {
        
        User * user = [User runUser];
        
        [user setValuesForKeysWithDictionary:[dictionary objectForKey:@"data"]];
        
        [user updateToDB];
        
        if (successBlock) {
            successBlock(user);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
}

/**
 *  注册provinceId
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
                   orFailure:(VEBlock)errorBlock
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setValue:cellphone forKey:@"cellphone"];
    [dic setValue:password forKey:@"password"];
    [dic setValue:@(role) forKey:@"role"];
    [dic setValue:idcard forKey:@"idcard"];
    [dic setValue:realName forKey:@"realName"];
    [dic setValue:provinceId forKey:@"provinceId"];
    [dic setValue:villageId forKey:@"villageId"];
    [dic setValue:buildId forKey:@"buildId"];
    [dic setValue:buildUnitId forKey:@"unitId"];
    
    [self jcGetDataWithUrl:REGISTER_URL_STRING parameters:dic sessionConnection:NO Success:^(NSDictionary *dictionary) {
        
        if (successBlock) {
            successBlock(dictionary);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
}

/**
 *  重设密码
 */
-(void)resetPasswordWithCellphone:(NSString *)cellphone
                         passWord:(NSString *)password
                          success:(VDBlock)successBlock
                        orFailure:(VEBlock)errorBlock
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setValue:cellphone forKey:@"cellphone"];
    [dic setValue:password forKey:@"password"];
    
    [self jcGetDataWithUrl:CHANGE_PASSWORD_URL_STRING parameters:dic sessionConnection:NO Success:^(NSDictionary *dictionary) {
        
        if (successBlock) {
            successBlock(dictionary);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
}

/**
 *  个人挂失
 */
-(void)reportOfTheLossOfCellphone:(NSString *)cellphone
                          success:(VNBlock)successBlock
                        orFailure:(VEBlock)errorBlock {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:cellphone forKey:@"cellphone"];
    
    [self jcGetDataWithUrl:APPLY_LOSS parameters:dic sessionConnection:NO Success:^(NSDictionary *dictionary) {
        
        if (successBlock) {
            successBlock([[dictionary objectForKey:@"errorcode"] integerValue]);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
}

/**
 *  解挂验证个人信息
 */
-(void)searchUserInfoWithCellphone:(NSString *)cellphone
                          realname:(NSString *)realname
                            idCard:(NSString *)idCardCode
                           success:(VNBlock)successBlock
                         orFailure:(VEBlock)errorBlock
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:cellphone forKey:@"cellphone"];
    [dic setValue:realname  forKey:@"realName"];
    [dic setValue:idCardCode forKey:@"idcard"];
    
    [self jcGetDataWithUrl:VALIDATE_USER_INFO parameters:dic sessionConnection:NO Success:^(NSDictionary *dictionary) {
        
        if (successBlock) {
            successBlock([[dictionary objectForKey:@"errorcode"] integerValue]);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
}

/**
 *  解除挂失接口
 */
-(void)removeLossWithCellphone:(NSString *)cellphone
                      password:(NSString *)password
                        idCard:(NSString *)idCardCode
                       success:(VNBlock)successBlock
                     orFailure:(VEBlock)errorBlock
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:cellphone forKey:@"cellphone"];
    [dic setValue:idCardCode forKey:@"idcard"];
    [dic setValue:password forKey:@"password"];
    
    
    [self jcGetDataWithUrl:REMOVE_LOSS parameters:dic sessionConnection:NO Success:^(NSDictionary *dictionary) {
        
        if (successBlock) {
            successBlock([[dictionary objectForKey:@"errorcode"] integerValue]);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
}

/**
 *  个人注销登录接口
 */
-(void)logoutWithsuccess:(VDBlock)successBlock
               orFailure:(VEBlock)errorBlock
{
    
    [self jcGetDataWithUrl:LOGOUT_URL_STRING parameters:nil sessionConnection:YES Success:^(NSDictionary *dictionary) {
        
        if (successBlock) {
            successBlock(dictionary);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
}

/**
 *  获取所有楼栋单元房
 */
-(void)getAllHouseInfoWithAreaType:(NSString *)areaType
                          parentId:(NSInteger)parentId
                           success:(VABlock)successBlock
                         orFailure:(VEBlock)errorBlock
{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:areaType forKey:@"areaType"];
    [dic setValue:@(parentId) forKey:@"parentId"];
    
    [self jcGetDataWithUrl:GET_ALL_HOUSE_INFO parameters:dic sessionConnection:NO Success:^(NSDictionary *dictionary) {
        
        NSArray * data = [NSArray array];
        
        if ([[dictionary objectForKey:@"errorcode"] integerValue] == 0) {
            
            NSMutableArray * dataArray = [NSMutableArray array];
            
            NSArray * arr = [dictionary objectForKey:@"data"];
            
            for (NSInteger index = 0; index < arr.count; index++) {
                
                BGYChoseModel * model = [BGYChoseModel new];
                model.name = [[arr objectAtIndex:index] objectForKey:@"name"];
                model.theId = [[[arr objectAtIndex:index] objectForKey:@"id"] doubleValue];
                
                [dataArray addObject:model];
                
            }
            
            data = [NSArray arrayWithArray:dataArray];
            
        }

        
        if (successBlock) {
            successBlock(data);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
    
}

/**
 *  获取个人房屋信息
 */
-(void)getPersonalHouseInfoWithCellphone:(NSString *)cellphone
                                  idcard:(NSString *)idcard
                                 success:(VDBlock)successBlock
                               orFailure:(VEBlock)errorBlock {
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:cellphone forKey:@"cellphone"];
    [dic setValue:idcard forKey:@"idcard"];
    
    
    [self jcGetDataWithUrl:GET_PERSONAL_HOUSE_INFO parameters:dic sessionConnection:NO Success:^(NSDictionary *dictionary) {
        
        if (successBlock) {
            successBlock(dictionary);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
    
}

/**
 *  获取未读消息数量接口
 */
-(void)getUnreadMessageWithsuccess:(VDBlock)successBlock
                         orFailure:(VEBlock)errorBlock {
    
    [self jcGetDataWithUrl:GET_UNREAD_INFO_NUMBER parameters:nil sessionConnection:YES Success:^(NSDictionary *dictionary) {
        
        if (successBlock) {
            successBlock(dictionary);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
    
}

/**
 *  更改头像
 */
-(void)updateHeadImageWithHeadImage:(UIImage *)image
                            success:(VDBlock)successBlock
                          orFailure:(VEBlock)errorBlock
{
    image = [self imageWithImage:image scaledToSize:CGSizeMake(200, 200)];
    
    NSData * data = UIImageJPEGRepresentation(image,1);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    User * user = [User runUser];
    
    [dic setValue:user.cellphone forKey:@"cellphone"];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:UPDATE_USER_INFO_URL_STRING
       parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
           
           [formData appendPartWithFileData:data name:@"sourceFileImage" fileName:[NSString stringWithFormat:@"%@.png",[User runUser].cellphone] mimeType:@"image/png"];
           
       } success:^(AFHTTPRequestOperation *operation, id responseObject) {
           
           NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
           
           User * user = [User runUser];
           
           user.userImage = [[dic objectForKey:@"data"] objectForKey:@"userImage"];
           
           if (user.userImage.length > 0) {
               
               user.userImage = [API_HEAD stringByAppendingString:user.userImage];
               
           }
           
           [user updateToDB];
           
           if (successBlock) {
               successBlock(dic);
           }
           
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
           if (errorBlock) {
               errorBlock(error);
           }
           
       }];

}

/**
 *  更改用户个人信息（姓名、年龄、性别）
 */
-(void)changeUserInfoWithKey:(NSString *)key
                       value:(id)value
                     success:(VDBlock)successBlock
                   orFailure:(VEBlock)errorBlock
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    User * user = [User runUser];
    
    [dic setValue:value forKey:key];
    [dic setValue:user.cellphone forKey:@"cellphone"];
    
    [self jcGetDataWithUrl:UPDATE_USER_INFO_URL_STRING parameters:dic sessionConnection:YES Success:^(NSDictionary *dictionary) {
        
        if ([[dictionary objectForKey:@"errorcode"] integerValue] == 0) {
            
            User * user = [User runUser];
            
            [user setUpWithDictionary:dictionary];
            
            [user updateToDB];
            
        }
        
        if (successBlock) {
            successBlock(dictionary);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
}

/**
 *  更换手机号
 */
-(void)changeCellphoneWithNewNumber:(NSString *)cellphone
                         idCardCode:(NSString *)idCardCode
                            success:(VSBlock)successBlock
                          orFailure:(VEBlock)errorBlock
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setValue:cellphone forKey:@"cellphone"];
    [dic setValue:idCardCode forKey:@"idcard"];
    
    [self jcGetDataWithUrl:CHANGE_CELLPHONE parameters:dic sessionConnection:YES Success:^(NSDictionary *dictionary) {
        
        if ([[dictionary objectForKey:@"errorcode"] integerValue] == 0) {
            
            User * user = [User runUser];
            
            [user setUpWithDictionary:dictionary];
            
            [user updateToDB];
            
        }
        
        if (successBlock) {
            successBlock([dictionary objectForKey:@"errormsg"]);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
}

///**
// *  消息接口
// */
//-(void)getMessageInfoWithLastMessageId:(NSString *)lastMessageId
//                                typeId:(NSString *)messageTypeId
//                               success:(VDBlock)successBlock
//                             orFailure:(VEBlock)errorBlock
//{
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    
//    [dic setValue:lastMessageId forKey:@"lastNotificationId"];
//    [dic setValue:messageTypeId forKey:@"type"];
//    
//    [self jcGetDataWithUrl:MESSAGE_INFO_API_URL parameters:dic Success:^(NSDictionary *dictionary) {
//        
//        if (successBlock) {
//            successBlock(dictionary);
//        }
//        
//    } orFailure:^(NSError *error) {
//        
//        if (errorBlock) {
//            errorBlock(error);
//        }
//        
//    }];
//}
//
///**
// *  获取广告数据接口
// */
//-(void)getAdvertisementWithUrlString:(NSString *)urlString
//                               param:(NSDictionary *)param
//                             Success:(VDBlock)successBlock
//                           orFailure:(VEBlock)errorBlock
//{
//    [self jcGetDataWithUrl:urlString parameters:param Success:^(NSDictionary *dictionary) {
//        
//        if (successBlock) {
//            successBlock(dictionary);
//        }
//        
//    } orFailure:^(NSError *error) {
//        
//        if (errorBlock) {
//            errorBlock(error);
//        }
//        
//    }];
//}
//
///**
// *  获取资源列表
// */
//-(void)getResourcesDataSuccess:(VDBlock)successBlock
//                     orFailure:(VEBlock)errorBlock
//{
//    
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    User * user = [User runUser];
//    
//    [dic setValue:user.cellphone forKey:@"cellphone"];
//    [dic setValue:user.gwid forKey:@"gwid"];
//    
//    [self jcGetDataWithUrl:RESOURCES_LIST_API parameters:dic Success:^(NSDictionary *dictionary) {
//        
//        if (successBlock) {
//            successBlock(dictionary);
//        }
//        
//    } orFailure:^(NSError *error) {
//        
//        if (errorBlock) {
//            errorBlock(error);
//        }
//        
//    }];
//}
//
///**
// *  获取开通套餐类型接口
// */
//-(void)getPackageTypeSuccess:(VDBlock)successBlock
//                   orFailure:(VEBlock)errorBlock
//{
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    User * user = [User runUser];
//    
//    [dic setValue:user.gwid forKey:@"gwid"];
//    
//    [self jcGetDataWithUrl:PACKAGE_TYPE_API parameters:dic Success:^(NSDictionary *dictionary) {
//        
//        if (successBlock) {
//            successBlock(dictionary);
//        }
//        
//    } orFailure:^(NSError *error) {
//        
//        if (errorBlock) {
//            errorBlock(error);
//        }
//        
//    }];
//}
//
///**
// *  获取积分充值记录
// */
//-(void)getRechargeRecordDataWithPageSize:(NSInteger)pageSize
//                               pageIndex:(NSInteger)pageIndex
//                                 success:(VDBlock)successBlock
//                               orFailure:(VEBlock)errorBlock
//{
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    User * user = [User runUser];
//    
//    [dic setValue:user.cellphone forKey:@"cellphone"];
//    [dic setValue:@(pageSize) forKey:@"pageSize"];
//    [dic setValue:@(pageIndex) forKey:@"pageIndex"];
//    
//    [self jcGetDataWithUrl:INTEGRAL_LIST_API parameters:dic Success:^(NSDictionary *dictionary) {
//        
//        if (successBlock) {
//            successBlock(dictionary);
//        }
//        
//    } orFailure:^(NSError *error) {
//        
//        if (errorBlock) {
//            errorBlock(error);
//        }
//        
//    }];
//}
//
///**
// *  获取用户开通过的套餐
// */
//-(void)getUserOpenPackageListSuccess:(VDBlock)successBlock
//                           orFailure:(VEBlock)errorBlock
//{
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    User * user = [User runUser];
//    
//    [dic setValue:user.cellphone forKey:@"cellphone"];
//    
//    [self jcGetDataWithUrl:USER_HAD_OPEN_PACKAGE_API parameters:dic Success:^(NSDictionary *dictionary) {
//        
//        if (successBlock) {
//            successBlock(dictionary);
//        }
//        
//    } orFailure:^(NSError *error) {
//        
//        if (errorBlock) {
//            errorBlock(error);
//        }
//        
//    }];
//}
//
///**
// *  开通套餐接口
// */
//-(void)openPackageWithPackageId:(NSInteger)packageId
//                        success:(VDBlock)successBlock
//                      orFailure:(VEBlock)errorBlock
//{
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    User * user = [User runUser];
//    
//    [dic setValue:user.cellphone forKey:@"cellphone"];
//    [dic setValue:@(packageId) forKey:@"packagenameid"];
//
//    [self jcGetDataWithUrl:USER_OPEN_PACKAGE_API parameters:dic Success:^(NSDictionary *dictionary) {
//        
//        if (successBlock) {
//            successBlock(dictionary);
//        }
//        
//    } orFailure:^(NSError *error) {
//        
//        if (errorBlock) {
//            errorBlock(error);
//        }
//        
//    }];
//
//}
//
///**
// *  积分充值接口
// */
//-(void)integralRechargeWithWay:(NSInteger)way
//                  chargetypeId:(NSInteger)chargetypeid
//                rechargePoints:(NSInteger)rechargepoints
//                         money:(CGFloat)money
//                       success:(VDBlock)successBlock
//                     orFailure:(VEBlock)errorBlock
//{
//    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
//    
//    User * user = [User runUser];
//    
//    NSString * theString = [NSString stringWithFormat:@"%@%@%@",@"lyl",user.cellphone,dateString];
//    
//    NSString * privateString = [self md5:theString];
//    
//    [manager.requestSerializer setValue:user.cellphone forHTTPHeaderField:@"X-QMSW-Site"];
//    [manager.requestSerializer setValue:dateString forHTTPHeaderField:@"X-QMSW-Timestamp"];
//    [manager.requestSerializer setValue:privateString forHTTPHeaderField:@"X-QMSW-Sign"];
//    
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    
//    [dic setValue:user.cellphone forKey:@"cellphone"];
//    [dic setValue:@(chargetypeid) forKey:@"chargetypeid"];
//    [dic setValue:@(rechargepoints) forKey:@"rechargepoints"];
//    [dic setValue:@(money) forKey:@"money"];
//    [dic setValue:@(1) forKey:@"terminaltype"];
//    [dic setValue:@(way) forKey:@"paytype"];
//    [dic setValue:@"" forKey:@"ip"];
//    [dic setValue:@"" forKey:@"macaddress"];
//    [dic setValue:@"" forKey:@"serialnumber"];
//    
//    [manager POST:INTEGRAL_UP_POST_API
//       parameters:dic
//          success:^(AFHTTPRequestOperation *operation, id responseObject) {
//              
//              NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//              
//              if (successBlock) {
//                  successBlock(dic);
//              }
//              
//          }
//          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              
//              if (errorBlock) {
//                  errorBlock(error);
//              }
//              
//          }];
//}
//
///**
// *  验证码上传服务器接口
// */
//-(void)validationCodePush:(NSInteger)useScenesType
//                cellphone:(NSString *)cellphone
//           validationCode:(NSInteger)code
//                  success:(VDBlock)successBlock
//                orFailure:(VEBlock)errorBlock
//{
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    
////    [dic setValue:cellphone forKey:@"cellphone"];
////    [dic setValue:@(code) forKey:@"code"];
////    [dic setValue:@(1) forKey:@"terminalType"];
////    [dic setValue:@(useScenesType) forKey:@"useScenesType"];
//    
//    [self jcGetDataWithUrl:VALIDATIONCODE_API parameters:dic sessionConnection:NO Success:^(NSDictionary *dictionary) {
//        
//        if (successBlock) {
//            successBlock(dictionary);
//        }
//        
//    } orFailure:^(NSError *error) {
//        
//        if (errorBlock) {
//            errorBlock(error);
//        }
//        
//    }];
//}

/**
 *  发送短信
 */
-(void)sendMessageWithCellphone:(NSString *)cellphone
                           Type:(SendMessageType)type
                        success:(VDSBlock)successBlock
                      orFailure:(VEBlock)errorBlock
{
    NSInteger validationCode = (arc4random()%8999)+1000;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:cellphone forKey:@"cellphone"];
    [dic setValue:@(type) forKey:@"msgType"];
    [dic setValue:@(validationCode) forKey:@"verifyCode"];
    
    [self jcGetDataWithUrl:GET_UNREAD_MESSAGE_COOUNT parameters:dic sessionConnection:YES Success:^(NSDictionary *dictionary) {
        
        NSInteger errorcode = [[dictionary objectForKey:@"errorcode"] integerValue];
        
        NSString * message  = [NSString string];
        
        if (errorcode == 0) {
            
            message = @"发送成功";
            
        }else if (errorcode == -1) {
            
            message = @"发送失败，后台服务器异常";
            
        }else if (errorcode > 0) {
            
            message = @"发送失败，短信服务器异常";
            
        }
        
        if (successBlock) {
            successBlock(message,validationCode);
        }
        
    } orFailure:^(NSError *error) {
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }];
}

///**
// *  发送验证码
// */
//-(void)sendValidationCodeWithCellphone:(NSString *)cellphone
//                         useScenesType:(NSInteger)useScenesType
//                               success:(VDNBlock)successBlock
//                             orFailure:(VEBlock)errorBlock
//{
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    
//    NSInteger validationCode = (arc4random()%8999)+1000;
//    
//    NSString * message = [NSString string];
//    
//    switch (useScenesType) {
//        case 1:
//        {
//            message = [NSString stringWithFormat:@"您正在注册理想家APP，本次验证码为%ld，谢谢支持！",validationCode];
//        }
//            break;
//        case 2:
//        {
//            message = [NSString stringWithFormat:@"您正在找回密码，本次验证码为%ld，谢谢支持！",validationCode];
//        }
//            break;
//        case 3:
//        {
//            message = [NSString stringWithFormat:@"您正在解除挂失，本次验证码为%ld，谢谢支持！",validationCode];
//        }
//            break;
//        case 4:
//        {
//            message = [NSString stringWithFormat:@"您正在更换绑定手机，本次验证码为%ld，谢谢支持！",validationCode];
//        }
//            break;
//            
//        default:
//        {
//            message = [NSString stringWithFormat:@"您正在重置登录密码，本次验证码为%ld，谢谢支持！",validationCode];
//        }
//            break;
//    }
//    
//    [self validationCodePush:useScenesType
//                   cellphone:cellphone
//              validationCode:validationCode
//                     success:^(NSDictionary *dictionary) {
//        
//                         NSLog(@"验证码上传成功");
//                     
//                     } orFailure:^(NSError *error) {
//                         
//                         NSLog(@"验证码上传失败");
//                         
//                     }];
//    
////    [dic setValue:@"13826592087" forKey:@"name"];
////    [dic setValue:@"9d682736-6shb-4948-9ge9-ee6abb3656a5" forKey:@"pwd"];
////    [dic setValue:cellphone forKey:@"tel"];
////    [dic setValue:message forKey:@"content"];
////    [dic setValue:@"【全民尚网】" forKey:@"sign"];
////    [dic setValue:@"" forKey:@"send_time"];
////    [dic setValue:@"json" forKey:@"type"];
////    [dic setValue:@"api" forKey:@"from"];
//    
//    [self jcGetDataWithUrl:MESSAGE_API_URL parameters:dic sessionConnection:NO Success:^(NSDictionary *dictionary) {
//        
//        if (successBlock) {
//            successBlock(dictionary , validationCode);
//        }
//        
//    } orFailure:^(NSError *error) {
//        
//        if (errorBlock) {
//            errorBlock(error);
//        }
//        
//    }];
//}

///**
// *  踢人下线功能
// */
//-(void)makeAccountOnlySuccess:(VDBlock)successBlock
//                    orFailure:(VEBlock)errorBlock
//{
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    
//    User * user = [User runUser];
//    
//    [dic setValue:user.gwid forKey:@"gwid"];
//    [dic setValue:user.mac forKey:@"mac"];
//
//    [self jcGetDataWithUrl:MAKE_ONE_ONLINE_API parameters:dic Success:^(NSDictionary *dictionary) {
//        
//        if (successBlock) {
//            successBlock(dictionary);
//        }
//        
//    } orFailure:^(NSError *error) {
//        
//        if (errorBlock) {
//            errorBlock(error);
//        }
//        
//    }];
//}




#pragma mark - private method
/**
 *  网络启动器方法
 */
-(void)jcGetDataWithUrl:(NSString *)urlString
             parameters:(id)parameters
      sessionConnection:(BOOL)sessiconConnection
                Success:(VDBlock)successBlock
              orFailure:(VEBlock)errorBlock
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if (sessiconConnection) {
        
        User *user = [User runUser];
        
        [manager.requestSerializer setValue:user.jsessionid forHTTPHeaderField:@"JSESSIONID"];
        
    }
    
    [manager POST:urlString
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
              
              if (successBlock) {
                  successBlock(dic);
              }
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              if (errorBlock) {
                  errorBlock(error);
              }
              
          }];
}

/**
 *  对图片尺寸进行压缩
 */
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  md5加密
 */
-(NSString *)md5:(NSString *)inPutText
{
    const char *myPasswd = [inPutText UTF8String];
    
    unsigned char mdc[ 16 ];
    
    CC_MD5 (myPasswd, ( CC_LONG ) strlen (myPasswd), mdc);
    
    NSMutableString *md5String = [ NSMutableString string ];
    
    for ( int i = 0 ; i< 16 ; i++) {
        
        [md5String appendFormat : @"%02x" ,mdc[i]];
        
    }
    
    return md5String;
}

@end
