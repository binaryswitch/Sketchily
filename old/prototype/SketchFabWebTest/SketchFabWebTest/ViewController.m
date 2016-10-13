//
//  ViewController.m
//  SketchFabWebTest
//
//  Created by Justin White on 3/10/16.
//  Copyright © 2016 binaryswitch. All rights reserved.
//

#import "ViewController.h"
#import <Webkit/Webkit.h>

@interface ViewController () <WKNavigationDelegate, WKUIDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) WKWebView * webview;
@property (nonatomic, strong) WKWebView * webview2;
@property (nonatomic, strong) UITableView * webViewTableView;

@end

@implementation ViewController


- (void)viewDidLoad {

    [super viewDidLoad];

    self.webViewTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.webViewTableView];
    self.view.backgroundColor = [UIColor grayColor];
    self.webViewTableView.delegate = self;
    self.webViewTableView.dataSource = self;
    self.webViewTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.webViewTableView.bounces = NO;
    [self.view bringSubviewToFront:self.webViewTableView];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float h2 = self.view.frame.size.height/2;
    
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"cell-%ld",indexPath.row]];
    cell.backgroundColor = [UIColor redColor];
    
    WKPreferences * pref = [[WKPreferences alloc] init];
    pref.javaScriptEnabled = YES;

    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];
    config.preferences = pref;

    
    
//    UIView * webview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,h2)];
//    
//    
    
    WKWebView * webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height) configuration:config];
    webview.backgroundColor = [UIColor grayColor];
    webview.UIDelegate = self;
    webview.navigationDelegate = self;
    webview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    webview.scrollView.scrollEnabled = false;
    
    
    NSURL * faceURL = [NSURL URLWithString:@"https://sketchfab.com/models/7cacc2f64fe34f08b27e25cd95760c4f/embed"];
    NSURL * girlURL = [NSURL URLWithString:@"https://sketchfab.com/models/185f59b76d8c47748e54478deaa6729c/embed"];
    NSURL * bustURL1 = [NSURL URLWithString:@"https://sketchfab.com/models/ed6907d1efe34c81bf021d9c6cdec6b7/embed"];
    
    if (indexPath.row == 0){
        [webview loadRequest:[[NSURLRequest alloc] initWithURL:faceURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:0.0]];
    }
    else if (indexPath.row == 1){
        [webview loadRequest:[[NSURLRequest alloc] initWithURL:bustURL1 cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:0.0]];
    }
    else{
        [webview loadRequest:[[NSURLRequest alloc] initWithURL:girlURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:0.0]];
    }
    
    [cell addSubview:webview];

    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchDown];
    button.tag = indexPath.row;
    [cell addSubview:button];
    
    return cell;
}

- (void) didClickButton: (UIButton *)sender{
    [self.webViewTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0] atScrollPosition:nil animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (self.view.frame.size.height/2) - 5;
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
