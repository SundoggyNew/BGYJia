//
//  BGYBasicTableViewCell.h
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UITableViewCell基类
 */
@interface BGYBasicTableViewCell : UITableViewCell

/**
 *  通过 BasicTableViewCell 的子类调用该方法，获取子类的类名，作为 Identifier 标识使用。
 *
 *  @return Identifier 标识字符串
 */
+(NSString *)reuseIdentifier;

@end
