//
//  TTSearchTableViewCell.h
//  TTOwner
//
//  Created by Baby on 15/9/10.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTSearchTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *indxLab;
@property (strong, nonatomic) IBOutlet UILabel *addresLab;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UIButton *stateBtn;
@property (weak, nonatomic) IBOutlet UIButton *woyaofatuBtn;
@property (weak, nonatomic) IBOutlet UIButton *baojingduBtn;

@end
