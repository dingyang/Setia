//
//  LoginViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetServerData.h"
#import "SuperAdministratorItem.h"
@interface LoginViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ServerDataDelegate>
{
    NSMutableArray *settingsCellArray;
    UITextField *accountField;
    UITextField *passwordField;
    
    NSArray *dataArray;
    GetServerData *serverDataGetter;
    GetServerData *serverDataGetter_promotionType;
    SuperAdministratorItem *superAdminItem;
    int getterNum;
    
    UIAlertView *alert;
    NSUserDefaults *defaults;
    
    UIActivityIndicatorView  *activiter;
}
@property (nonatomic,retain) UITableView *settingsTableView;
@property (nonatomic,retain) UITableView *blankTableView;

@end
