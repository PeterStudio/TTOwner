//
//  TTPayHitoryViewController.m
//  TTOwner
//
//  Created by duwen on 15/9/10.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTPayHitoryViewController.h"
#import "TTPayHistoryTableViewCell.h"


@interface TTPayHitoryViewController (){
    NSDictionary * jsonDic;
}
@property (weak, nonatomic) IBOutlet UILabel *accountLab;

@end

@implementation TTPayHitoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    jsonDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERDATA"];
    
    
//    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
//    
//    [[TTAppService sharedManager] request_]
//    
//    [[TTAppService sharedManager] request_Login_Http_username:self.usernameTF.text pas:self.passwordTF.text system:@"1" version:curVersion imei:imeiStr lat:@"" lng:@"" success:^(id responseObject) {
//        NSDictionary * jsonDic = responseObject;
//        if ([@"000000" isEqualToString:jsonDic[@"retcode"]]) {
//            [SVProgressHUD showSuccessWithStatus:jsonDic[@"retinfo"]];
//            [[NSUserDefaults standardUserDefaults] setObject:jsonDic[@"doc"] forKey:@"USERDATA"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            [self performSegueWithIdentifier:@"LoginSuccessID" sender:nil];
//        }else{
//            [SVProgressHUD showErrorWithStatus:jsonDic[@"retinfo"]];
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试"];
//    }];
//    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTPayHistoryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PayHistoryIdentifier"];
    return cell;
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
