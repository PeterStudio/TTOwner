//
//  TTMineViewController.m
//  TTOwner
//
//  Created by duwen on 15/9/10.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTMineViewController.h"
#import "RatingBar.h"

@interface TTMineViewController (){
    NSDictionary * jsonDic;
}
@property (strong, nonatomic) IBOutlet UIButton *headIV;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *countLab;
@property (strong, nonatomic) IBOutlet RatingBar *rateBar;
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;

@property (strong, nonatomic) IBOutlet UITextField *pswTF1;
@property (strong, nonatomic) IBOutlet UITextField *pswTF2;

@end

@implementation TTMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    jsonDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERDATA"];
    _headIV.layer.masksToBounds = YES;
    _headIV.layer.cornerRadius = 30.0f;
    
    [_headIV sd_setImageWithURL:[NSURL URLWithString:jsonDic[@"headUrl"]] forState:UIControlStateNormal];
    _nameLab.text = jsonDic[@"name"];
    _countLab.text = [NSString stringWithFormat:@"被预约%@次",jsonDic[@"frequency"]];
    
    _rateBar.isIndicator = YES;
    [_rateBar setImageDeselected:@"star01_1" halfSelected:nil fullSelected:@"star01" andDelegate:nil];
    float count = jsonDic[@"star"]?[jsonDic[@"star"] floatValue]:1.0;
    [_rateBar displayRating:count];
    
    _phoneTF.placeholder = jsonDic[@"tel"];
    
}


- (IBAction)saveAction:(id)sender {
    [self.view endEditing:YES];
    
    if (self.pswTF1.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    if (self.pswTF2.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
        return;
    }
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [[TTAppService sharedManager] request_modifyInfo_Http_userId:jsonDic[@"userId"] oldPwd:self.pswTF1.text pwd:self.pswTF2.text success:^(id responseObject) {
        NSDictionary * dic = responseObject;
        if ([@"000000" isEqualToString:dic[@"retcode"]]) {
            [SVProgressHUD showSuccessWithStatus:dic[@"retinfo"]];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"retinfo"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试"];
    }];

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
