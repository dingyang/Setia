//
//  StoreUserDetailsViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 8/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreUserItem.h"
#import "PostDataToServer.h"
#import "GetServerData.h"
@interface StoreUserDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PostServerDataDelegate,ServerDataDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray *leftCellArray;
    NSMutableArray *rightCellArray;
    UITextField *detailField;
    
    NSMutableArray *postToServerDataArray;
    NSArray *serverKeysArray;
    
    NSUserDefaults *defaults;
    UILabel *storeManagerLabel;
    UILabel *chainNameLabel;
    UIButton *selectStoreNameButton;
    NSMutableArray *getStoreNamesArray;
    BOOL storeNameButtonIsRetouched;
    NSMutableArray *storeNamesPickerViewArray;
    UIPickerView *storeNamesPickerView;
    NSString *selectedstoreId;
    
    void(^saveCb)(StoreUserItem *stUserItem);
    StoreUserItem *stUserItem;
}
@property (nonatomic,retain) StoreUserItem *storeUserItem;
@property (nonatomic,readwrite) BOOL isUpdateStoreUser;
@property (nonatomic,retain) UITableView *leftTableView;
@property (nonatomic,retain) UITableView *rightTableView;
@property (nonatomic,readwrite) NSInteger roleValue;

-(void)addParentViewControllerUserListItem:(void(^)(StoreUserItem *stUserItem))cb;
@end
