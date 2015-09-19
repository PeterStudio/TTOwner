//
//  AppDelegate.h
//  TTOwner
//
//  Created by Baby on 15/7/22.
//  Copyright (c) 2015年 duwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <AddressBook/AddressBook.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>{
    int startIndex;
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) CLLocation * currLocation;

@end

