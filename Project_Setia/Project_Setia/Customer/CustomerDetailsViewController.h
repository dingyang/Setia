//
//  CustomerDetailsViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 7/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerItem.h"
@interface CustomerDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *leftCellArray;
    NSMutableArray *rightCellArray;
    UITextField *detailField;
}
@property (nonatomic,retain) CustomerItem *customerItem;
@property (nonatomic,retain) UITableView *leftTableView;
@property (nonatomic,retain) UITableView *rightTableView;
@end
