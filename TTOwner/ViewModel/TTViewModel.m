//
//  TTViewModel.m
//  TTOwner
//
//  Created by Baby on 15/7/22.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTViewModel.h"

@implementation TTViewModel
- (id)init
{
    self = [super init];
    if (self) {
        _errors = [[RACSubject subject] setNameWithFormat:@"%@ -errors", self];
    }
    
    return self;
}

- (void)dealloc
{
    [_errors sendCompleted];
}
@end
