//
//  CustomerViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetServerData.h"
#import "CustomerCellView.h"
@interface CustomerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServerDataDelegate>
{
    UITableView *_tableView;
    NSArray *dataArray;
    UISearchBar *customerSerch;
    UIBarButtonItem *addCustomerButtonItem;
    UIBarButtonItem *serchButtonItem;
    UIBarButtonItem *cancelSerchButtonItem;
    NSArray *buttonsArray;
    GetServerData *serverDataGetter;
    CustomerCellView *cellView;
}

@end
