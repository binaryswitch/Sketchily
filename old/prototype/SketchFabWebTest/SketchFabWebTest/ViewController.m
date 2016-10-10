//
//  ViewController.m
//  SketchFabWebTest
//
//  Created by Justin White on 3/10/16.
//  Copyright © 2016 binaryswitch. All rights reserved.
//

#import "ViewController.h"
#import <Webkit/Webkit.h>

@interface ViewController () <WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView * webview;
@property (nonatomic, strong) WKWebView * webview2;
@property (nonatomic, strong) UIScrollView * scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    WKPreferences * pref = [[WKPreferences alloc] init];
    pref.javaScriptEnabled = YES;
    
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];
    config.preferences = pref;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 2)];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor grayColor];
    
    self.webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height/2) configuration:config];
    self.webview.backgroundColor = [UIColor grayColor];
    self.webview.UIDelegate = self;
    self.webview.navigationDelegate = self;
    self.webview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webview.scrollView.scrollEnabled = false;

    [self.scrollView addSubview:self.webview];

    self.webview2 = [[WKWebView alloc] initWithFrame:CGRectMake(0,  self.view.frame.size.height/2, self.view.frame.size.width,self.view.frame.size.height/2) configuration:config];
    self.webview2.backgroundColor = [UIColor grayColor];
    self.webview2.UIDelegate = self;
    self.webview2.navigationDelegate = self;
    self.webview2.scrollView.scrollEnabled = false;
    
    [self.scrollView addSubview:self.webview2];
}

-(void)viewDidLayoutSubviews{
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2); //sets ScrollView content size
}

-(void)viewWillAppear:(BOOL)animated{
    
    NSURL * googleURL = [NSURL URLWithString:@"https://sketchfab.com/models/7cacc2f64fe34f08b27e25cd95760c4f/embed"];
    
    [self.webview loadRequest:[[NSURLRequest alloc] initWithURL:googleURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:0.0]];
    [self.webview2 loadRequest:[[NSURLRequest alloc] initWithURL:googleURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:0.0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    NSLog(@":P");
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@":(");
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(navigationAction.request.URL.absoluteString);
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@":)");
}

@end
