//
//  NSString+LangExt.m
//  TTOwner
//
//  Created by Baby on 15/7/22.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "NSString+LangExt.h"
#import <CommonCrypto/CommonDigest.h>

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

- (NSString *) stringFromMD5{
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}
@end
