#import "BGYOpenDoorSubViewAddressListView.h"
#import "BGYOpenDoorSubViewAddressCell.h"
#import "BGYOpenDoorSubViewAddressCellLayout.h"


@interface BGYOpenDoorSubViewAddressListView()

@end


@implementation BGYOpenDoorSubViewAddressListView

#pragma mark -- public method



#pragma mark -- life cycle

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self setup];
        [self layoutUI];
        [self eventBinding];
    }
    return self;
}



-(void) setup
{
    [self addSubview:self.cUITableView];
    [self addSubview:self.cPreButton];
    [self addSubview:self.cNextButton];
    self.cPreButton.enabled = NO;
    self.cNextButton.enabled = NO;
}

-(void) layoutUI
{
     [self.cUITableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0,50,0,50));
     }];
    
    [self.cPreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    
    [self.cNextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
}

#pragma mark - event binding
-(void) eventBinding
{
    [self.cPreButton addTarget:self action:@selector(OnPreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cNextButton addTarget:self action:@selector(OnNextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void) loadData
{
    NSArray *data =   [User runUser].accessData.value.userKey.homeList;
    
    for (HomeList *homeList in data)
    {
        NSArray *keyArr = homeList.keyList;
        for ( KeyList *keyData  in keyArr ) {
            BGYHomeKeyEntity *entity = [BGYHomeKeyEntity new];
            entity.homeList = homeList;
            entity.KeyList = keyData;
            [self.dataArr addObject:entity];
        }
    }
    
    [self.cUITableView reloadData];
    
    if ([self.dataArr count] > 1)
    {
        self.cNextButton.enabled = YES;
    }
    
    if ([self.dataArr count] >= 1)
    {
        [self.delegate keyListDidScrollTo:0];
    }
    
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    //    tipsImageView.center = CGPointMake(ScreenWidth*.5, );
    
}


#pragma mark - event response
-(void) OnPreButtonClick:(id)Sender
{
    CGFloat pageWidth = self.cUITableView.frame.size.width;
    float currentPage = self.cUITableView.contentOffset.x / pageWidth;
    currentPage = currentPage - 1;
    [self togglePreNextButtonHideOrShow:(int)currentPage];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentPage inSection:0];
    [self.cUITableView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}




-(void) OnNextButtonClick:(id)Sender
{
    CGFloat pageWidth = self.cUITableView.frame.size.width;
    float currentPage = self.cUITableView.contentOffset.x / pageWidth;
    currentPage = currentPage + 1;
    self.cPreButton.hidden = NO;
    self.cNextButton.hidden = NO;
    [self togglePreNextButtonHideOrShow:(int)currentPage];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentPage inSection:0];
    [self.cUITableView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

}

-(void) togglePreNextButtonHideOrShow:(int) currentPage
{
    self.cPreButton.enabled = YES;
    self.cNextButton.enabled = YES;
    if ( (int)currentPage == 0 )
    {
        self.cPreButton.enabled = NO;
    }
    if ( ( (int)currentPage +1 ) == self.dataArr.count )
    {
        self.cNextButton.enabled = NO;
    }
    if (self.dataArr.count == 1) {
        self.cPreButton.enabled = NO;
        self.cNextButton.enabled = NO;
    }
    
    [self.delegate keyListDidScrollTo:currentPage];
}


#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView 
cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BGYOpenDoorSubViewAddressCell *cell = [collectionView
        dequeueReusableCellWithReuseIdentifier:BGYOpenDoorSubViewAddressCellIdentifier
        forIndexPath:indexPath];

    BGYHomeKeyEntity *data = self.dataArr[indexPath.row];
    cell.cHouseAddress.text = [NSString stringWithFormat:@"%@\n%@",data.homeList.houseName,data.KeyList.lockName];
        [cell reloadData];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH-100,OPENDOOR_HEIGHT);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    LiveMessageInfo *data = self.dataArr[indexPath.row];
//
//    if (data.actionUid == [ConstData getJid]) {
//        return;
//    }
//    if (self.delegate)
//    {
//       [self.delegate showAvatarProfile:data];
//    }

}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView 
shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView 
layout:(UICollectionViewLayout*)collectionViewLayout 
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView 
layout:(UICollectionViewLayout*)collectionViewLayout 
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.cUITableView.frame.size.width;
    float currentPage = self.cUITableView.contentOffset.x / pageWidth;
    [self togglePreNextButtonHideOrShow:currentPage];
    NSLog(@"Page Number : %ld", (long)currentPage + 1);
}
#pragma mark - setter & getter 
-(UICollectionView *) cUITableView
{
    if (!_cUITableView)
    {
        UICollectionView
        *emotionCollectionView = [[UICollectionView alloc ] initWithFrame:CGRectMake(0, 0,
                                                                                    CGRectGetWidth(self.bounds) ,CGRectGetHeight(self.bounds) ) collectionViewLayout:[BGYOpenDoorSubViewAddressCellLayout new]];
                                                                                    
                                                                                    
        emotionCollectionView.backgroundColor = self.backgroundColor;
        [emotionCollectionView registerClass:[BGYOpenDoorSubViewAddressCell class]
         forCellWithReuseIdentifier:BGYOpenDoorSubViewAddressCellIdentifier];
        emotionCollectionView.showsHorizontalScrollIndicator = NO;
        emotionCollectionView.showsVerticalScrollIndicator = NO;
        emotionCollectionView.userInteractionEnabled = YES;
        emotionCollectionView.pagingEnabled = YES;
        emotionCollectionView.delegate = self;
        emotionCollectionView.dataSource = self;
        _cUITableView = emotionCollectionView;
                                                                                    }
    return  _cUITableView;
}


-(void) scrollToTop
{
//    if (self.isUserScrolling)
//    {
//        return;
//    }
//    
//    NSIndexPath *indexPath =
//    [NSIndexPath indexPathForRow:0
//                       inSection:0];
//    
//    [self.cUITableView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];

}

-(NSMutableArray  *) dataArr
{
    if (!_dataArr)
    {
        _dataArr = [NSMutableArray new];

    }
    return  _dataArr;
}

//-(UILabel  *) cAvatarListNum
//{
//    if (!_cAvatarListNum)
//    {
//        _cAvatarListNum = [[UILabel alloc] init];
//        _cAvatarListNum.textColor = [UIColor whiteColor];
//        _cAvatarListNum.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.1];
//        _cAvatarListNum.layer.masksToBounds = YES;
//        _cAvatarListNum.layer.cornerRadius = 17.5;
//        _cAvatarListNum.layer.borderColor = [UIColor whiteColor].CGColor;
//        _cAvatarListNum.textAlignment = NSTextAlignmentCenter;
//        _cAvatarListNum.layer.borderWidth = 1.0;
////        _cAvatarListNum.font = [UIFont fontWithName:FZLTXIHKGBK size:11];
//    }
//    return  _cAvatarListNum;
//}


-(UIButton *) cPreButton
{
    if (!_cPreButton)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"address_choose_icon"] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:@"address_choose_icon_disable"] forState:UIControlStateDisabled];
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _cPreButton = button;
//        _cPreButton.hidden = YES;

    }
    return  _cPreButton;
}

-(UIButton *) cNextButton
{
    if (!_cNextButton)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"address_choose_icon_right"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"address_choose_icon_right_disable"] forState:UIControlStateDisabled];
        
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _cNextButton = button;
        //        _cNextButton.hidden = YES;
    }
    return  _cNextButton;
}



@end
