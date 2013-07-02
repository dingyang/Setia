//
//  MainViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "RetailChainsViewController.h"
#import "CustomerViewController.h"
#import "DictionaryViewController.h"
#import "LogoutViewController.h"
#import "CustomTabBarController.h"
#import "SaleViewController.h"

@class CustomTabBarController;
@interface MainViewController : UIViewController<CustomTabBarDelegate>
@property (nonatomic,retain) CustomTabBarController *tabBarController;
@property (nonatomic,readwrite) NSInteger roleValue;

@end
