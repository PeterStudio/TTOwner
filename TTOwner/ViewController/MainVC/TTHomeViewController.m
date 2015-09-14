//
//  TTHomeViewController.m
//  TTOwner
//
//  Created by Baby on 15/7/23.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTHomeViewController.h"
#import "RatingBar.h"


@interface TTHomeViewController (){
    NSDictionary * jsonDic;
}

@property (strong, nonatomic) IBOutlet UIImageView *headIV;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *countLab;
@property (strong, nonatomic) IBOutlet UILabel *moneyLab;
@property (strong, nonatomic) IBOutlet UILabel *payLabe;
@property (strong, nonatomic) IBOutlet UILabel *count1Lab;
@property (strong, nonatomic) IBOutlet RatingBar *rateBar;

@end

@implementation TTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationItem.leftBarButtonItem = nil;
    self.navigationController.navigationItem.backBarButtonItem = nil;
    
    jsonDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERDATA"];
    _headIV.layer.masksToBounds = YES;
    _headIV.layer.cornerRadius = 30.0f;
    [_headIV sd_setImageWithURL:[NSURL URLWithString:jsonDic[@"headUrl"]] placeholderImage:[UIImage imageNamed:@"user_head02"]];
    _nameLab.text = jsonDic[@"name"];
    NSString * frequency = jsonDic[@"frequency"]?jsonDic[@"frequency"]:@"0";
    _countLab.text = [NSString stringWithFormat:@"被预约%@次",frequency];
    _count1Lab.text = [NSString stringWithFormat:@"%@个",frequency];
    
    _rateBar.isIndicator = YES;
    [_rateBar setImageDeselected:@"start_icon01" halfSelected:nil fullSelected:@"start_icon01_1" andDelegate:nil];
    [_rateBar displayRating:[jsonDic[@"star"] floatValue]];
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
