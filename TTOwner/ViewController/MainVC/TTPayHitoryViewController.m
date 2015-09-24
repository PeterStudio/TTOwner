//
//  TTPayHitoryViewController.m
//  TTOwner
//
//  Created by duwen on 15/9/10.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTPayHitoryViewController.h"
#import "TTPayHistoryTableViewCell.h"
#import "MJRefresh.h"


@interface TTPayHitoryViewController (){
    NSDictionary * jsonDic;
    NSString * queryTime;
    NSString * money;
}
@property (weak, nonatomic) IBOutlet UILabel *accountLab;

@property (strong, nonatomic) NSMutableArray * dataSourceArray;
@property (assign, nonatomic) int page;
@property (assign, nonatomic) BOOL      isPulling;
@property (assign, nonatomic) BOOL      hasMore;

@end

@implementation TTPayHitoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    jsonDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERDATA"];
    
    _dataSourceArray = [[NSMutableArray alloc] init];
    queryTime = @"FIRST";
    _isPulling = YES;
    _page = 1;
    _hasMore = YES;
    __weak UITableView * weaktb = self.tableView;
    [weaktb addHeaderWithCallback:^{
        _isPulling = YES;
        queryTime = @"FIRST";
        _page = 1;
        _hasMore = YES;
        [self requestDataWithPage:_page];
        if (weaktb.footerHidden) {
            [weaktb setFooterHidden:NO];
        }
    }];
    [weaktb addFooterWithCallback:^{
        _isPulling = NO;
        if (_hasMore) {
            [self requestDataWithPage:++_page];
        }
    }];
    [self requestDataWithPage:_page];
//    
}

- (void)requestDataWithPage:(int)page{
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [[TTAppService sharedManager] request_rechargeRecord_Http_userId:@"userId" page:[NSString stringWithFormat:@"%d",page] num:@"10" queryTime:queryTime success:^(id responseObject) {
        NSDictionary * dic = responseObject;
        if ([@"000000" isEqualToString:dic[@"retcode"]]) {
            if (_isPulling) {
                [_dataSourceArray removeAllObjects];
                [self.tableView headerEndRefreshing];
            }else{
                [self.tableView footerEndRefreshing];
            }
            NSLog(@"response = %@",responseObject);
            NSDictionary * dic1 = dic[@"doc"];
            NSArray * arr = dic1[@"record"];
            _accountLab.text = [NSString stringWithFormat:@"账户余额：¥%@元",dic1[@"balance"]];
            if (arr.count < 10) {
                _hasMore = NO;
                [self.tableView setFooterHidden:YES];
                [self.tableView footerEndRefreshing];
            }
            [_dataSourceArray addObjectsFromArray:arr];
            [self.tableView reloadData];
            queryTime = dic[@"queryTime"];
            [SVProgressHUD dismiss];
        }else{
            if ([_dataSourceArray count]) {
                [SVProgressHUD showErrorWithStatus:dic[@"retinfo"]];
            }else{
                [SVProgressHUD dismiss];
            }
            [self endRefreshing];
        }
    } failure:^(NSError *error) {
        if ([_dataSourceArray count]) {
            [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试"];
        }else{
            [SVProgressHUD dismiss];
        }
        [self endRefreshing];
    }];
}

/**
 *  停止数据刷新UI
 */
- (void)endRefreshing{
    if (_isPulling) {
        [self.tableView headerEndRefreshing];
    }else{
        [self.tableView footerEndRefreshing];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTPayHistoryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PayHistoryIdentifier"];
    NSDictionary * dic = [_dataSourceArray objectAtIndex:indexPath.row];
    cell.moneyLab.text = dic[@"num"];
    NSString * str = dic[@"time"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate * date = [dateFormatter dateFromString:str];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    cell.timeLab.text = [dateFormatter stringFromDate:date];
    if ([@"0" isEqualToString:dic[@"state"]]) {
        cell.statusLab.text = @"失败";
    }else{
        cell.statusLab.text = @"成功";
    }
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
