//
//  LogoutViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LogoutViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *settingsCellArray;
    
    NSMutableArray *blankCell;
    NSMutableArray *blankCellInfor;
    NSMutableArray *blankCellArray;
    
    UITextField *detailField;
    NSInteger selectedCellIndex;
    
    UIButton *submitButton;
}
@property (nonatomic,retain) UITableView *settingsTableView;
@property (nonatomic,retain) UITableView *blankTableView;
@end
