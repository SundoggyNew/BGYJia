//
//  CarduoBluetooth.h
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <UIKit/UIKit.h>
#import "UARTPeripheral.h"
#import "BluetoothKey.h"

/**
 *  回调协议
 */
@protocol CarduoBluetoothToolDelegate<NSObject>
@required
-(void)carduoBluetoothToolDidSuccessfullyOpenWithMacAddress:(NSString *)macAddress;
/**
 *  失败回调
 *
 *  @param error   101 ： 未扫描到匹配外设   102 ： 未扫描到外设   103 ： 蓝牙不可用  104 ： SDK失效
 */
-(void)carduoBluetoothToolDidFailedWithError:(NSString *)error;


@end


@interface CarduoBluetooth : NSObject<UARTPeripheralDelegate,CBCentralManagerDelegate,CBPeripheralDelegate>


@property (nonatomic ,weak) id<CarduoBluetoothToolDelegate> delegate;


/*
 app key
 */
+(void)setupAppKey:(NSString *)appKey;


-(void)openTheDoorWithKeys:(NSArray<BluetoothKey *> *)keys;


@end