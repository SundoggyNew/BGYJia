
#import "BGYOpenDoorSubViewAddressCellLayout.h"

@interface BGYOpenDoorSubViewAddressCellLayout()
{
    int contentSizeWidth;
    int coetentSizeHeight;
}


@end


@implementation BGYOpenDoorSubViewAddressCellLayout

- (id)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView.alwaysBounceVertical = YES;
        
    
    }
    return self;
}
@end
