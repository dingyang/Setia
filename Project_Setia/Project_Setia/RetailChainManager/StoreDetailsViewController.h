//
//  StoreDetailsViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 8/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreItem.h"
#import "PostDataToServer.h"
@interface StoreDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PostServerDataDelegate>
{
    NSMutableArray *leftCellArray;
    NSMutableArray *rightCellArray;
    NSMutableArray *leftCellTextFeildArray;
    NSMutableArray *rightCellTextFeildArray;
    
    NSMutableArray *postToServerDataArray;
    NSArray *serverKeysArray;
    
    void(^saveCb)(StoreItem *stItem);
    StoreItem *stItem;
}
@property (nonatomic,retain) StoreItem *storeItem;
@property (nonatomic,readwrite) BOOL isUpdateStore;
@property (nonatomic,retain) UITableView *leftTableView;
@property (nonatomic,retain) UITableView *rightTableView;
-(void)addParentViewControllerUserListItem:(void(^)(StoreItem *stItem))cb;
@end
