//
//  LogoutViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "LogoutViewController.h"
#import "PostDataToServer.h"
#import "RetailChainItem.h"
#import "StoreItem.h"
#import "PostReturnValue.h"
#import "TableViewCell.h"
#import <RestKit/RestKit.h>
#import "PutReturnValue.h"
#import "SuperAdministratorItem.h"
#import "PutDataToServer.h"
#import "GetServerData.h"
@interface LogoutViewController ()

@end

@implementation LogoutViewController
@synthesize settingsTableView;
@synthesize blankTableView;
-(void)dealloc
{
    [settingsTableView release];
    [blankTableView release];
    [settingsCellArray release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Settings";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //初始化静态UITableViewCell;
    [self initUITableViewCell];
    
    //初始化获取Merchant／Store信息列表的数组
    dataOfGet = [[NSArray alloc]init];
    
    settingsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 512, 768-44-35) style:UITableViewStyleGrouped];
    settingsTableView.delegate = self;
    settingsTableView.dataSource = self;
    settingsTableView.scrollEnabled = NO;
    [self.view addSubview:settingsTableView];
    [settingsTableView release];
    
    blankTableView = [[UITableView alloc]initWithFrame:CGRectMake(512, 0, 512, 768-44-35) style:UITableViewStyleGrouped];
    blankTableView.delegate = self;
    blankTableView.dataSource = self;
    blankTableView.scrollEnabled = NO;
    [self.view addSubview:blankTableView];
    [blankTableView release];
    
    UIImageView *setiaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(35,768-44-35-189, 169, 169)];
    [setiaImageView setImage:[UIImage imageNamed:@"logo-setia.png"]];
    [self.view addSubview:setiaImageView];
    [setiaImageView release];
    
    
    //According to different roles sets different Cells(根据不同的角色，设置不同的Cell)
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"] isEqual:@"2"]) {
        settingsCell = [[NSMutableArray alloc]initWithObjects:@"Logout Current Account",@"Change Current Password",@"Modify User Information",@"Modify Merchant Information",nil];
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"] isEqual:@"1"]){
        settingsCell = [[NSMutableArray alloc]initWithObjects:@"Logout Current Account",@"Change Current Password",@"Modify User Information",@"Modify Store Information",nil];
    }else{
        settingsCell = [[NSMutableArray alloc]initWithObjects:@"Logout Current Account",@"Change Current Password",@"Modify User Information",nil];
    }
    settingsCellArray = [[NSMutableArray alloc]initWithObjects:settingsCell,nil];
    
    blankCell = [[NSMutableArray alloc]initWithObjects:@"Original password",@"New password",@"New password again",nil];
    blankCellInfor = [[NSMutableArray alloc]initWithObjects:@"Firstname",@"Lastname",@"Countrycode",@"Email",@"Phone #1",@"Phone #2", nil];
    
    //According to differents PromotionType sets differents CellName
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"] isEqual:@"Fixed discount"]){
        blankCellGeneral = [[NSMutableArray alloc]initWithObjects:@"Name",@"Description",@"Email",@"URL",@"Promotion type",@"Discount",@"Phone #1",@"Phone #2",nil];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"] isEqual:@"Points"]||[[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"] isEqual:@"Prepaid"]) {
        blankCellGeneral = [[NSMutableArray alloc]initWithObjects:@"Name",@"Description",@"Email",@"URL",@"Promotion type",@"Phone #1",@"Phone #2",nil];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"] isEqual:@"1"] || [[[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"] isEqual:@"2"]) {
        blankCellAddress = [[NSMutableArray alloc]initWithObjects:@"Building name",@"Unit number",@"Street name",@"Landmark",@"Postal code",@"Country",@"City",nil];
    }
    
    blankCellArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //[submit setBackgroundImage:[UIImage imageNamed:@"btn_login.png"] forState:UIControlStateNormal];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor colorWithRed:0.1294f green:0.4353f blue:0.7608f alpha:1.0f] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    [blankTableView addSubview:submitButton];
    
    //根据用户角色，获取所属Merchant/Store信息列表；
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"] isEqual:@"1"]) {
        serverDataGetter_store = [[GetServerData alloc]init];
        [serverDataGetter_store getServerDataMappingForClass:[StoreItem class]mappingsFromDictionary:@{@"id":@"st_id",@"name":@"st_name",@"description":@"st_description",@"email":@"st_email",@"url":@"st_url",@"discount":@"st_discount",@"building_name":@"st_buildingName",@"unit_number":@"st_unitNumber",@"street_name":@"st_streetName",@"landmark":@"st_landmark",@"postal_code":@"st_postalCode",@"country":@"st_country",@"city":@"st_city",@"phone_1":@"st_phone1",@"phone_2":@"st_phone2"} pathPattern:nil keyPath:@"store" appendingUrlString:[NSString stringWithFormat:@"Store/id:%@.json",[[NSUserDefaults standardUserDefaults] objectForKey:@"storeid"]] Delegate:self];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"] isEqual:@"2"]){
        serverDataGetter_merchant = [[GetServerData alloc]init];
        [serverDataGetter_merchant getServerDataMappingForClass:[RetailChainItem class]mappingsFromDictionary:@{@"id":@"rc_id",@"name":@"rc_name",@"description":@"rc_description",@"email":@"rc_email",@"url":@"rc_url",@"discount":@"rc_discount",@"building_name":@"rc_buildingName",@"unit_number":@"rc_unitNumber",@"street_name":@"rc_streetName",@"landmark":@"rc_landmark",@"postal_code":@"rc_postalCode",@"country":@"rc_country",@"city":@"rc_city",@"phone_1":@"rc_phone1",@"phone_2":@"rc_phone2",@"promotion_type":@"rc_promotionType"} pathPattern:nil keyPath:@"merchant" appendingUrlString:[NSString stringWithFormat:@"Merchant/id:%@.json",[[NSUserDefaults standardUserDefaults] objectForKey:@"chainid"]]  Delegate:self];
    }
    
    //注册键盘弹出和隐藏事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark ---UIKeyboardWillShow/HideNotification
