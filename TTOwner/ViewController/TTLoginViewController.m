//
//  TTLoginViewController.m
//  TTOwner
//
//  Created by duwen on 15/9/8.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTLoginViewController.h"
#import <AdSupport/AdSupport.h>
#import "NSString+LangExt.h"

@interface TTLoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation TTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)loginAction:(id)sender {
    [self.view endEditing:YES];

//    [self performSegueWithIdentifier:@"LoginSuccessID" sender:nil];
//    return;
    
    if (![self.usernameTF.text validChinesePhoneNumber]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    if (self.passwordTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    NSString *curVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (!curVersion) {
        curVersion=@"1.0";
    }
    NSString *imeiStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [[TTAppService sharedManager] request_Login_Http_username:self.usernameTF.text pas:self.passwordTF.text system:@"1" version:curVersion imei:imeiStr lat:@"" lng:@"" success:^(id responseObject) {
        NSDictionary * jsonDic = responseObject;
        if ([@"000000" isEqualToString:jsonDic[@"retcode"]]) {
            [SVProgressHUD showSuccessWithStatus:jsonDic[@"retinfo"]];
            [[NSUserDefaults standardUserDefaults] setObject:jsonDic[@"doc"] forKey:@"USERDATA"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ROOTVIEWCONTROLLER" object:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:jsonDic[@"retinfo"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试"];
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1.0f;
}


#pragma mark - UITextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
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
