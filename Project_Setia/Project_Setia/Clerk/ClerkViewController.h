//
//  ClerkViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 9/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClerkViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *dataArray;
}
@property (nonatomic,retain) UITableView *settingsTableView;
@property (nonatomic,retain) UITableView *blankTableView;
@end
