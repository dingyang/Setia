//
//  TopUpView.h
//  Project_Setia
//
//  Created by Ding Yang on 25/7/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopUpView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UITableView *_tableView;
}
@property (nonatomic ,retain) UITextField *prepaidTF;
@end
