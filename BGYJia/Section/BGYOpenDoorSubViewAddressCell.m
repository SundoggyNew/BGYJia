

#import "BGYOpenDoorSubViewAddressCell.h"


@interface BGYOpenDoorSubViewAddressCell ()


@end

@implementation BGYOpenDoorSubViewAddressCell


- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        
//        _cAvatarImage = [[UIImageView alloc] init];
//        _cAvatarImage.clipsToBounds = YES;
//        _cAvatarImage.image = [UIImage imageNamed:@"方形默认图片"];
//        _cAvatarImage.layer.masksToBounds = YES;
//        _cAvatarImage.layer.borderColor = [UIColor whiteColor].CGColor;
//        _cAvatarImage.contentMode = UIViewContentModeScaleAspectFill;
//        _cAvatarImage.layer.borderWidth = 1.0f;
//        _cAvatarImage.layer.cornerRadius = 17.5;
        [self.contentView addSubview:self.cHouseAddress];
        [self.cHouseAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.centerX.equalTo(self.contentView.mas_centerX).offset(0);
        }];
//
//        _cVipMark = [[UIImageView alloc] init];
//        _cVipMark.image = [UIImage imageNamed:@"play_VIP"];
//        [self.contentView addSubview:_cVipMark];
//        [_cVipMark mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(_cAvatarImage.mas_right).offset(-1);
//            make.bottom.equalTo(_cAvatarImage.mas_bottom).offset(0);
//        }];
//        
//        CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
//        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
//        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
//        UIColor *c =  [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
//        self.contentView.backgroundColor = c;
       
    }
    return self;
}

- (void)awakeFromNib {
    // [self setup];
}



- (void)dealloc {

}
 -(void) reloadData
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    UIColor *c =  [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    self.cHouseAddress.textColor = c;
}

// -(void) reloadData:(LiveMessageInfo *) data;
// {
//    self.cVipMark.hidden = YES;
//    if (data == nil)
//    {
//       return;
//    }
//    [self.cAvatarImage sd_setImageWithURL:[ 
//        [NSURL alloc] initWithString:data.actionAvatar]
//                    placeholderImage:[UIImage imageNamed:@"avatar.png"]
//                             options:SDWebImageRefreshCached];
//        if ([data.actionRoleId intValue] == 2)
//        {
//           self.cVipMark.hidden = NO;
//        }
// }

-(UILabel *) cHouseAddress
{
    if (_cHouseAddress == nil)
    {
        UILabel  *houseAddress = [UILabel new];
        houseAddress.textColor       = [UIColor grayColor];
        //        promotion.backgroundColor = [UIColor yellowColor];
        houseAddress.textAlignment   = NSTextAlignmentCenter;
        houseAddress.numberOfLines = 2;
        [houseAddress sizeToFit];
        [houseAddress setFont:[UIFont systemFontOfSize:16]];
        houseAddress.text            = @"按一下开门";
        houseAddress.layer.cornerRadius = 7;
        _cHouseAddress = houseAddress;
        
    }
    return _cHouseAddress;
}


@end
