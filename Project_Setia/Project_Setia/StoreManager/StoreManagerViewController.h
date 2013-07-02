//
//  StoreManagerViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 9/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClerkUserItem.h"
#import "GetServerData.h"
@interface StoreManagerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServerDataDelegate>
{
    UITableView *_tableView;
    NSMutableArray *dataArray;
    
    GetServerData *serverDataGetter;
}
@end
