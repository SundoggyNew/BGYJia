//
//  User.m
//  BGYJia
//
//  Created by 全民尚网 on 16/3/9.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "User.h"
#import "AppDelegate.h"

@interface User ()

@property (nonatomic , strong) LKDBHelper * dbHelper;

@end

static User * user;
@implementation User

+(instancetype)runUser
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[User alloc] init];
        user.acceptNotification = YES;
    });
    
    user.haveData = NO;
    
    NSMutableArray* array = [User searchWithWhere:nil orderBy:nil offset:0 count:100];
    
    if (array.count != 0) {
        
        user = [array objectAtIndex:0];
        
        user.haveData = YES;
    }
    
    return user;
}

- (void)clean {
    self.dataIdentifier     = @"";
    self.birthday           = @"";
    self.realName           = @"";
    self.cellphone          = @"";
    self.userImage          = @"";
    self.money              = 0;
    self.score              = 0;
    self.idcard             = @"";
    self.role               = 2;
    self.mac                = @"";
    self.isMsgTip           = 2;
    self.password           = @"";
    self.acceptNotification = YES;
    self.jsessionid         = @"";
}

-(void)setValueWithDictionary:(NSDictionary *)dictionary
{
    self.dataIdentifier     = [dictionary valueForKey:@"id"];
    self.birthday           = [dictionary valueForKey:@"birthday"];
    self.realName           = [dictionary valueForKey:@"realName"];
    self.cellphone          = [dictionary valueForKey:@"cellphone"];

    self.userImage          = [dictionary valueForKey:@"userImage"];
    
    if (self.userImage.length > 0) {
        
        self.userImage = [API_HEAD stringByAppendingString:user.userImage];
        
    }
    
    self.money              = [[dictionary valueForKey:@"money"] floatValue];
    self.score              = [[dictionary valueForKey:@"score"] floatValue];
    self.idcard             = [dictionary valueForKey:@"idcard"];
    self.role               = [[dictionary valueForKey:@"role"] integerValue];
    self.mac                = [dictionary valueForKey:@"mac"];
    self.isMsgTip           = [[dictionary valueForKey:@"isMsgTip"] integerValue];
    self.password           = [dictionary valueForKey:@"password"];
}

-(void)updateDataToDataBaseSuccess:(void (^)(NSString *))successBlock Failure:(void (^)(NSError *))failureBlock
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setValue:self.cellphone forKey:@"cellphone"];
    [dic setValue:self.birthday forKey:@"birthday"];
    [dic setValue:self.realName forKey:@"username"];
    [dic setValue:self.idcard forKey:@"idcard"];
    [dic setValue:self.mac forKey:@"mac"];
    
    @weakify(self);
    [manager POST:UPDATE_USER_INFO_URL_STRING
       parameters:dic
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              @strongify(self);
              
              NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
              
              NSString * message = [NSString string];
              
              if ([[dic objectForKey:@"errorcode"] integerValue] == 0) {
                  message = @"更新成功";
              }else if ([[dic objectForKey:@"errorcode"] integerValue] == 1) {
                  message = @"没有传入任何参数";
              }else if ([[dic objectForKey:@"errorcode"] integerValue] == 2) {
                  message = @"服务器异常，修改失败";
              }else if ([[dic objectForKey:@"errorcode"] integerValue] == 3) {
                  message = @"该手机号未注册过，请先注册";
              }
              
              successBlock(message);
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              @strongify(self);
              
              failureBlock(error);
              
          }];
}

#pragma mark - private methods

+(NSString *)getTableName
{
    return NSStringFromClass([self class]);
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

-(id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}



-(NSString *)description
{
    return [NSString stringWithFormat:@"\n name : %@ \ncellPhone:%@ \n password : %@",self.realName,self.cellphone,self.password];
}

@end
