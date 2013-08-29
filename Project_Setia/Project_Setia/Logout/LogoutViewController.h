//
//  LogoutViewController.h
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PutDataToServer.h"
#import "GetServerData.h"
#import "RetailChainItem.h"
#import "StoreItem.h"
@interface LogoutViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PutServerDataDelegate,UIAlertViewDelegate,UITextFieldDelegate,ServerDataDelegate>
{
    GetServerData *serverDataGetter_store;
    GetServerData *serverDataGetter_merchant;
    NSMutableArray *merchantOrStoreInforListArray;
    NSArray *dataOfGet;
    RetailChainItem *retailChainItem;
    StoreItem *storeItem;
    
    NSMutableArray *settingsCell;
    NSMutableArray *settingsCellArray;
    
    NSMutableArray *blankCell;
    NSMutableArray *blankCellInfor;
    NSMutableArray *blankCellGeneral;
    NSMutableArray *blankCellAddress;
    NSMutableArray *blankCellArray;
    
    UITextField *detailField;
    NSInteger selectedCellIndex;
    
    UIButton *submitButton;
    
    UIAlertView *successAlert;
    UIAlertView *modifyInforAlert;
    UIAlertView *modifyInforFailedAlert;
    
    UITableViewCell *nameCell;
    UITableViewCell *descriptionCell;
    UITableViewCell *emailCell;
    UITableViewCell *urlCell;
    UITableViewCell *promotionTypeCell;
    UITableViewCell *discountCell;
    UITableViewCell *phone1Cell;
    UITableViewCell *phone2Cell;
    UITableViewCell *buildingNameCell;
    UITableViewCell *UnitNumberCell;
    UITableViewCell *StreetNameCell;
    UITableViewCell *LandmarkCell;
    UITableViewCell *postalCodeCell;
    UITableViewCell *countryCell;
    UITableViewCell *cityCell;
    
    UITextField *nameField;
    UITextField *descriptionField;
    UITextField *emailField;
    UITextField *urlField;
    UITextField *promotionTypeField;
    UITextField *discountField;
    UITextField *phone1Field;
    UITextField *phone2Field;
    UITextField *buildingNameField;
    UITextField *UnitNumberField;
    UITextField *StreetNameField;
    UITextField *LandmarkField;
    UITextField *postalCodeField;
    UITextField *countryField;
    UITextField *cityField;
    
}
@property (nonatomic,retain) UITableView *settingsTableView;
@property (nonatomic,retain) UITableView *blankTableView;
@end
