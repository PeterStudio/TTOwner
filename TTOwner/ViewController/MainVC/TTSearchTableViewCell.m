//
//  TTSearchTableViewCell.m
//  TTOwner
//
//  Created by Baby on 15/9/10.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTSearchTableViewCell.h"

@implementation TTSearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _stateBtn.layer.masksToBounds = YES;
    _stateBtn.layer.cornerRadius = 4.0f;
    
    _woyaofatuBtn.layer.masksToBounds = YES;
    _woyaofatuBtn.layer.cornerRadius = 4.0f;
    
    _baojingduBtn.layer.masksToBounds = YES;
    _baojingduBtn.layer.cornerRadius = 4.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
