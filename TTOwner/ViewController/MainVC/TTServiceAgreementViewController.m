//
//  TTServiceAgreementViewController.m
//  TTOwner
//
//  Created by duwen on 15/9/10.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTServiceAgreementViewController.h"

@interface TTServiceAgreementViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *serviceWebView;

@end

@implementation TTServiceAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSURL *url =[NSURL URLWithString:@"http://www.baidu.com"];
//    NSURLRequest *request =[NSURLRequest requestWithURL:url];
//    [_serviceWebView loadRequest:request];
    [self loadDOCX];
}

#pragma mark 加载docx文件
- (void)loadDOCX
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"about.txt" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [_serviceWebView loadData:data MIMEType:@"text/plain" textEncodingName:@"UTF-8" baseURL:url];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:@"加载中"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
