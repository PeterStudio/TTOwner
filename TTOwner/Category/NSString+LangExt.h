//
//  NSString+LangExt.h
//  TTOwner
//
//  Created by Baby on 15/7/22.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LangExt)

/***************************************
 *  检验
 **************************************/

/**
 *  验证手机号有效性
 *
 *  @return
 */
- (BOOL)validChinesePhoneNumber;

/**
 *  验证密码有效性，6-16数字和字母组合
 *
 *  @return
 */
- (BOOL)validPassword;

- (NSString *) stringFromMD5;

@end
