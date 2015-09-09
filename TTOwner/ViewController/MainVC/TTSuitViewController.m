//
//  TTSuitViewController.m
//  TTOwner
//
//  Created by duwen on 15/9/10.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTSuitViewController.h"

@interface TTSuitViewController (){
    NSDictionary * jsonDic;
}
@property (strong, nonatomic) IBOutlet UITextView *textV;

@end

@implementation TTSuitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    jsonDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERDATA"];
}


- (IBAction)submit:(id)sender {
    [self.view endEditing:YES];
    
    if (self.textV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入投诉建议"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [[TTAppService sharedManager] request_feedback_Http_userId:[jsonDic objectForKey:@"userId"] content:_textV.text success:^(id responseObject) {
        if ([@"000000" isEqualToString:jsonDic[@"retcode"]]) {
            [SVProgressHUD showSuccessWithStatus:jsonDic[@"retinfo"]];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:jsonDic[@"retinfo"]];
        }
    } failure:^(NSError *error) {
       [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试"];
    }];

    
//    [[TTAppService sharedManager] request_modifyInfo_Http_userId:jsonDic[@""] oldPwd:self.pswTF1.text pwd:self.pswTF2.text success:^(id responseObject) {
//        if ([@"000000" isEqualToString:jsonDic[@"retcode"]]) {
//            [SVProgressHUD showSuccessWithStatus:jsonDic[@"retinfo"]];
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
//            [SVProgressHUD showErrorWithStatus:jsonDic[@"retinfo"]];
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试"];
//    }];
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
