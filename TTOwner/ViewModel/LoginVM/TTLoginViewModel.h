//
//  TTLoginViewModel.h
//  TTOwner
//
//  Created by Baby on 15/7/22.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTViewModel.h"

@interface TTLoginViewModel : TTViewModel
@property(nonatomic, strong) RACCommand *loginCommand;
@property(nonatomic, strong) NSString *phoneNumber;
@property(nonatomic, strong) NSString *password;
@end
