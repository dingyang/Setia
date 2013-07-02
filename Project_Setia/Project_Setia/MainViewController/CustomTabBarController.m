//
//  CustomTabBarController.m
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "CustomTabBarController.h"
#import "MainViewController.h"

#define tabBarItemWidth 1024/5.0f
#define tabBarItemHeight 35.0f

@implementation CustomTabBarController

@synthesize viewControllers;
@synthesize selectedIndex;
@synthesize lastIndex;
@synthesize buttons;

- (void)viewDidLoad
{
   // NSLog(@"customTabBar--viewDidLoad is called");
    [super viewDidLoad];
    
    buttons = [[NSMutableArray alloc] initWithCapacity:0];
    buttonItemNameArray = [[NSMutableArray alloc]initWithObjects:@"Retail chain",@"Sales",@"Customer",@"Dictionary",@"Settings",nil];
    [self initImage];
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 733, 1024, 35)];
    bottomView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bottomView];
    [bottomView release];
    
    //创建5个button
    [self createButton:CGRectMake(0, 0, tabBarItemWidth, tabBarItemHeight) buttonIndex:0];
    [self createButton:CGRectMake(tabBarItemWidth, 0, tabBarItemWidth, tabBarItemHeight) buttonIndex:1];
    [self createButton:CGRectMake(tabBarItemWidth*2, 0, tabBarItemWidth, tabBarItemHeight) buttonIndex:2];
    [self createButton:CGRectMake(tabBarItemWidth*3, 0, tabBarItemWidth, tabBarItemHeight) buttonIndex:3];
    [self createButton:CGRectMake(tabBarItemWidth*4, 0, tabBarItemWidth, tabBarItemHeight) buttonIndex:4];
    
    lastIndex = -1;
    selectedIndex = 0;
}

//根据被点击的tab的index值，显示相关的ViewController，并移除旧的ViewController
-(void)setImageAndChangeView:(int)buttonIndex
{
    //更改button的图片
    UIButton *selectedButton = [buttons objectAtIndex:buttonIndex];
    UIViewController *selectedViewController = [viewControllers objectAtIndex:buttonIndex];
    if(lastIndex != -1)
    {
        UIButton *lastSelectedButton = [buttons objectAtIndex:lastIndex];
//        [lastSelectedButton setImage:[normalImageArray objectAtIndex:lastIndex] forState:UIControlStateNormal];
        [lastSelectedButton setBackgroundImage:[normalImageArray objectAtIndex:lastIndex] forState:UIControlStateNormal];
        UIViewController *lastViewController = [viewControllers objectAtIndex:lastIndex];
        [lastViewController.view removeFromSuperview];
        [lastViewController removeFromParentViewController];
    }
//    [selectedButton setImage:[selectedImageArray objectAtIndex:buttonIndex] forState:UIControlStateNormal];
//    [selectedButton setImage:[selectedImageArray objectAtIndex:buttonIndex] forState:UIControlStateHighlighted];
    [selectedButton setBackgroundImage:[selectedImageArray objectAtIndex:buttonIndex] forState:UIControlStateHighlighted];
    [selectedButton setBackgroundImage:[selectedImageArray objectAtIndex:buttonIndex] forState:UIControlStateNormal];
    selectedViewController.view.frame = CGRectMake(0, 0, 1024, 733);
    
    [self.delegate changeSelectedViewController:selectedViewController];
    lastIndex = selectedIndex;
}

//某个button被点击时，更改它的背景图片，并显示相关的view
-(void)click:(UIButton *)button
{
    selectedIndex = [buttons indexOfObject:button];
    [self setImageAndChangeView:selectedIndex];
}

//根据图片名称，生成普通和高亮两个图片数组
-(void)initImage
{
    UIImage *image1 = [UIImage imageNamed:@"bgd-menu-admin-normal.png"];
    UIImage *image2 = [UIImage imageNamed:@"bgd-menu-sales-normal.png"];
    UIImage *image3 = [UIImage imageNamed:@"bgd-menu-customers-normal.png"];
    UIImage *image4 = [UIImage imageNamed:@"bgd-menu-query-normal.png"];
    UIImage *image5 = [UIImage imageNamed:@"bgd-menu-settings-normal.png"];
    normalImageArray = [[NSArray alloc] initWithObjects:image1,image2,image3,image4,image5,nil];
    
    UIImage *imageH1 = [UIImage imageNamed:@"bgd-menu-admin-active.png"];
    UIImage *imageH2 = [UIImage imageNamed:@"bgd-menu-sales-active.png"];
    UIImage *imageH3 = [UIImage imageNamed:@"bgd-menu-customers-active.png"];
    UIImage *imageH4 = [UIImage imageNamed:@"bgd-menu-query-active.png"];
    UIImage *imageH5 = [UIImage imageNamed:@"bgd-menu-settings-active.png"];
    selectedImageArray = [[NSArray alloc] initWithObjects:imageH1,imageH2,imageH3,imageH4, imageH5,nil];
}
//根据提供的frame和index创建button，并对比button进行添加等操作
-(void)createButton:(CGRect)aFrame buttonIndex:(int)aIndex
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    button.frame = aFrame;
    button.tag = aIndex;
    UIImage *image =[normalImageArray objectAtIndex:aIndex];
//    [button setImage:image forState:UIControlStateNormal];
//    [button setImage:image forState:UIControlStateHighlighted];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateHighlighted];
 //   [button setTitle:[buttonItemNameArray objectAtIndex:aIndex] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomView addSubview:button];
    [buttons addObject:button];
}

//当tabBar被显示好了以后，加载第一个视图(Best)
-(void)viewWillAppear:(BOOL)animated
{
    [self setImageAndChangeView:selectedIndex];
}

- (void)dealloc {
    [buttons release];
    [buttonItemNameArray release];
    [normalImageArray release];
    [selectedImageArray release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
