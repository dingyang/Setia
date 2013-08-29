//
//  ChangePasswordViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 24/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostDataToServer.h"
@interface ChangePasswordViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PostServerDataDelegate,UIAlertViewDelegate>{
    NSMutableArray *textLableNames;
    
    UITextField *accountField;
    UITextField *emailField;
    
    NSMutableArray *postToServerDataArray;
    NSArray *serverKeysArray;
    UIAlertView *alert;
    
}
@property (nonatomic,retain) UITableView *_tableView;
@property (nonatomic,retain) UITableView *blankTableView;
@end
