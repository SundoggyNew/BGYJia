
#import <UIKit/UIKit.h>


#define  BGYOpenDoorSubViewAddressCellIdentifier  @"BGYOpenDoorSubViewAddressCellIdentifier"


@protocol BGYOpenDoorSubViewAddressCellDelegate <NSObject>


@end

@interface BGYOpenDoorSubViewAddressCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView       *cAvatarImage;
@property (nonatomic, strong) UIImageView       *cVipMark;
@property (nonatomic, strong) UILabel           *cHouseAddress;



// -(void) reloadData:(LiveMessageInfo *) data;

 -(void) reloadData;
@end
