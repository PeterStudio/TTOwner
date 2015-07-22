//
//  TTViewModel.h
//  TTOwner
//
//  Created by Baby on 15/7/22.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "RVMViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveViewModel/ReactiveViewModel.h>

@interface TTViewModel : RVMViewModel
@property (nonatomic) RACSubject *errors;
@end
