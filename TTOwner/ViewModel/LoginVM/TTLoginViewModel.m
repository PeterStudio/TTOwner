//
//  TTLoginViewModel.m
//  TTOwner
//
//  Created by Baby on 15/7/22.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTLoginViewModel.h"
#import "NSString+LangExt.h"

@interface TTLoginViewModel ()
@property(nonatomic, strong) RACSignal *phoneValidSignal;
@property(nonatomic, strong) RACSignal *passwordValidSignal;
@end

@implementation TTLoginViewModel

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (RACCommand *)loginCommand{
    if (!_loginCommand) {
        @weakify(self);
        _loginCommand = [[RACCommand alloc] initWithEnabled:[RACSignal combineLatest:@[self.phoneValidSignal,self.passwordValidSignal] reduce:^(NSNumber * phoneValid, NSNumber * passwordValid){
            return @([phoneValid boolValue]&&[passwordValid boolValue]);
        }] signalBlock:^RACSignal *(id input) {
//            @strongify(self);
            return [RACSignal empty];//[SubscribeViewModel postEmail:self.email];
        }];
    }
    return _loginCommand;
}

- (RACSignal *)phoneValidSignal{
    if (!_phoneValidSignal) {
        _phoneValidSignal = [RACObserve(self, phoneNumber) map:^id(NSString * value) {
            return @([value validChinesePhoneNumber]);
        }];
    }
    return _phoneValidSignal;
}

- (RACSignal *)passwordValidSignal{
    if (!_passwordValidSignal) {
        _passwordValidSignal = [RACObserve(self, password) map:^id(NSString * value) {
            return @([value validPassword]);
        }];
    }
    return _passwordValidSignal;
}
@end
