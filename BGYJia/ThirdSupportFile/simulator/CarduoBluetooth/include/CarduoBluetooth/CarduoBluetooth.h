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
-(void)carduoBluetoothToolDidSuccessfullyOpen;
/**
 *  失败回调
 *
 *  @param error   101 ： 未扫描到匹配外设   102 ： 未扫描到外设   103 ： 蓝牙不可用  104 ： SDK失效
 */
-(void)carduoBluetoothToolDidFailedWithError:(NSString *)error;

@optional
/**
 *  连接到的是哪个外设
 *
 *  @param bluetoothKey 回调的钥匙模型
 */
-(void)carduoBluetoothToolDidConnectedWithBluetoothKey:(BluetoothKey *)bluetoothKey;

@end


@interface CarduoBluetooth : NSObject<UARTPeripheralDelegate,CBCentralManagerDelegate,CBPeripheralDelegate>


@property (nonatomic ,weak) id<CarduoBluetoothToolDelegate> delegate;


/*
 app key
 */
+(void)setupAppKey:(NSString *)appKey;


-(void)openTheDoorWithKeys:(NSArray<BluetoothKey *> *)keys;


@end