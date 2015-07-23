//
//  TTLoginViewModel.m
//  TTOwner
//
//  Created by Baby on 15/7/22.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTLoginViewModel.h"
#import "NSString+LangExt.h"
#import "AFHTTPRequestOperationManager+RACSupport.h"

static NSString *const kSubscribeURL = @"http://private-anon-7f299ab56-reactivetest.apiary-mock.com/subscribers";// @"http://reactivetest.apiary.io/subscribers";


@interface TTLoginViewModel ()
@property(nonatomic, strong) RACSignal *phoneValidSignal;
@property(nonatomic, strong) RACSignal *passwordValidSignal;
@end

@implementation TTLoginViewModel

- (instancetype)init{
    if (self = [super init]) {
        RACSignal *startedMessageSource = [self.loginCommand.executionSignals map:^id(RACSignal *subscribeSignal) {
            return NSLocalizedString(@"Sending request...", nil);
        }];
        
        RACSignal *completedMessageSource = [self.loginCommand.executionSignals flattenMap:^RACStream *(RACSignal *subscribeSignal) {
            return [[[subscribeSignal materialize] filter:^BOOL(RACEvent *event) {
                return event.eventType == RACEventTypeCompleted;
            }] map:^id(id value) {
                return NSLocalizedString(@"Thanks", nil);
            }];
        }];
        
        RACSignal *failedMessageSource = [[self.loginCommand.errors subscribeOn:[RACScheduler mainThreadScheduler]] map:^id(NSError *error) {
            return NSLocalizedString(@"Error :(", nil);
        }];
        RAC(self, statusMessage) = [RACSignal merge:@[startedMessageSource, completedMessageSource, failedMessageSource]];
        
    }
    return self;
}

- (RACCommand *)loginCommand{
    if (!_loginCommand) {
        @weakify(self);
        _loginCommand = [[RACCommand alloc] initWithEnabled:[RACSignal combineLatest:@[self.phoneValidSignal,self.passwordValidSignal] reduce:^(NSNumber * phoneValid, NSNumber * passwordValid){
            return @([phoneValid boolValue]&&[passwordValid boolValue]);
        }] signalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[[TTLoginViewModel postEmail:@"duwen16@gmail.com"] doNext:^(id x) {
                NSLog(@"x %@",x);
            }] catch:^RACSignal *(NSError *error) {
                // 捕获登录错误
                return [RACSignal error:error];
            }];
        }];
    }
    return _loginCommand;
}

+ (RACSignal *)postEmail:(NSString *)email {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer new];
    NSDictionary *body = @{@"email": email ?: @""};
    return [[[manager rac_POST:kSubscribeURL parameters:body] logError] replayLazily];
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
