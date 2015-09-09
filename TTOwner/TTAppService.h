//
//  TTAppService.h
//  TTOwner
//
//  Created by duwen on 15/9/9.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface TTAppService : NSObject
+ (TTAppService *)sharedManager;
// 3.1.1	用户登录注册
- (void)request_Login_Http_username:(NSString *)_username
                                pas:(NSString *)_pas
                             system:(NSString *)_system
                            version:(NSString *)_version
                               imei:(NSString *)_imei
                                lat:(NSString *)_lat
                                lng:(NSString *)_lng
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;


- (void)request_modifyInfo_Http_userId:(NSString *)_userId
                                oldPwd:(NSString *)_oldPwd
                                   pwd:(NSString *)_pwd
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure;

- (void)request_queryInfo_Http_userId:(NSString *)_userId
                                      success:(void (^)(id responseObject))success
                                      failure:(void (^)(NSError *error))failure;

// 3.1.4	投诉建议
- (void)request_feedback_Http_userId:(NSString *)_userId
                             content:(NSString *)_content
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;

// 3.1.5	版本更新
- (void)request_update_Http_version:(NSString *)_version
                               type:(NSString *)_type
                               imei:(NSString *)_imei
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError *error))failure;

- (void)request_constructionSite_Http_userId:(NSString *)_userId
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSError *error))failure;

- (void)request_reservationQuery_Http_userId:(NSString *)_userId
                                  page:(NSString *)_page
                                   num:(NSString *)_num
                             queryTime:(NSString *)_queryTime
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError *error))failure;


@end
