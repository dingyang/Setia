//
//  MainViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "MainViewController.h"
#import "RetailChainManagerViewController.h"
#import "StoreManagerViewController.h"
#import "ClerkViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize tabBarController;
@synthesize roleValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    RetailChainsViewController *chains = [[RetailChainsViewController alloc]init];
    SaleViewController *sale = [[SaleViewController alloc]init];
    CustomerViewController *custom = [[ CustomerViewController alloc]init];
    DictionaryViewController *dictionary = [[DictionaryViewController alloc]init];
    LogoutViewController *logout = [[LogoutViewController alloc]init];
    RetailChainManagerViewController *retailChainManager = [[RetailChainManagerViewController alloc]init];
    StoreManagerViewController *storeManager = [[StoreManagerViewController alloc]init];
    ClerkViewController *clerk = [[ClerkViewController alloc]init];
    
    UINavigationController *chainsNav = [[UINavigationController alloc]initWithRootViewController:chains];
    UINavigationController *saleNav = [[UINavigationController alloc]initWithRootViewController:sale];
    UINavigationController *customNav = [[UINavigationController alloc]initWithRootViewController:custom];
    UINavigationController *dictionaryNav = [[UINavigationController alloc]initWithRootViewController:dictionary];
    UINavigationController *logoutNav = [[UINavigationController alloc]initWithRootViewController:logout];
    UINavigationController *retailChainManagerNav = [[UINavigationController alloc]initWithRootViewController:retailChainManager];
    UINavigationController *storeManagerNav = [[UINavigationController alloc]initWithRootViewController:storeManager];
    UINavigationController *clerkNav = [[UINavigationController alloc]initWithRootViewController:clerk];
    
    NSArray *adminItemsArray = [[NSArray alloc]initWithObjects:chainsNav,saleNav,customNav,dictionaryNav,logoutNav,nil];
    NSArray *retailChainManagerItemsArray = [[NSArray alloc]initWithObjects:retailChainManagerNav,saleNav,customNav,dictionaryNav,logoutNav,nil];
    NSArray *storeManagerItemsArray = [[NSArray alloc]initWithObjects:storeManagerNav,saleNav,customNav,dictionaryNav,logoutNav,nil];
    NSArray *clerkItemsArray = [[NSArray alloc]initWithObjects:clerkNav,saleNav,customNav,dictionaryNav,logoutNav,nil];
    
    tabBarController = [[CustomTabBarController alloc]init];
    tabBarController.delegate = self;
    tabBarController.selectedIndex = 0;
    switch (roleValue)
    {
        case 0:
            tabBarController.viewControllers = clerkItemsArray;
            break;
        case 1:
            tabBarController.viewControllers = storeManagerItemsArray;
            break;
        case 2:
            tabBarController.viewControllers = retailChainManagerItemsArray;
            break;
        default:
            tabBarController.viewControllers = adminItemsArray;
            break;
    }
    [self addChildViewController:tabBarController];
    [self.view addSubview:tabBarController.view];
    
    [chains release];
    [custom release];
    [dictionary release];
    [logout release];
    
    [chainsNav release];
    [customNav release];
    [dictionaryNav release];
    [logoutNav release];
    [adminItemsArray release];
    [retailChainManagerItemsArray release];
    [storeManagerItemsArray release];
    [clerkItemsArray release];
    [tabBarController release];
}
-(void)changeSelectedViewController:(UIViewController *)vcl
{
    [self.view addSubview:vcl.view];
    [self addChildViewController:vcl];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
