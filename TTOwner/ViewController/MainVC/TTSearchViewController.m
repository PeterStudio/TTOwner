//
//  TTSearchViewController.m
//  TTOwner
//
//  Created by Baby on 15/9/10.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTSearchViewController.h"

#import "TTSearchTableViewCell.h"

@interface TTSearchViewController (){
    NSDictionary * jsonDic;
}

@property (weak, nonatomic) IBOutlet UILabel *qianyueLab;
@property (weak, nonatomic) IBOutlet UILabel *yuyueLab;
@property (weak, nonatomic) IBOutlet UILabel *qiaotanLab;


@property (strong, nonatomic) NSMutableArray * dataSourceArray;

@end

@implementation TTSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     jsonDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERDATA"];
     _dataSourceArray = [[NSMutableArray alloc] init];
     [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
     [[TTAppService sharedManager] request_constructionSite_Http_userId:jsonDic[@"userId"] success:^(id responseObject) {
         NSDictionary * dic = responseObject;
         if ([@"000000" isEqualToString:dic[@"retcode"]]) {
             NSDictionary * dic1 = dic[@"doc"];
             _qianyueLab.text = [NSString stringWithFormat:@"%@套",dic1[@"contractNum"]];
             _yuyueLab.text = [NSString stringWithFormat:@"%@人",dic1[@"reservationNum"]];
             _qiaotanLab.text = [NSString stringWithFormat:@"%@人",dic1[@"chatNum"]];
             _dataSourceArray = dic1[@"homeInfo"];
             [SVProgressHUD dismiss];
         }else{
             [SVProgressHUD showErrorWithStatus:dic[@"retinfo"]];
         }
     } failure:^(NSError *error) {
         [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试"];
     }];
    

    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTSearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCellidentifier"];
    
    NSDictionary * dic = [_dataSourceArray objectAtIndex:indexPath.row];
    cell.indxLab.text = [NSString stringWithFormat:@"%2d",indexPath.row + 1];
    cell.addresLab.text = dic[@"address"];
    cell.nameLab.text = [NSString stringWithFormat:@"%@  先生",dic[@"name"]];
    
    switch ([dic[@"state"] integerValue]) {
        case 0:
            [cell.stateBtn setTitle:@"未签约" forState:UIControlStateNormal];
            break;
        case 1:
            [cell.stateBtn setTitle:@"已签约" forState:UIControlStateNormal];
            break;
        case 2:
            [cell.stateBtn setTitle:@"施工中" forState:UIControlStateNormal];
            break;
        case 3:
            [cell.stateBtn setTitle:@"已完工" forState:UIControlStateNormal];
            break;
        case 4:
            [cell.stateBtn setTitle:@"验收中" forState:UIControlStateNormal];
            break;
        case 5:
            [cell.stateBtn setTitle:@"项目结束" forState:UIControlStateNormal];
            break;
        case 6:
            [cell.stateBtn setTitle:@"已作废" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
//    cell.timeLab.text = dic[@""];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
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
