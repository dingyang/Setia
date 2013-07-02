//
//  RetailChainDetailsViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 6/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetailChainItem.h"
#import "PostDataToServer.h"
@interface RetailChainDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PostServerDataDelegate>
{
    NSMutableArray *leftCellArray;
    NSMutableArray *rightCellArray;
    NSMutableArray *leftCellTextFeildArray;
    NSMutableArray *rightCellTextFeildArray;
    
    NSMutableArray *postToServerDataArray;
    NSArray *serverKeysArray;
    
    void(^saveCb)(RetailChainItem *rcItem);
    RetailChainItem *rcItem;
}
@property (nonatomic,retain) RetailChainItem *retailChainItem;
@property (nonatomic,readwrite) BOOL isUpdateRetailChain;
@property (nonatomic,retain) UITableView *leftTableView;
@property (nonatomic,retain) UITableView *rightTableView;

-(void)addParentViewControllerUserListItem:(void(^)(RetailChainItem *rcItem))cb;

@end


