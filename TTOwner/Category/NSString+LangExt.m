//
//  NSString+LangExt.m
//  TTOwner
//
//  Created by Baby on 15/7/22.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "NSString+LangExt.h"

@implementation NSString (LangExt)

- (BOOL)validChinesePhoneNumber
{
    NSString *numberRegex = @"17[0-9]{9}|13[0-9]{9}|15[0-9]{9}|18[0-9]{9}|145[0-9]{8}|147[0-9]{8}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [numberTest evaluateWithObject:self];
}

- (BOOL)validPassword
{
    NSString *passwordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z._]{6,16}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:self];
}

@end
