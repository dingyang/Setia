//
//  DictionaryViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerView.h"
#import "GetServerData.h"
@interface DictionaryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServerDataDelegate>
{
    NSMutableArray *rightCellArray;
    UIDatePicker *datePicker;
    
    NSMutableArray *dataArray;
    GetServerData *serverDataGetter;
}
@property (nonatomic,retain) UITableView *leftTableView;
@property (nonatomic,retain) UITableView *rightTableView;
@property (nonatomic,retain) NSString *dateString;
@end