-(void)keyboardWillShow:(NSNotification*)noti{
    NSDictionary *dic = noti.userInfo;
    CGSize size = [[dic objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    blankTableView.frame = CGRectMake(512, 0, 512, 768-44-35-size.width + 35);
    [UIView commitAnimations];
}
-(void)keyboardWillHide:(NSNotification*)noti{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    blankTableView.frame = CGRectMake(512, 0,512, 768-44-35);
    [UIView commitAnimations];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == settingsTableView)
        return [settingsCellArray count];
    else
        return [blankCellArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == settingsTableView)
        return [[settingsCellArray objectAtIndex:section] count];
    else
        return [[blankCellArray objectAtIndex:section]count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(tableView == settingsTableView)
        return @"Settings";
    else{
        if (selectedCellIndex == 3 && section == 0) {
            return @"General";
        }else if (selectedCellIndex == 3 && section == 1) {
            return @"Address";
        }else{
            return @"Modify User Information";
        }
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == settingsTableView){
        UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(oneCell == nil)
        {
            oneCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
        }
        oneCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        oneCell.selectionStyle = UITableViewCellSelectionStyleGray;
        oneCell.textLabel.text = [[settingsCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];       
        return oneCell;
    }else{
        if(selectedCellIndex == 1){
            TableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if(oneCell == nil)
            {
                oneCell = [[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
            }
            oneCell.textField.text = @"";
            oneCell.textField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
            oneCell.textField.secureTextEntry = YES;
            oneCell.tag = indexPath.row;
            oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
            oneCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            [oneCell.textLabel setTextColor:[UIColor blueColor]];
            return oneCell;
        }else if(selectedCellIndex == 2){
            TableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if(oneCell == nil)
            {
                oneCell = [[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
            }
            oneCell.textField.text = @"";
            oneCell.textField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
            oneCell.textField.secureTextEntry = NO;
            switch (indexPath.row) {
                case 0:
                    oneCell.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstname"];
                    break;
                case 1:
                    oneCell.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastname"];
                    break;
                case 2:
                    oneCell.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"];;
                    break;
                case 3:
                    oneCell.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
                    break;
                case 4:
                    oneCell.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone1"];
                    break;
                case 5:
                    //detailField.text = retailChainUserItem.password;
                    oneCell.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone2"];
                    break;
                default:
                    break;
            }
            oneCell.tag = indexPath.row;
            oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
            oneCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            [oneCell.textLabel setTextColor:[UIColor blueColor]];
            return oneCell;
        }else{
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"] isEqual:@"Fixed discount"]){
                if (indexPath.row == 0 && indexPath.section == 0) {
                    nameCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    nameField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*8 + indexPath.row)];
                    return nameCell;
                }else if(indexPath.row == 1 && indexPath.section == 0){
                    descriptionCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    descriptionField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*8 + indexPath.row)];
                    return descriptionCell;
                }else if(indexPath.row == 2 && indexPath.section == 0){
                    emailCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    emailField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*8 + indexPath.row)];
                    return emailCell;
                }else if(indexPath.row == 3 && indexPath.section == 0){
                    urlCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    return urlCell;
                    urlField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*8 + indexPath.row)];
                }else if(indexPath.row == 4 && indexPath.section == 0){
                    promotionTypeCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    promotionTypeField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*8 + indexPath.row)];
                    return promotionTypeCell;
                }else if(indexPath.row == 5 && indexPath.section == 0){
                    discountCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    discountField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*8 + indexPath.row)];
                    return discountCell;
                }else if(indexPath.row == 6 && indexPath.section == 0){
                    phone1Cell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    phone1Field.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*8 + indexPath.row)];
                    return phone1Cell;
                }else if(indexPath.row == 7 && indexPath.section == 0){
                    phone2Cell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    phone2Field.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*8 + indexPath.row)];
                    return phone2Cell;
                }if (indexPath.row == 0 && indexPath.section == 1) {
                    buildingNameCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    buildingNameField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*8 + indexPath.row)];
                    return buildingNameCell;
                }else if(indexPath.row == 1 && indexPath.section == 1){
                    UnitNumberCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    UnitNumberField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*8 + indexPath.row)];
                    return UnitNumberCell;
                }else if(indexPath.row == 2 && indexPath.section == 1){
                    StreetNameCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    StreetNameField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*8 + indexPath.row)];
                    return StreetNameCell;
                }else if(indexPath.row == 3 && indexPath.section == 1){
                    LandmarkCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    LandmarkField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*8 + indexPath.row)];
                    return LandmarkCell;
                }else if(indexPath.row == 4 && indexPath.section == 1){
                    postalCodeCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    postalCodeField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*8 + indexPath.row)];
                    return postalCodeCell;
                }else if(indexPath.row == 5 && indexPath.section == 1){
                    countryCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    countryField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*8 + indexPath.row)];
                    return countryCell;
                }else{
                    cityCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    cityField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*8 + indexPath.row)];
                    return cityCell;
                }
            }else{
                if (indexPath.row == 0 && indexPath.section == 0) {
                    nameCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    nameField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*7 + indexPath.row)];
                    return nameCell;
                }else if(indexPath.row == 1 && indexPath.section == 0){
                    descriptionCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    descriptionField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*7 + indexPath.row)];
                    return descriptionCell;
                }else if(indexPath.row == 2 && indexPath.section == 0){
                    emailCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    emailField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*7 + indexPath.row)];
                    return emailCell;
                }else if(indexPath.row == 3 && indexPath.section == 0){
                    urlCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    return urlCell;
                    urlField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*7 + indexPath.row)];
                }else if(indexPath.row == 4 && indexPath.section == 0){
                    promotionTypeCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    promotionTypeField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*7 + indexPath.row)];
                    return promotionTypeCell;
                }else if(indexPath.row == 5 && indexPath.section == 0){
                    phone1Cell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    phone1Field.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*7 + indexPath.row)];
                    return phone1Cell;
                }else if(indexPath.row == 6 && indexPath.section == 0){
                    phone2Cell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    phone2Field.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*7 + indexPath.row)];
                    return phone2Cell;
                }if (indexPath.row == 0 && indexPath.section == 1) {
                    buildingNameCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    buildingNameField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*7 + indexPath.row)];
                    return buildingNameCell;
                }else if(indexPath.row == 1 && indexPath.section == 1){
                    UnitNumberCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    UnitNumberField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*7 + indexPath.row)];
                    return UnitNumberCell;
                }else if(indexPath.row == 2 && indexPath.section == 1){
                    StreetNameCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    StreetNameField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*7 + indexPath.row)];
                    return StreetNameCell;
                }else if(indexPath.row == 3 && indexPath.section == 1){
                    LandmarkCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    LandmarkField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*7 + indexPath.row)];
                    return LandmarkCell;
                }else if(indexPath.row == 4 && indexPath.section == 1){
                    postalCodeCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    postalCodeField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*7 + indexPath.row)];
                    return postalCodeCell;
                }else if(indexPath.row == 5 && indexPath.section == 1){
                    countryCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    countryField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*7 + indexPath.row)];
                    return countryCell;
                }else{
                    cityCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                    cityField.text = [merchantOrStoreInforListArray objectAtIndex:(indexPath.section*7 + indexPath.row)];
                    return cityCell;
                }
            }
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(tableView == settingsTableView){
        if(indexPath.row == 0)
            [[NSNotificationCenter defaultCenter]postNotificationName:@"logout" object:nil];
        else if(indexPath.row == 1){
            blankTableView.scrollEnabled = NO;
            selectedCellIndex = indexPath.row;
            [blankCellArray removeAllObjects];
            [blankCellArray addObject:blankCell];
            [blankTableView reloadData];
            //调整按钮位置，并且设置事件的方法；
            submitButton.frame = CGRectMake(32+300, 180, 150, 40);
        }
        else if(indexPath.row == 2){
            blankTableView.scrollEnabled = NO;
            selectedCellIndex = indexPath.row;
            [blankCellArray removeAllObjects];
            [blankCellArray addObject:blankCellInfor];
            [blankTableView reloadData];
            //调整按钮位置，并且设置事件的方法；
            submitButton.frame = CGRectMake(32+300, 320, 150, 40);
        }
        else if (indexPath.row == 3){
            blankTableView.scrollEnabled = YES;
            selectedCellIndex = indexPath.row;
            [blankCellArray removeAllObjects];
            [blankCellArray addObject:blankCellGeneral];
            [blankCellArray addObject:blankCellAddress];
            [blankTableView reloadData];
            
            //调整按钮位置，并且设置事件的方法；
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"] isEqual:@"Fixed discount"]){
               submitButton.frame = CGRectMake(32+300, 180+44*13+10, 150, 40);//加10是为了在Cell和Button间留出空隙
            }else{
                submitButton.frame = CGRectMake(32+300, 180+44*12+10, 150, 40);
            }
        }
    }
}
-(void)submitPasswordAction{
    NSLog(@"submitPasswordAction");
    [self.view endEditing:YES];
    if (selectedCellIndex == 1) {
        TableViewCell *cell = (TableViewCell*)[blankTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        TableViewCell *cell1 = (TableViewCell*)[blankTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        TableViewCell *cell2 = (TableViewCell*)[blankTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        if ([cell.textField.text isEqualToString:@""]||[cell1.textField.text isEqualToString:@""]||[cell2.textField.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"The three items cann't be empty!" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles: nil];
            [alert show];
            [alert release];
            return;
        }
        if (![cell2.textField.text isEqualToString:cell1.textField.text]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"The password is inconsistent!" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles: nil];
            [alert show];
            [alert release];
            return;
        }
        NSString *userid = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]];
        NSString *pathStr = [[NSString alloc]initWithFormat:@"%@%@%@%@%@%@",@"http://198.199.107.25/API/User/",@"id:",userid,@",password:",cell.textField.text,@".json"];
        NSDictionary *params = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:cell1.textField.text,nil] forKeys:[NSArray arrayWithObjects:@"new_password", nil]];
    PutDataToServer *putServer = [[PutDataToServer alloc]init];
    [putServer putServerDataMappingForClass:[PutReturnValue class] mappingsFromDictionary:@{@"status":@"returnValue"} urlString:@"http://198.199.107.25/API/User/" postParameters:params pathPattern:nil keyPath:pathStr Delegate:self];
    }
    if (selectedCellIndex == 3){
        
        modifyInforAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Are you sure to modify these information?" delegate:self cancelButtonTitle:@"Sure" otherButtonTitles:@"No",nil];
        [modifyInforAlert show];
        [modifyInforAlert release];   
        
    }
}
#pragma mark ----ServerDataDelegate
-(void)getServerDataDidFinish:(NSArray *)serverData{
    dataOfGet = [serverData copy];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"] isEqual:@"1"]){
        storeItem = (StoreItem *)[dataOfGet objectAtIndex:0];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"] isEqual:@"Fixed discount"]) {
            merchantOrStoreInforListArray = [[NSMutableArray alloc]initWithObjects:storeItem.st_name,storeItem.st_description,storeItem.st_email,storeItem.st_url,[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"],storeItem.st_discount,storeItem.st_phone1,storeItem.st_phone2,storeItem.st_buildingName,storeItem.st_unitNumber,storeItem.st_streetName,storeItem.st_landmark,storeItem.st_postalCode,storeItem.st_country,storeItem.st_city, nil];
        }else{
            merchantOrStoreInforListArray = [[NSMutableArray alloc]initWithObjects:storeItem.st_name,storeItem.st_description,storeItem.st_email,storeItem.st_url,[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"],storeItem.st_phone1,storeItem.st_phone2,storeItem.st_buildingName,storeItem.st_unitNumber,storeItem.st_streetName,storeItem.st_landmark,storeItem.st_postalCode,storeItem.st_country,storeItem.st_city, nil];
        }
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"] isEqual:@"2"]) {
        retailChainItem = (RetailChainItem *)[dataOfGet objectAtIndex:0];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"] isEqual:@"Fixed discount"]) {
            merchantOrStoreInforListArray = [[NSMutableArray alloc]initWithObjects:retailChainItem.rc_name,retailChainItem.rc_description,retailChainItem.rc_email,retailChainItem.rc_url,retailChainItem.rc_promotionType,retailChainItem.rc_discount,retailChainItem.rc_phone1,retailChainItem.rc_phone2,retailChainItem.rc_buildingName,retailChainItem.rc_unitNumber,retailChainItem.rc_streetName,retailChainItem.rc_landmark,retailChainItem.rc_postalCode,retailChainItem.rc_country,retailChainItem.rc_city, nil];
        }else{
            merchantOrStoreInforListArray = [[NSMutableArray alloc]initWithObjects:retailChainItem.rc_name,retailChainItem.rc_description,retailChainItem.rc_email,retailChainItem.rc_url,retailChainItem.rc_promotionType,retailChainItem.rc_phone1,retailChainItem.rc_phone2,retailChainItem.rc_buildingName,retailChainItem.rc_unitNumber,retailChainItem.rc_streetName,retailChainItem.rc_landmark,retailChainItem.rc_postalCode,retailChainItem.rc_country,retailChainItem.rc_city, nil];
        }

    }
}
#pragma mark ----PutServerDataDelegate
-(void)putServerDataDidFinish:(NSArray *)serverData{
    PutReturnValue *value = (PutReturnValue *)[serverData objectAtIndex:0];
    NSLog(@"value.returnValue--->%@",value.returnValue);
    if (selectedCellIndex == 1) {
        if ([value.returnValue isEqualToString:@"Success"]) {
            successAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Password updated successfully,please login again!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [successAlert show];
            [successAlert release];
        }
        if([value.returnValue isEqualToString:@"Wrong_condition"]){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"The original password is wrong!" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles: nil];
            [alert show];
            [alert release];
            return;
        }
    }
    if (selectedCellIndex == 3){
        if ([value.returnValue isEqualToString:@"Success"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Modified successfully!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
        if([value.returnValue isEqualToString:@"Failed"]){
            modifyInforFailedAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Modified password is wrong!" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:@"Cancel",nil];
            [modifyInforFailedAlert show];
            [modifyInforFailedAlert release];
        }

    }
}
#pragma mark ----UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView == successAlert && buttonIndex == 0){
       [[NSNotificationCenter defaultCenter]postNotificationName:@"logout" object:nil]; 
    }
    if (alertView == modifyInforAlert && buttonIndex == 0) {
        [self modifyMerchantOrStoreInformation];
    }
    if (alertView == modifyInforFailedAlert && buttonIndex == 0) {
        [self modifyMerchantOrStoreInformation];
    }
}
-(void)modifyMerchantOrStoreInformation{
    
    NSString *pathStr;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"] isEqual:@"2"]) {
        pathStr = [[NSString alloc]initWithFormat:@"http://198.199.107.25/API/Merchant/id:%@.json",[[NSUserDefaults standardUserDefaults] objectForKey:@"chainid"]];
        NSDictionary *params;
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"] isEqual:@"Fixed discount"]) {
            params = [[NSDictionary alloc]initWithObjects:merchantOrStoreInforListArray forKeys:[[NSArray alloc] initWithObjects:@"name",@"description",@"email",@"url",@"promotion_type",@"discount",@"phone_1",@"phone_2",@"building_name",@"unit_number",@"street_name",@"landmark",@"postal_code",@"country",@"city", nil]];
        }else{
            params = [[NSDictionary alloc]initWithObjects:merchantOrStoreInforListArray forKeys:[[NSArray alloc] initWithObjects:@"name",@"description",@"email",@"url",@"promotion_type",@"phone_1",@"phone_2",@"building_name",@"unit_number",@"street_name",@"landmark",@"postal_code",@"country",@"city", nil]];
        }
        PutDataToServer *putServer = [[PutDataToServer alloc]init];
        [putServer putServerDataMappingForClass:[PutReturnValue class] mappingsFromDictionary:@{@"status":@"returnValue"} urlString:@"http://198.199.107.25/API/Merchant/" postParameters:params pathPattern:nil keyPath:pathStr Delegate:self];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"usertype"] isEqual:@"1"]) {
        pathStr = [[NSString alloc]initWithFormat:@"http://198.199.107.25/API/Store/id:%@.json",[[NSUserDefaults standardUserDefaults] objectForKey:@"storeid"]];
        NSDictionary *params;
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"] isEqual:@"Fixed discount"]) {
            params = [[NSDictionary alloc]initWithObjects:merchantOrStoreInforListArray forKeys:[[NSArray alloc] initWithObjects:@"name",@"description",@"email",@"url",@"promotion_type",@"discount",@"phone_1",@"phone_2",@"building_name",@"unit_number",@"street_name",@"landmark",@"postal_code",@"country",@"city", nil]];
        }else{
            params = [[NSDictionary alloc]initWithObjects:merchantOrStoreInforListArray forKeys:[[NSArray alloc] initWithObjects:@"name",@"description",@"email",@"url",@"promotion_type",@"phone_1",@"phone_2",@"building_name",@"unit_number",@"street_name",@"landmark",@"postal_code",@"country",@"city", nil]];
        }
        PutDataToServer *putServer = [[PutDataToServer alloc]init];
        [putServer putServerDataMappingForClass:[PutReturnValue class] mappingsFromDictionary:@{@"status":@"returnValue"} urlString:@"http://198.199.107.25/API/Store/" postParameters:params pathPattern:nil keyPath:pathStr Delegate:self];
    }

}
#pragma mark -----UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"] isEqual:@"Fixed discount"]){
        if (textField.tag >105) {
            [merchantOrStoreInforListArray replaceObjectAtIndex:textField.tag-101 withObject:textField.text];
        }else{
            [merchantOrStoreInforListArray replaceObjectAtIndex:textField.tag-100 withObject:textField.text];
        }
    }else{
        [merchantOrStoreInforListArray replaceObjectAtIndex:textField.tag-100 withObject:textField.text];
    }
}
-(void)submitInformationAction{
    NSLog(@"submitInformationAction");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initUITableViewCell{
    nameCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    [nameCell.textLabel setTextColor:[UIColor blueColor]];
    nameCell.selectionStyle = UITableViewCellSelectionStyleNone;
    nameField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
    [nameCell addSubview:nameField];
    nameField.text = @"";
    nameField.tag = 100;
    nameField.delegate = self;
    nameField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
    [nameField release];
    
    descriptionCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    [descriptionCell.textLabel setTextColor:[UIColor blueColor]];
    descriptionCell.selectionStyle = UITableViewCellSelectionStyleNone;
    descriptionField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
    [descriptionCell addSubview:descriptionField];
    descriptionField.text = @"";
    descriptionField.tag = 101;
    descriptionField.delegate = self;
    descriptionField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
    [descriptionField release];
    
    emailCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    [emailCell.textLabel setTextColor:[UIColor blueColor]];
    emailCell.selectionStyle = UITableViewCellSelectionStyleNone;
    emailField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
    [emailCell addSubview:emailField];
    emailField.text = @"";
    emailField.tag = 102;
    emailField.delegate = self;
    emailField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
    [emailField release];
    
    urlCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    [urlCell.textLabel setTextColor:[UIColor blueColor]];
    urlCell.selectionStyle = UITableViewCellSelectionStyleNone;
    urlField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
    [urlCell addSubview:urlField];
    urlField.text = @"";
    urlField.tag = 103;
    urlField.delegate = self;
    urlField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
    [urlField release];
    
    promotionTypeCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    [promotionTypeCell.textLabel setTextColor:[UIColor blueColor]];
    promotionTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    promotionTypeField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
    [promotionTypeCell addSubview:promotionTypeField];
    promotionTypeField.text = @"";
    promotionTypeField.enabled = NO;
    promotionTypeField.tag = 104;
    promotionTypeField.delegate = self;
    promotionTypeField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
    [promotionTypeField release];
    
    discountCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    [discountCell.textLabel setTextColor:[UIColor blueColor]];
    discountCell.selectionStyle = UITableViewCellSelectionStyleNone;
    discountField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
    [discountCell addSubview:discountField];
    discountField.text = @"";
    discountField.tag = 105;
    discountField.delegate = self;
    discountField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
    [discountField release];
    
    phone1Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    [phone1Cell.textLabel setTextColor:[UIColor blueColor]];
    phone1Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    phone1Field = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
    [phone1Cell addSubview:phone1Field];
    phone1Field.text = @"";
    phone1Field.tag = 106;
    phone1Field.delegate = self;
    phone1Field.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
    [phone1Field release];
    
    phone2Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    [phone2Cell.textLabel setTextColor:[UIColor blueColor]];
    phone2Cell.selectionStyle = UITableViewCellSelectionStyleNone;
    phone2Field = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
    [phone2Cell addSubview:phone2Field];
    phone2Field.text = @"";
    phone2Field.tag = 107;
    phone2Field.delegate = self;
    phone2Field.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
    [phone2Field release];
    
    buildingNameCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    [buildingNameCell.textLabel setTextColor:[UIColor blueColor]];
    buildingNameCell.selectionStyle = UITableViewCellSelectionStyleNone;
    buildingNameField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
    [buildingNameCell addSubview:buildingNameField];
    buildingNameField.text = @"";
    buildingNameField.tag = 108;
    buildingNameField.delegate = self;
    buildingNameField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
    [buildingNameField release];
    
    UnitNumberCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    [UnitNumberCell.textLabel setTextColor:[UIColor blueColor]];
    UnitNumberCell.selectionStyle = UITableViewCellSelectionStyleNone;
    UnitNumberField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
    [UnitNumberCell addSubview:UnitNumberField];
    UnitNumberField.text = @"";
    UnitNumberField.tag = 109;
    UnitNumberField.delegate = self;
    UnitNumberField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
    [UnitNumberField release];
    
    StreetNameCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    [StreetNameCell.textLabel setTextColor:[UIColor blueColor]];
    StreetNameCell.selectionStyle = UITableViewCellSelectionStyleNone;
    StreetNameField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
    [StreetNameCell addSubview:StreetNameField];
    StreetNameField.text = @"";
    StreetNameField.tag = 110;
    StreetNameField.delegate = self;
    StreetNameField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
    [StreetNameField release];
    
    LandmarkCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    [LandmarkCell.textLabel setTextColor:[UIColor blueColor]];
    LandmarkCell.selectionStyle = UITableViewCellSelectionStyleNone;
    LandmarkField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
    [LandmarkCell addSubview:LandmarkField];
    LandmarkField.text = @"";
    LandmarkField.tag = 111;
    LandmarkField.delegate = self;
    LandmarkField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
    [LandmarkField release];
    
    postalCodeCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    [postalCodeCell.textLabel setTextColor:[UIColor blueColor]];
    postalCodeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    postalCodeField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
    [postalCodeCell addSubview:postalCodeField];
    postalCodeField.text = @"";
    postalCodeField.tag = 112;
    postalCodeField.delegate = self;
    postalCodeField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
    [postalCodeField release];
    
    countryCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    [countryCell.textLabel setTextColor:[UIColor blueColor]];
    countryCell.selectionStyle = UITableViewCellSelectionStyleNone;
    countryField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
    [countryCell addSubview:countryField];
    countryField.text = @"";
    countryField.tag = 113;
    countryField.delegate = self;
    countryField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
    [countryField release];
    
    cityCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    [cityCell.textLabel setTextColor:[UIColor blueColor]];
    cityCell.selectionStyle = UITableViewCellSelectionStyleNone;
    cityField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
    [cityCell addSubview:cityField];
    cityField.text = @"";
    cityField.tag = 114;
    cityField.delegate = self;
    cityField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
    [cityField release];
}

@end
