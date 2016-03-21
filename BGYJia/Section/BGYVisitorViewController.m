//
//  BGYVisitorViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYVisitorViewController.h"
#import "BGYParkingCostViewController.h"
#import "BGYAuthorizationRecordsViewController.h"

@interface BGYVisitorViewController()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation BGYVisitorViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.tabBarController.tabBar.hidden = NO;
    
    [self.webView reload];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpVisitorSystemUI];
    
    [self setUpVisitorUI];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:VISITOR_MAIN_API]];
    [request setValue:[User runUser].jsessionid forHTTPHeaderField:@"JSESSIONID"];
    [self.webView loadRequest:request];
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@;jsessionid=%@",VISITOR_MAIN_API,[User runUser].jsessionid]]]];
}

-(void)setUpVisitorSystemUI
{
    self.titleViewString = @"访客";
    
    [self.navgationLeftButton setTitle:@"停车费用" forState:UIControlStateNormal];
    [self.navgationLeftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navgationLeftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        if ([self.titleViewString isEqualToString:@"访客"]) {
            
            JCLog(@" 停车费用 ");
            
            BGYParkingCostViewController * parkingVC = [BGYParkingCostViewController new];
            parkingVC.urlString = @"http://www.baidu.com";
            
            [self.navigationController pushViewController:parkingVC animated:YES];
            
        }else{
            
            [self.webView goBack];
            
        }
        
    }];
    
    [self.navgationRightButton setTitle:@"授权记录" forState:UIControlStateNormal];
    [self.navgationRightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navgationRightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -25);
    
    [[self.navgationRightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        BGYAuthorizationRecordsViewController * authorizationRecordsVC = [BGYAuthorizationRecordsViewController new];
        authorizationRecordsVC.urlString = VISITOR_HISTORY_API;
        
        [self.navigationController pushViewController:authorizationRecordsVC animated:YES];
        
        
    }];
}

-(void)setUpVisitorUI
{
    [self.view addSubview:self.webView];
    
}

#pragma mark -  web View Delegate method

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    NSString * htmlStr = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"];
    
    NSArray * arr = [htmlStr componentsSeparatedByString:@"<title>"];
    
    NSString * title = [[[arr objectAtIndex:1] componentsSeparatedByString:@"</title>"] objectAtIndex:0];
    
    self.titleViewString = title;
    
    if ([title isEqualToString:@"访客"]) {
        
        [self.navgationLeftButton setTitle:@"停车费用" forState:UIControlStateNormal];
        [self.navgationLeftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.navgationLeftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
        
    }else{
        
        [self.navgationLeftButton setTitle:nil forState:UIControlStateNormal];
        [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
        self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
        
    }
    
    self.navgationRightButton.hidden = ![title isEqualToString:@"访客"];
    
}


#pragma mark - initializes attributes

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.scrollView.bounces = NO;
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
    }
    return _webView;
}
@end
