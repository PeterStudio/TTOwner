//
//  TTServiceAgreementViewController.m
//  TTOwner
//
//  Created by duwen on 15/9/10.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTServiceAgreementViewController.h"

@interface TTServiceAgreementViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *serviceWebView;

@end

@implementation TTServiceAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url =[NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_serviceWebView loadRequest:request];
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
