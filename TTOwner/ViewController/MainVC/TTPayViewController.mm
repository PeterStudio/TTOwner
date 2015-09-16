//
//  TTPayViewController.m
//  TTOwner
//
//  Created by Baby on 15/9/10.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTPayViewController.h"
#import "UIButton+LangExt.h"


#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "UPPayPlugin.h"


#define kWaiting          @"正在获取订单,请稍后..."
#define kNote             @"提示"
#define kConfirm          @"确定"
#define kErrorNet         @"网络错误"
#define kResult           @"支付结果：%@"


#define kMode_Development             @"01"  // 00正式环境 01开发环境

@interface TTPayViewController (){
    NSDictionary * jsonDic;
    UIAlertView* _alertView;
    NSMutableData* _responseData;
}
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *moneyBtnArr;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *payBtnArr;

@end

@implementation TTPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UIButton *btn in _moneyBtnArr) {
        [btn setBackground];
    }
    
    jsonDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERDATA"];
    _phoneLab.text = jsonDic[@"tel"];
}

- (IBAction)moneyBtnAction:(UIButton *)sender {
    for (UIButton *btn in _moneyBtnArr) {
        [btn setSelected:NO];
    }
    sender.selected = YES;
}


- (IBAction)payBtnAction:(UIButton *)sender {
    for (UIButton *btn in _payBtnArr) {
        [btn setSelected:NO];
    }
    sender.selected = YES;
}

- (IBAction)chongHhiBtnAction:(id)sender {
    UIButton * temp;
    for(UIButton * btn in _payBtnArr){
        if (btn.selected) {
            temp = btn;
            break;
        }
    }
    
    UIButton * temp1;
    for (UIButton * btn in _moneyBtnArr) {
        if (btn.selected) {
            temp1 = btn;
            break;
        }
    }
    switch (temp.tag) {
        case 0: // 支付宝
            
            break;
        case 1: //微信
            
            break;
        case 2: // 银联
        {
            [SVProgressHUD showWithStatus:kWaiting maskType:SVProgressHUDMaskTypeClear];
            [[TTAppService sharedManager] request_payMoney_Http_userId:@"" money:[NSString stringWithFormat:@"%ld",temp1.tag] type:@"3" success:^(id responseObject) {
                NSDictionary * dic = responseObject;
                if ([@"000000" isEqualToString:dic[@"retcode"]]) {
                    [SVProgressHUD dismiss];
                    NSDictionary * temp = dic[@"doc"];
                    NSString * tn = temp[@"tn"];
                    [UPPayPlugin startPay:tn mode:kMode_Development viewController:self delegate:self];
                }else{
                    [SVProgressHUD showErrorWithStatus:kErrorNet];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:kErrorNet];
            }];
        }
            break;
        default:
            break;
    }
}



#pragma mark - Alert

- (void)showAlertWait
{
    _alertView = [[UIAlertView alloc] initWithTitle:kWaiting message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [_alertView show];
    UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiv.center = CGPointMake(_alertView.frame.size.width / 2.0f - 15, _alertView.frame.size.height / 2.0f + 10 );
    [aiv startAnimating];
    [_alertView addSubview:aiv];
}

- (void)showAlertMessage:(NSString*)msg
{
    _alertView = [[UIAlertView alloc] initWithTitle:kNote message:msg delegate:self cancelButtonTitle:kConfirm otherButtonTitles:nil, nil];
    [_alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    _alertView = nil;
}


#pragma mark UPPayPluginResult
- (void)UPPayPluginResult:(NSString *)result
{
    NSString* msg = [NSString stringWithFormat:kResult, result];
    [self showAlertMessage:msg];
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
