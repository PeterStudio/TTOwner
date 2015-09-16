//
//  WelComeViewController.h
//  MirLiDoctor
//
//  Created by duwen on 15/1/27.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PTDefine.h"

@protocol WelComeViewControllerDelegate <NSObject>

/**
 *  引导页点击立刻体验按钮
 */
- (void)enterButtonPressed;

@end

@interface WelComeViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic,strong) id<WelComeViewControllerDelegate> delegate;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@end
