//
//  WelComeViewController.m
//  MirLiDoctor
//
//  Created by duwen on 15/1/27.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "WelComeViewController.h"

#define NUMPAGE     3
#define UIScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define UIScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface WelComeViewController ()

@end

@implementation WelComeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView * bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page_loading"]];
    [bgImageView setFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [self.view addSubview:bgImageView];
    
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, UIScreenHeight - 10, UIScreenWidth, 10)];
    
    self.pageControl.numberOfPages = NUMPAGE;
    self.pageControl.currentPage = 0;
    self.pageControl.enabled = NO;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [self.scrollView setContentSize:CGSizeMake(UIScreenWidth * NUMPAGE, UIScreenHeight)];
    [self.scrollView setBackgroundColor:[UIColor clearColor]];
    [self.scrollView setDelegate:self];
    [self.scrollView setUserInteractionEnabled:YES];
    [self.scrollView setDirectionalLockEnabled:YES];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setBounces:NO];
    [self.view addSubview:self.scrollView];
    
    [self.view addSubview:self.pageControl];
    [self initWithGuideImageView:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    
}


- (void)initWithGuideImageView:(CGRect)frame{
    for (int i = 0; i < NUMPAGE; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"guide_%d",i + 1]]];
        [imgView setFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];
        [self.scrollView addSubview:imgView];
        
        if (i == NUMPAGE - 1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(frame.size.width * (NUMPAGE - 1) + frame.size.width / 2 - 166 / 2, frame.size.height - 40 - 10, 166, 40)];
            [btn setTitle:@"进入应用" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(goToMainViewController) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:btn];
        }
    }
}

- (void)goToMainViewController{
    self.pageControl.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(enterButtonPressed)]) {
        [self.delegate enterButtonPressed];
    }
//    [UIView animateWithDuration:0.9 animations:^{
//        CGAffineTransform transform = CGAffineTransformMakeScale(2.5, 2.5);
//        self.scrollView.transform = transform;
//        self.scrollView.alpha = 0;
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.35 animations:^{
//            
//        } completion:^(BOOL finished) {
//            if (self.delegate && [self.delegate respondsToSelector:@selector(enterButtonPressed)]) {
//                [self.delegate enterButtonPressed];
//            }
//        }];
//    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index = fabs(_scrollView.contentOffset.x)/UIScreenWidth;
    self.pageControl.currentPage = index;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
