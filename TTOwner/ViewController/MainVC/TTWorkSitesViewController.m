//
//  TTWorkSitesViewController.m
//  TTOwner
//
//  Created by Baby on 15/9/10.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTWorkSitesViewController.h"
#import "TTWorkerTableViewCell.h"
#import "MJRefresh.h"

@interface TTWorkSitesViewController (){
    NSDictionary * jsonDic;
    NSString * queryTime;
}
@property (weak, nonatomic) IBOutlet UILabel *qianyueLab;
@property (weak, nonatomic) IBOutlet UILabel *yuyueLab;
@property (weak, nonatomic) IBOutlet UILabel *qiatanLab;
@property (weak, nonatomic) IBOutlet UILabel *feeLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;

@property (weak, nonatomic) IBOutlet UIButton *payBtn;


@property (strong, nonatomic) NSMutableArray * dataSourceArray;
@property (assign, nonatomic) int page;
@property (assign, nonatomic) BOOL      isPulling;
@property (assign, nonatomic) BOOL      hasMore;
@end

@implementation TTWorkSitesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage * sel = [[UIImage imageNamed:@"reserve_bg01"] stretchableImageWithLeftCapWidth:2 topCapHeight:2];
    [_payBtn setBackgroundImage:sel forState:UIControlStateNormal];
    [_payBtn setBackgroundImage:sel forState:UIControlStateHighlighted];
    [_payBtn setBackgroundImage:sel forState:UIControlStateSelected];
    
    
    
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
    
}


- (void)requestDataWithPage:(int)page{
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [[TTAppService sharedManager] request_reservationQuery_Http_userId:@"userId" page:[NSString stringWithFormat:@"%d",page] num:@"10" queryTime:queryTime success:^(id responseObject) {
        NSDictionary * dic = responseObject;
        if ([@"000000" isEqualToString:dic[@"retcode"]]) {
            if (_isPulling) {
                [_dataSourceArray removeAllObjects];
                [self.tableView headerEndRefreshing];
            }else{
                [self.tableView footerEndRefreshing];
            }
            NSDictionary * dic1 = dic[@"doc"];
            _qianyueLab.text = [NSString stringWithFormat:@"%@套",dic1[@"contractNum"]];
            _yuyueLab.text = [NSString stringWithFormat:@"%@人",dic1[@"reservationNum"]];
            _qiatanLab.text = [NSString stringWithFormat:@"%@人",dic1[@"chatNum"]];
            _feeLab.text = [NSString stringWithFormat:@"消费：￥%@元",dic1[@"consumption"]];
            _moneyLab.text = [NSString stringWithFormat:@"余额：￥%@元",dic1[@"balance"]];
            NSArray * arr = dic1[@"homeInfo"];
            //            NSNumber * number = dic1[@"balance"];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTWorkerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WorkerIdentifier"];
    NSDictionary * dic = [_dataSourceArray objectAtIndex:indexPath.row];
    cell.indexLab.text = [NSString stringWithFormat:@"%2d",indexPath.row + 1];
    cell.nameLab.text = [NSString stringWithFormat:@"%@  业主",dic[@"name"]];
    cell.addressLab.text = dic[@"address"];
//    cell.watchBtn;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section != 0) {
        return 12;
    }else{
        return 1.0;
    }
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
