//
//  Data.m
//
//  Created by  周深发 on 16/3/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "User.h"

NSString *const kDataId = @"id";
NSString *const kDataState = @"state";
NSString *const kDataCellphone = @"cellphone";
NSString *const kDataMac = @"mac";
NSString *const kDataRealName = @"realName";
NSString *const kDataMoney = @"money";
NSString *const kDataIdcard = @"idcard";
NSString *const kDataUserHouseList = @"userHouseList";
NSString *const kDataIsMsgTip = @"isMsgTip";
NSString *const kDataBirthday = @"birthday";
NSString *const kDataAccessData = @"accessData";
NSString *const kDataUserImage = @"userImage";
NSString *const kDataRole = @"role";
NSString *const kDataScore = @"score";
NSString *const kDataJsessionid = @"jsessionid";

@interface User ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

static User * user;
@implementation User

@synthesize dataIdentifier = _dataIdentifier;
@synthesize state = _state;
@synthesize cellphone = _cellphone;
@synthesize mac = _mac;
@synthesize realName = _realName;
@synthesize money = _money;
@synthesize idcard = _idcard;
@synthesize userHouseList = _userHouseList;
@synthesize isMsgTip = _isMsgTip;
@synthesize birthday = _birthday;
@synthesize accessData = _accessData;
@synthesize userImage = _userImage;
@synthesize role = _role;
@synthesize score = _score;
@synthesize jsessionid = _jsessionid;


+(instancetype)runUser
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[User alloc] init];
        user.isMsgTip = YES;
    });
    
    user.haveData = NO;
    
    NSMutableArray* array = [User searchWithWhere:nil orderBy:nil offset:0 count:100];
    
    if (array.count != 0) {
        
        user = [array objectAtIndex:0];
        
        user.haveData = YES;
    }
    
    return user;
}

-(void)setUpWithDictionary:(NSDictionary *)dict
{
    if (!(self && [dict isKindOfClass:[NSDictionary class]])) {
        return;
    }
    
    self.jsessionid = [self objectOrNilForKey:kDataJsessionid fromDictionary:dict];
    
    NSDictionary * subDict = [dict objectForKey:@"data"];

    self.dataIdentifier = [[self objectOrNilForKey:kDataId fromDictionary:subDict] doubleValue];
    self.state          = [[self objectOrNilForKey:kDataState fromDictionary:subDict] doubleValue];
    self.cellphone      = [self objectOrNilForKey:kDataCellphone fromDictionary:subDict];
    self.mac            = [self objectOrNilForKey:kDataMac fromDictionary:subDict];
    self.realName       = [self objectOrNilForKey:kDataRealName fromDictionary:subDict];
    self.money          = [[self objectOrNilForKey:kDataMoney fromDictionary:subDict] doubleValue];
    self.idcard         = [self objectOrNilForKey:kDataIdcard fromDictionary:subDict];
    self.userHouseList  = [self objectOrNilForKey:kDataUserHouseList fromDictionary:subDict];
    self.isMsgTip       = [[self objectOrNilForKey:kDataIsMsgTip fromDictionary:subDict] doubleValue];
    self.birthday       = [self objectOrNilForKey:kDataBirthday fromDictionary:subDict];
    self.accessData     = [AccessData modelObjectWithDictionary:[subDict objectForKey:kDataAccessData]];
    self.userImage      = [self objectOrNilForKey:kDataUserImage fromDictionary:subDict];
    self.role           = [[self objectOrNilForKey:kDataRole fromDictionary:subDict] doubleValue];
    self.score          = [[self objectOrNilForKey:kDataScore fromDictionary:subDict] doubleValue];
    
    if (self.userImage.length > 0) {
        
        self.userImage = [API_HEAD stringByAppendingString:self.userImage];
        
    }
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataIdentifier] forKey:kDataId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kDataState];
    [mutableDict setValue:self.cellphone forKey:kDataCellphone];
    [mutableDict setValue:self.mac forKey:kDataMac];
    [mutableDict setValue:self.realName forKey:kDataRealName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.money] forKey:kDataMoney];
    [mutableDict setValue:self.idcard forKey:kDataIdcard];
    NSMutableArray *tempArrayForUserHouseList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.userHouseList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            [tempArrayForUserHouseList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            [tempArrayForUserHouseList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForUserHouseList] forKey:kDataUserHouseList];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isMsgTip] forKey:kDataIsMsgTip];
    [mutableDict setValue:self.birthday forKey:kDataBirthday];
    [mutableDict setValue:[self.accessData dictionaryRepresentation] forKey:kDataAccessData];
    [mutableDict setValue:self.userImage forKey:kDataUserImage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.role] forKey:kDataRole];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score] forKey:kDataScore];
    [mutableDict setValue:self.jsessionid forKey:kDataJsessionid];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


@end
