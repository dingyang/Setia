//
//  RetailChainUserDetailsViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 7/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetailChainUserItem.h"
#import "PostDataToServer.h"
#import "GetServerData.h"
@interface RetailChainUserDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PostServerDataDelegate,ServerDataDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray *leftCellArray;
    NSMutableArray *rightCellArray;
    UITextField *detailField;
    
    UIBarButtonItem *userUpdateButtonItem;
    UIBarButtonItem *userSaveButtonItem;
    
    NSMutableArray *postToServerDataArray;
    NSArray *serverKeysArray;
    
    NSUserDefaults *defaults;
    UILabel *chainManagerLabel;
    UIButton *selectChainNameButton;
    NSArray *getChainNamesArray;
    BOOL chainNameButtonIsRetouched;
    NSMutableArray *chainNamesPickerViewArray;
    UIPickerView *chainNamesPickerView;
    NSString *selectedChainId;
    
    void(^saveCb)(RetailChainUserItem *rcUserItem);
    RetailChainUserItem *rcUserItem;
}
@property (nonatomic,retain) RetailChainUserItem *retailChainUserItem;
@property (nonatomic,readwrite) BOOL isUpdateRetailChainUser;
@property (nonatomic,retain) UITableView *leftTableView;
@property (nonatomic,retain) UITableView *rightTableView;
@property (nonatomic,readwrite) NSInteger roleValue;

-(void)addParentViewControllerUserListItem:(void(^)(RetailChainUserItem *rcUserItem))cb;
@end
