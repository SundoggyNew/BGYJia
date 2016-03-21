//
//  BluetoothKey.h
//

#import <Foundation/Foundation.h>

@interface BluetoothKey : NSObject

-(instancetype)initWithVillageID:(NSString *)villageID macAddress:(NSString *)macAddress bluetoothPWD:(NSString *)bluetoothPWD userCardPWD:(NSString *)usercardPWD;
/**
 *  小区ID
 */
@property (nonatomic ,copy) NSString *villageID;
/**
 *  mac地址
 */
@property (nonatomic ,copy) NSString *macAddress;
/**
 *  蓝牙密码
 */
@property (nonatomic ,copy) NSString *bluetoothPWD;
/**
 *  用户卡密码
 */
@property (nonatomic ,copy) NSString *userCardPWD;

@end
