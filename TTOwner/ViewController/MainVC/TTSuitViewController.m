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
@property (weak, nonatomic) IBOutlet UILabel *placeholdLab;

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
}

- (void)textViewDidChange:(UITextView *)textView{
    _placeholdLab.hidden = textView.text.length > 0;
    if (textView.markedTextRange == nil && textView.text.length > 200) {
        NSString * str = textView.text;
        textView.text = [str substringToIndex:200];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];return NO;
    }
    return YES;
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
