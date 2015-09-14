//
//  AppDelegate.m
//  TTOwner
//
//  Created by Baby on 15/7/22.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import "AppDelegate.h"
#import "Macros.h"

#import "TTAppService.h"

#import <AdSupport/AdSupport.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.window.backgroundColor = [UIColor whiteColor];
//    TTLoginViewViewController * loginVC = [[TTLoginViewViewController alloc] init];
//
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadRootView) name:@"ROOTVIEWCONTROLLER" object:nil];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSDictionary * jsonDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERDATA"];
    UINavigationController * nav;
    if (jsonDic) {
        nav = [storyboard instantiateViewControllerWithIdentifier:@"RootNav"];
    }else{
        nav = [storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
    }
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
//    [self updateVersion];
    return YES;
}

- (void)reloadRootView{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController * nav = [storyboard instantiateViewControllerWithIdentifier:@"RootNav"];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
}


- (void)updateVersion{
    NSString *curVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (!curVersion) {
        curVersion=@"1.0";
    }
    NSString *imeiStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [[TTAppService sharedManager] request_update_Http_version:curVersion type:@"1" imei:imeiStr success:^(id responseObject) {
        NSDictionary * jsonObject = responseObject;
        if ([@"000000" isEqualToString:jsonObject[@"retcode"]]) {
            NSDictionary * doc = jsonObject[@"doc"];
            if ([@"0" isEqualToString:doc[@"isUpdate"]]) {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"有新版本~" message:doc[@"content"] delegate:self cancelButtonTitle:@"稍后更新" otherButtonTitles:@"更新", nil];
                alert.tag = 100;
                [alert show];
            }else{
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"有新版本~" message:doc[@"content"] delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
                alert.tag = 101;
                [alert show];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
