
#import <UIKit/UIKit.h>
#import "BGYHomeKeyEntity.h"
static const CGFloat OPENDOOR_HEIGHT = 60.f;
//@class LiveMessageInfo;

@protocol  BGYOpenDoorSubViewAddressListViewDelegate<NSObject>
@optional

-(void) keyListDidScrollTo:(int) index;

@end


@interface BGYOpenDoorSubViewAddressListView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic, assign) BOOL isUserScrolling;
@property(nonatomic,strong) UICollectionView  * cUITableView;

//@property (nonatomic, strong) UILabel  * cAvatarListNum;
@property (nonatomic, weak) id<BGYOpenDoorSubViewAddressListViewDelegate> delegate;

@property(nonatomic,strong) UIButton  * cPreButton;
@property(nonatomic,strong) UIButton  * cNextButton;

@property (nonatomic, strong) NSMutableArray  * dataArr;

-(void) scrollToTop;
-(void) loadData;

@end
