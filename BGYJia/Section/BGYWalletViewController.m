//
//  BGYWalletViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//

#import "BGYWalletViewController.h"

@interface BGYWalletViewController()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation BGYWalletViewController

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
    
    [self setUpWalletSystemUI];
    
    [self setUpWalletUI];
    

//     NSDictionary *properties = [[NSMutableDictionary alloc] init];
//     [properties setValue:[User runUser].jsessionid forKey:@"jsessionid"];
//     NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:properties];
//     NSArray *cookies=[NSArray arrayWithObjects:cookie,nil];
//     NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:WALLET_MAIN_API]];
     [request setValue:[User runUser].jsessionid forHTTPHeaderField:@"JSESSIONID"];
     [self.webView loadRequest:request];
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@;jsessionid=%@",WALLET_MAIN_API,[User runUser].jsessionid]]]];
}

-(void)setUpWalletSystemUI
{
    self.titleViewString = @"钱包";
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    self.navgationLeftButton.hidden = YES;
    
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.webView goBack];
        
    }];
}

-(void)setUpWalletUI
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
    
    self.navgationLeftButton.hidden = [title isEqualToString:@"钱包"];
        
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
