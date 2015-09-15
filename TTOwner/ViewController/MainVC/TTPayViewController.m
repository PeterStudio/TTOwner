//
//  TTPayViewController.m
//  TTOwner
//
//  Created by Baby on 15/9/10.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTPayViewController.h"
#import "UIButton+LangExt.h"

@interface TTPayViewController (){
    NSDictionary * jsonDic;
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
