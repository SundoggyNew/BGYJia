//
//  BluetoothKey.h
//

#import <Foundation/Foundation.h>

@interface BluetoothKey : NSObject

-(instancetype)initWithmacAddress:(NSString *)macAddress bluetoothPWD:(NSString *)bluetoothPWD userCardPWD:(NSString *)usercardPWD;

@property (nonatomic ,copy) NSString *macAddress;
@property (nonatomic ,copy) NSString *bluetoothPWD;
@property (nonatomic ,copy) NSString *userCardPWD;

@end
