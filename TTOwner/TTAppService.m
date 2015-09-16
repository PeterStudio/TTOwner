//
//  TTAppService.m
//  TTOwner
//
//  Created by duwen on 15/9/9.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "TTAppService.h"
#import "NSString+LangExt.h"

static TTAppService * shareAppServiceManagerInstance = nil;
static dispatch_once_t predicate;

#define SERVICE(x) [NSString stringWithFormat:@"http://118.26.129.11:8080/platform/decorateForman/%@",x]

@implementation TTAppService
+ (TTAppService *)sharedManager{
    dispatch_once(&predicate, ^{
        shareAppServiceManagerInstance = [[self alloc] init];
    });
    return shareAppServiceManagerInstance;
}


// 3.1.1	用户登录注册
- (void)request_Login_Http_username:(NSString *)_username
                                pas:(NSString *)_pas
                             system:(NSString *)_system
                            version:(NSString *)_version
                               imei:(NSString *)_imei
                                lat:(NSString *)_lat
                                lng:(NSString *)_lng
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"username":_username
                              ,@"pas":[_pas stringFromMD5]
                              ,@"system":_system
                              ,@"version":_version
                              ,@"imei":_imei
                              ,@"type":@"0"
                              ,@"lat":_lat
                              ,@"lng":_lng};
    NSLog(@"params=%@",params);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager POST:SERVICE(@"login.do") parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


- (void)request_modifyInfo_Http_userId:(NSString *)_userId
                                oldPwd:(NSString *)_oldPwd
                                   pwd:(NSString *)_pwd
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERDATA"];
    NSDictionary * params = @{@"userId":dic[@"userId"]
                              ,@"oldPwd":_oldPwd
                              ,@"pwd":_pwd};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager POST:SERVICE(@"modifyInfo.do") parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)request_queryInfo_Http_userId:(NSString *)_userId
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSError *error))failure{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERDATA"];
    NSDictionary * params = @{@"userId":dic[@"userId"]};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager POST:SERVICE(@"queryInfo.do") parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.4	投诉建议
- (void)request_feedback_Http_userId:(NSString *)_userId
                             content:(NSString *)_content
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERDATA"];
    NSDictionary * params = @{@"userId":dic[@"userId"],@"content":_content};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:SERVICE(@"feedback.do") parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 3.1.5	版本更新
- (void)request_update_Http_version:(NSString *)_version
                               type:(NSString *)_type
                               imei:(NSString *)_imei
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure{
    NSDictionary * params = @{@"version":_version,@"type":_type,@"imei":_imei};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    NSLog(@"params %@",params);
    [manager POST:SERVICE(@"update.do") parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)request_constructionSite_Http_userId:(NSString *)_userId
                                     success:(void (^)(id responseObject))success
                                     failure:(void (^)(NSError *error))failure{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERDATA"];
    NSDictionary * params = @{@"userId":dic[@"userId"]};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager POST:SERVICE(@"constructionSite.do") parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)request_reservationQuery_Http_userId:(NSString *)_userId
                                        page:(NSString *)_page
                                         num:(NSString *)_num
                                   queryTime:(NSString *)_queryTime
                                     success:(void (^)(id responseObject))success
                                     failure:(void (^)(NSError *error))failure{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERDATA"];
    NSDictionary * params = nil;
    if ([@"FIRST" isEqualToString:_queryTime]) {
        params = @{@"userId":dic[@"userId"],@"page":_page,@"num":_num};
    }else{
        params = @{@"userId":dic[@"userId"],@"page":_page,@"num":_num,@"queryTime":_queryTime};
    }
    
    NSLog(@"params = %@",params);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager POST:SERVICE(@"reservationQuery.do") parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


- (void)request_rechargeRecord_Http_userId:(NSString *)_userId
                                        page:(NSString *)_page
                                         num:(NSString *)_num
                                   queryTime:(NSString *)_queryTime
                                     success:(void (^)(id responseObject))success
                                     failure:(void (^)(NSError *error))failure{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERDATA"];
    NSDictionary * params = nil;
    if ([@"FIRST" isEqualToString:_queryTime]) {
        params = @{@"userId":dic[@"userId"],@"page":_page,@"num":_num};
    }else{
        params = @{@"userId":dic[@"userId"],@"page":_page,@"num":_num,@"queryTime":_queryTime};
    }
    
    NSLog(@"params = %@",params);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager POST:SERVICE(@"rechargeRecord.do") parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


- (void)request_payMoney_Http_userId:(NSString *)_userId money:(NSString *)_money type:(NSString *)_type success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERDATA"];
    NSDictionary * params = @{@"userId":dic[@"userId"],@"money":_money,@"type":_type};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [manager POST:SERVICE(@"payMoney.do") parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


- (void)request_PRE_Http_success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//设置相应内容类型 
    [manager GET:@"http://pre.im/api/v1/app/install?app_key=0466bba6f1d939109337fa2af99e6a8e" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
