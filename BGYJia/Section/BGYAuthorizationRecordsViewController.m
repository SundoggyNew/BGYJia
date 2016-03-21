//
//  BGYAuthorizationRecordsViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/16.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYAuthorizationRecordsViewController.h"

@interface BGYAuthorizationRecordsViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation BGYAuthorizationRecordsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    self.navigationController.navigationBarHidden = NO;
    //
    //    self.tabBarController.tabBar.hidden = NO;
    
    [self.webView reload];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpVisitorSystemUI];
    
    [self setUpVisitorUI];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [request setValue:[User runUser].jsessionid forHTTPHeaderField:@"JSESSIONID"];
    [self.webView loadRequest:request];
    
}

-(void)setUpVisitorSystemUI
{
    self.titleViewString = @"授权记录";
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:YES];
        
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
