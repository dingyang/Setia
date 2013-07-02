//
//  ClerkUserDetailsViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 8/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClerkUserItem.h"
#import "PostDataToServer.h"
@interface ClerkUserDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PostServerDataDelegate>
{
    NSMutableArray *leftCellArray;
    NSMutableArray *rightCellArray;
    UITextField *detailField;
    
    NSMutableArray *postToServerDataArray;
    NSArray *serverKeysArray;
    
    NSUserDefaults *defaults;
    UILabel *clerkLabel;
    UILabel *chainNameLabel;
    UILabel *storeNameLabel;
    void(^saveCb)(ClerkUserItem *clerkUserItem);
    ClerkUserItem *clerkUserItem;
}
@property (nonatomic,retain) ClerkUserItem *clerkUserItem;
@property (nonatomic,readwrite) BOOL isUpdateClerkUser;
@property (nonatomic,retain) UITableView *leftTableView;
@property (nonatomic,retain) UITableView *rightTableView;
@property (nonatomic,readwrite) NSInteger roleValue;

-(void)addParentViewControllerUserListItem:(void(^)(ClerkUserItem *clerkUserItem))cb;
@end

