//
//  TTLoginViewViewController.m
//  TTOwner
//
//  Created by Baby on 15/7/22.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTLoginViewViewController.h"
#import "TTLoginViewModel.h"

@interface TTLoginViewViewController ()


@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) TTLoginViewModel * viewModel;


@property (weak, nonatomic) IBOutlet UILabel *stausLab;
@end

@implementation TTLoginViewViewController

- (instancetype)init{
    if (self = [super init]) {
        self.viewModel = [TTLoginViewModel new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RAC(self.viewModel,phoneNumber) = self.phoneTF.rac_textSignal;
    RAC(self.viewModel,password) = self.passwordTF.rac_textSignal;
    self.loginBtn.rac_command = self.viewModel.loginCommand;
    RAC(self.stausLab, text) = RACObserve(self.viewModel, statusMessage);
    
//    [[[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] mapReplace:self.viewModel.loginCommand] subscribeNext:^(RACCommand * command) {
//        [[command execute:nil] subscribeNext:^(id x) {
//            NSLog(@"success");
//        } error:^(NSError *error) {
//            NSLog(@"error %@",error);
//        }];
//
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
