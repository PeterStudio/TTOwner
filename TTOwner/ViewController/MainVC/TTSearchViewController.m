//
//  TTSearchViewController.m
//  TTOwner
//
//  Created by Baby on 15/9/10.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTSearchViewController.h"
#import "TTSearchTableViewCell.h"


@interface TTSearchViewController ()
@property (weak, nonatomic) IBOutlet UILabel *qianyueLab;
@property (weak, nonatomic) IBOutlet UILabel *yuyueLab;
@property (weak, nonatomic) IBOutlet UILabel *qiaotanLab;

@end

@implementation TTSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTSearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCellidentifier"];
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
