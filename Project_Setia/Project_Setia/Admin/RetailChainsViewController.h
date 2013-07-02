//
//  RetailChainsViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetServerData.h"
@interface RetailChainsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServerDataDelegate,UIScrollViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *dataArray;
    
    GetServerData *serverDataGetter;
    
    UIActivityIndicatorView  *activiter;
}


@end
