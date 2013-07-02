//
//  StoreUserViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 8/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetServerData.h"
@interface StoreUserViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServerDataDelegate>
{
    UITableView *_tableView;
    NSMutableArray *dataArray;
    
    GetServerData *serverDataGetter;
}


@end
