//
//  UIButton+LangExt.m
//  TTOwner
//
//  Created by Baby on 15/9/10.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "UIButton+LangExt.h"

@implementation UIButton (LangExt)

- (void)setBackground{
    
    CGSize imageSize = CGSizeMake(15, 15);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [[UIColor whiteColor] set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *nor = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIImage * nor1 = [nor stretchableImageWithLeftCapWidth:4 topCapHeight:4];
    UIImage * sel = [[UIImage imageNamed:@"pay_btn01"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
    [self setBackgroundImage:nor1 forState:UIControlStateNormal];
    [self setBackgroundImage:sel forState:UIControlStateHighlighted];
    [self setBackgroundImage:sel forState:UIControlStateSelected];
    
    [self setTitleColor:[UIColor colorWithRed:232/255.0f green:144/255.0f blue:0.0f alpha:1] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}

@end
