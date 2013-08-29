//
//  SaleViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 3/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerItem.h"
#import "GetServerData.h"
#import "CustomerCellView.h"
#import "CustomerItem.h"
#import "SalePurchaseViewController.h"
#import "SalePurchasePointsViewController.h"
#import "SalePurchasePrepaidViewController.h"
#import "TopUpView.h"
#import "PutDataToServer.h"
@interface SaleViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServerDataDelegate,PutServerDataDelegate,UIAlertViewDelegate>
{
    NSMutableArray *leftCellArray;
    NSMutableArray *rightCellArray;
    UITextField *detailField;
    
    UITextField *codeField;
    UITextField *phoneField;
    
    GetServerData *serverDataGetter;
    CustomerCellView *cellView;
    CustomerItem *customerItem;
        
    NSArray *dataArray;
    
    UITextField *firstNameField;
    UITextField *lastNameField;
    UITextField *countryField;
    UITextField *emailField;
    UITextField *mobileField;
    UITextField *dateField;
    
    BOOL isQueryBtnPressed;
    BOOL isQuerySuccessful;
    
    SalePurchaseViewController *salePurchaseVcl;
    SalePurchasePointsViewController *salePurchasePointsVcl;
    SalePurchasePrepaidViewController *salePurchasePrepaidVcl;
    
    TopUpView *topView;
    UIButton *topUpButton;
    UIAlertView *prepaidAlert;
}
@property (nonatomic,retain) CustomerItem *customerItem;
@property (nonatomic,retain) UITableView *leftTableView;
@property (nonatomic,retain) UITableView *rightTableView;


@end
