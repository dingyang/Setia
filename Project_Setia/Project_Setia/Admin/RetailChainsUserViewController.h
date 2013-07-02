//
//  RetailChainsUserViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 7/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetServerData.h"
@interface RetailChainsUserViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServerDataDelegate>
{
    UITableView *_tableView;
    NSMutableArray *dataArray;
    
    GetServerData *serverDataGetter;
    
    UIActivityIndicatorView  *activiter;
}
@end
