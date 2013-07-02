//
//  CustomTabBarController.h
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomTabBarDelegate;
@interface CustomTabBarController : UIViewController
{
    NSArray *normalImageArray;
    NSArray *selectedImageArray;
    NSMutableArray *buttonItemNameArray;
    UIView *bottomView;
}
@property (nonatomic,retain) NSMutableArray *buttons;
@property (nonatomic,retain) NSArray *viewControllers;
@property (nonatomic,readwrite) int selectedIndex;
@property (nonatomic,readonly) int lastIndex;
@property (nonatomic,retain) id <CustomTabBarDelegate> delegate;

-(void)click:(UIButton *)button;
-(void)setImageAndChangeView:(int)buttonIndex;
-(void)initImage;
-(void)createButton:(CGRect)aFrame buttonIndex:(int)aIndex;
@end

@protocol CustomTabBarDelegate <NSObject>
-(void)changeSelectedViewController:(UIViewController*)vcl;
@end