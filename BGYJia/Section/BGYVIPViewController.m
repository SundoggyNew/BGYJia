//
//  BGYVIPViewController.m
//  BGYJia
//
//  Created by JohnsonChou on 16/3/2.
//  Copyright © 2016年 Bradley Johnson. All rights reserved.
//
#import "BGYVIPViewController.h"
#import "BGYUserInfoViewController.h"
#import "BGYSettingViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "BGYMessageViewController.h"

@interface BGYVIPViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation BGYVIPViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.tabBarController.tabBar.hidden = NO;
    
    User * user = [User runUser];
    
    JCLog(@" %@ ",user.jsessionid);
    
    [self.webView reload];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpVIPSystemUI];
    
    [self setUpVIPUI];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:VIP_MAIN_API]];
    [request setValue:[User runUser].jsessionid forHTTPHeaderField:@"JSESSIONID"];
    [self.webView loadRequest:request];
}

-(void)setUpVIPSystemUI
{
    self.titleViewString = @"会员中心";
    
    [self.navgationLeftButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    self.navgationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
    self.navgationLeftButton.hidden = YES;
    
    @weakify(self);
    [[self.navgationLeftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.webView goBack];
        
    }];
    
    [self.navgationRightButton setImage:[UIImage imageNamed:@"iconfont_tongzhi"] forState:UIControlStateNormal];
    self.navgationRightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -70);
//    self.navgationRightButton.pageCount       = 3;
    
    [[self.navgationRightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        BGYMessageViewController * messageVC = [BGYMessageViewController new];
        messageVC.urlString = GET_USER_MESSAGE_API;
        
        [self.navigationController pushViewController:messageVC animated:YES];
        
    }];
}

-(void)setUpVIPUI
{
    [self.view addSubview:self.webView];
}

#pragma mark -  web View Delegate method

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    @weakify(self);
    context[@"userInfo"] = ^() {
        @strongify(self);
        
        JCLog(@"Begin Log");
        NSArray *args = [JSContext currentArguments];
        
        for (JSValue * jsVal in args) {
            JCLog(@"%@", jsVal);
        }
        
        JCLog(@"This is the Log in userInfo");
        
        [self.navigationController pushViewController:[BGYUserInfoViewController new] animated:YES];
        
        JSValue *this = [JSContext currentThis];
        JCLog(@"this: %@",this);
        JCLog(@"-------End Log-------");
    };
    
    JSContext *contextForSetting = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    contextForSetting[@"systemSetting"] = ^() {
        @strongify(self);
        
        JCLog(@"Begin Log");
        NSArray *args = [JSContext currentArguments];
        
        for (JSValue * jsVal in args) {
            JCLog(@"%@", jsVal);
        }
        
        JCLog(@"This is the Log in systemSetting");
        
        [self.navigationController pushViewController:[BGYSettingViewController new] animated:YES];
        
        JSValue *this = [JSContext currentThis];
        JCLog(@"this: %@",this);
        JCLog(@"-------End Log-------");
    };
    
    NSString * htmlStr = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"];
    
    NSArray * arr = [htmlStr componentsSeparatedByString:@"<title>"];
    
    NSString * title = [[[arr objectAtIndex:1] componentsSeparatedByString:@"</title>"] objectAtIndex:0];
    
    self.titleViewString = title;
    
    self.navgationLeftButton.hidden = [title isEqualToString:@"会员中心"];
    
    self.navgationRightButton.hidden = ![title isEqualToString:@"会员中心"];
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
