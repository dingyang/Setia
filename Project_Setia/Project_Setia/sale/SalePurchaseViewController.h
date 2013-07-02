//
//  SalePurchaseViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 8/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerItem.h"
#import "SaleItem.h"
#import "PostDataToServer.h"
@interface SalePurchaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,PostServerDataDelegate,UIScrollViewDelegate>
{
    NSMutableArray *purchaseCellArray;
    UITextField *detailField;
    UITextView *commentsTextView;
    NSMutableArray *postToServerDataArray;
    NSArray *serverKeysArray;
}
@property (nonatomic,retain) CustomerItem *customerItem;
@property (nonatomic,retain) UITableView *PurchaseTableView;
@property (nonatomic,retain) SaleItem *saleItem;
@property (nonatomic,retain) NSString *customerFirstName;
@property (nonatomic,retain) NSString *customerLastName;
@property (nonatomic,retain) NSString *discount;
@property (nonatomic,retain) NSString *store;
@property (nonatomic,retain) NSString *user;
@property (nonatomic,retain) NSString *purchaseAmount;
@property (nonatomic,retain) NSString *netAmount;
@property (nonatomic,retain) NSString *pointsRedeemed;
@property (nonatomic,retain) NSString *comments;
@property (nonatomic,retain) NSString *customerId;
@property (nonatomic,retain) NSString *customerCountryCode;
@property (nonatomic,retain) NSString *customerPhoneNumber;
@end
