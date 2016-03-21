//
//  BGYHouseListViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/3.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYHouseListViewController.h"
#import "BGYHouseListTableViewCell.h"

#import "BGYChoseModel.h"

@interface BGYHouseListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UILabel * remindLabel;

@property (nonatomic , strong) UITableView * houseListTableView;

@end

static NSString * ReuseIdentifier = @"HouseListCell";

@implementation BGYHouseListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpRegisterForSetPswSystemUI];
    
    [self setUpRegisterForSetPswUI];
}
-(void)setUpRegisterForSetPswSystemUI
{
    self.titleViewString = @"房产列表";
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}

-(void)setUpRegisterForSetPswUI
{
    [self.view addSubview:self.remindLabel];
    [self.view addSubview:self.houseListTableView];
    
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).with.offset(20);
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.108);
    }];
    
    [self.houseListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.top.equalTo(self.remindLabel.mas_bottom);
    }];
}

#pragma mark - tableView delegate

#pragma mark - tableView dataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BGYHouseListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[BGYHouseListTableViewCell reuseIdentifier]];
    
    if (indexPath.row == 0) {
        cell.haveLineUp = YES;
    }
    
    BGYChoseModel *houseModel = self.dataArr[indexPath.row];
    
    cell.titleString = houseModel.name;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SELF_VIEW_WIDTH*0.118666667;
}


#pragma mark - initializes attributes

-(UILabel *)remindLabel
{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] init];
        _remindLabel.text = @"您的房产：";
        _remindLabel.textColor = UIColorFromRGB(0x666666);
    }
    return _remindLabel;
}

-(UITableView *)houseListTableView
{
    if (!_houseListTableView) {
        _houseListTableView = [[UITableView alloc] init];
        _houseListTableView.delegate = self;
        _houseListTableView.dataSource = self;
        _houseListTableView.tableFooterView = [UIView new];
        _houseListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _houseListTableView.allowsSelection = NO;
        
        [_houseListTableView registerClass:[BGYHouseListTableViewCell class] forCellReuseIdentifier:[BGYHouseListTableViewCell reuseIdentifier]];
    }
    return _houseListTableView;
}

@end
