//
//  RetailChainUserDetailsViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 7/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "RetailChainUserDetailsViewController.h"
#import "PostReturnValue.h"
#import "GetServerData.h"
#import "RetailChainItem.h"
#import "MBHUDUtil.h"
@interface RetailChainUserDetailsViewController ()

@end

@implementation RetailChainUserDetailsViewController
@synthesize leftTableView;
@synthesize rightTableView;
@synthesize roleValue;
@synthesize isUpdateRetailChainUser;
@synthesize retailChainUserItem;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Retail Chain User Details";
    //初始化post到server端的数组 和 server端的字段数组
    postToServerDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    serverKeysArray = [[NSArray alloc]initWithObjects:@"type",@"firstname",@"lastname",@"country_code",@"user_name",@"email",@"password",@"phone_number1",@"phone_number2",@"merchant_id",@"merchant_name",nil];
    
    //初始化chainNamesPickerViewArray
    //chainNamesPickerViewArray = [[NSArray alloc]init];
    chainNamesPickerViewArray = [[NSMutableArray alloc]initWithCapacity:0];
    getChainNamesArray = [[NSArray alloc]init];
    if(self.isUpdateRetailChainUser == YES){
        userUpdateButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Update" style:UIBarButtonItemStylePlain target:self action:@selector(updateUser)];
        self.navigationItem.rightBarButtonItem = userUpdateButtonItem;
        [userUpdateButtonItem release];
    }else{
        userSaveButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveUser)];
        self.navigationItem.rightBarButtonItem = userSaveButtonItem;
        [userSaveButtonItem release];
    }
    
    leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 512, 768-44-35) style:UITableViewStyleGrouped];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.scrollEnabled = NO;
    leftTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:leftTableView];
    [leftTableView release];
    
    rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(512, 0, 512, 768-44-35) style:UITableViewStyleGrouped];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.scrollEnabled = NO;
    [self.view addSubview:rightTableView];
    [rightTableView release];
    
    UIImageView *setiaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(35,768-44-35-189, 169, 169)];
    [setiaImageView setImage:[UIImage imageNamed:@"logo-setia.png"]];
    [self.view addSubview:setiaImageView];
    [setiaImageView release];
    
    NSArray *leftGeneralArray = [[NSArray alloc]initWithObjects:@"Type",@"Firstname",@"Lastname",@"Countrycode",@"Username",@"Email",@"Password",@"Phone #1",@"Phone #2",nil];
    leftCellArray = [[NSMutableArray alloc]initWithObjects:leftGeneralArray,nil];
    [leftGeneralArray release];
    NSArray *rightRetailChainsArray = [[NSArray alloc]initWithObjects:@"Chain name", nil];
    self.roleValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"roleValue"];
    NSLog(@"self.roleValue--->%d",self.roleValue);
    if(self.roleValue !=3)
    {
        NSArray *rightStoreArray = [[NSArray alloc]initWithObjects:@"Store name", nil];
        rightCellArray = [[NSMutableArray alloc]initWithObjects:rightRetailChainsArray,rightStoreArray,nil];
        [rightStoreArray release];
    }else{
        rightCellArray = [[NSMutableArray alloc]initWithObjects:rightRetailChainsArray,nil];
    }
    [rightRetailChainsArray release];
    //注册键盘弹出和隐藏事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
#pragma mark ---UIKeyboardWillShow/HideNotification
-(void)keyboardWillShow:(NSNotification*)noti
{
    NSDictionary *dic = noti.userInfo;
    CGSize size = [[dic objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    leftTableView.frame = CGRectMake(0, 0, 512, 768-44-35-size.width + 35);
    rightTableView.frame = CGRectMake(512, 0, 512, 768-44-35-size.width + 35);
    [leftTableView setContentOffset:CGPointMake(0, 80) animated:YES];
    [UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification*)noti
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01];
    leftTableView.frame = CGRectMake(0, 0, 512, 768-44-35);
    rightTableView.frame = CGRectMake(512, 0, 512, 768-44-35);
    leftTableView.scrollEnabled = NO;
    [UIView commitAnimations];
    
}
-(void)resignKeyBoard
{
    [detailField resignFirstResponder];
}
#pragma mark ----updateUser
-(void)updateUser{
    sleep(1);
    [self.navigationController popToViewController:[self.navigationController.childViewControllers objectAtIndex:1] animated:YES];
}
#pragma mark ----postToServer
-(void)saveUser
{
    rcUserItem = [[RetailChainUserItem alloc]init];
    [self.view endEditing:YES];
    if([selectChainNameButton.titleLabel.text isEqualToString:@"TouchToSelectChainName"]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warnings" message:@"Please select chain name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    [postToServerDataArray addObject:@"2"];
    for (int i=101; i<=108; i++) {
        UITextField *tf = (UITextField *)[self.view viewWithTag:i];
        [postToServerDataArray addObject:tf.text];
        switch (i) {
            case 101:
                rcUserItem.firstname = tf.text;
                break;
            case 102:
                rcUserItem.lastname = tf.text;
                break;
            case 103:
                rcUserItem.code = tf.text;
                break;
            case 104:
                rcUserItem.username = tf.text;
                break;
            case 105:
                rcUserItem.email = tf.text;
                break;
            case 107:
                rcUserItem.phone1 = tf.text;
                break;
            case 108:
                rcUserItem.phone2 = tf.text;
                break;
            default:
                break;
        }
    }
    rcUserItem.chainname = selectChainNameButton.titleLabel.text;
    [postToServerDataArray addObject:selectedChainId];
    [postToServerDataArray addObject:selectChainNameButton.titleLabel.text];
    
    NSDictionary *dict = [[NSDictionary alloc]initWithObjects:postToServerDataArray forKeys:serverKeysArray];
    PostDataToServer *postServer = [[PostDataToServer alloc]init];
    [postServer postServerDataMappingForClass:[PostReturnValue class] mappingsFromDictionary:@{@"status":@"returnValue"}
                           appendingUrlString:@"User" postParameters:dict pathPattern:nil keyPath:nil Delegate:self];
    //删除数组中所有要增加的项，避免多次按add按钮；
    [postToServerDataArray removeAllObjects];
    
}
#pragma mark ----PostServerDataDelegate
-(void)postServerDataDidFinish:(NSArray *)serverData{
    PostReturnValue *value = (PostReturnValue *)[serverData objectAtIndex:0];
    NSLog(@"value.returnValue--->%@",value.returnValue);
    [MBHUDUtil HUDShowMsg:self.view msg:@"Add finished!" yOffset:100];
    
    saveCb(rcUserItem);
    [self performSelector:@selector(backToParentViewController) withObject:nil afterDelay:2];
}
-(void)backToParentViewController{
    [self.navigationController popToViewController:[self.navigationController.childViewControllers objectAtIndex:1] animated:YES];
}
-(void)postServerDateFailed{
    NSLog(@"<===============postServerDateFailed================>");
    [MBHUDUtil HUDShowMsg:self.view msg:@"Add failed !!! Check the network is available." yOffset:100];
}
#pragma mark ---addParentViewControllerUserListItem (Block)
-(void)addParentViewControllerUserListItem:(void(^)(RetailChainUserItem *rcUserItem))cb{
    [saveCb release];
    saveCb = [cb copy];
}
#pragma mark ----UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == leftTableView)
        return [leftCellArray count];
    else
        return [rightCellArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == leftTableView){
        return [[leftCellArray objectAtIndex:section] count];
    }else{
        return [[rightCellArray objectAtIndex:section ] count];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView == leftTableView)
        return @"General";
    else{
        if(section == 0)
            return @"Chain";
        else
            return @"Store";
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == leftTableView){
        UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"leftcell"];
        if(oneCell == nil){
            oneCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"] autorelease];
        }
        if(indexPath.row == 0){
            chainManagerLabel = [[UILabel alloc]initWithFrame:CGRectMake(201, 0, 280, 46)];
            chainManagerLabel.backgroundColor = [UIColor clearColor];
            chainManagerLabel.text = @"Chain Manager";
            chainManagerLabel.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
            [oneCell addSubview:chainManagerLabel];
            [chainManagerLabel release];
        }else{
            detailField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
            detailField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
            detailField.tag = 100 + indexPath.row;
            if(self.retailChainUserItem != nil){
                switch (indexPath.row) {
                    case 1:
                        detailField.text = retailChainUserItem.firstname;
                        break;
                    case 2:
                        detailField.text = retailChainUserItem.lastname;
                        break;
                    case 3:
                        detailField.text = retailChainUserItem.code;
                        break;
                    case 4:
                        detailField.text = retailChainUserItem.username;
                        break;
                    case 5:
                        detailField.text = retailChainUserItem.email;
                        break;
                    case 6:
                        //detailField.text = retailChainUserItem.password;
                        detailField.text = @"*** ***";
                        break;
                    case 7:
                        detailField.text = retailChainUserItem.phone1;
                        break;
                    case 8:
                        detailField.text = retailChainUserItem.phone2;
                        break;
                    default:
                        break;
                }
            }else{
                detailField.text = @"";
            }

            [oneCell addSubview:detailField];
            [detailField release];
        }
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        oneCell.textLabel.text = [[leftCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return oneCell;
    }else{
        UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"rightcell"];
        if(oneCell == nil){
            oneCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rightcell"] autorelease];
        }
        if(self.isUpdateRetailChainUser == YES){
            detailField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
            detailField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
            detailField.text = retailChainUserItem.chainname;
            [oneCell addSubview:detailField];
            [detailField release];
        }else{
            selectChainNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [selectChainNameButton setBackgroundColor:[UIColor clearColor]];
            selectChainNameButton.frame = CGRectMake(201, 0, 280, 46);
            [selectChainNameButton setTitle:@"TouchToSelectChainName" forState:UIControlStateNormal];
            [selectChainNameButton setTitleColor:[UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f] forState:UIControlStateNormal];
            [selectChainNameButton addTarget:self action:@selector(selectChainName:) forControlEvents:UIControlEventTouchUpInside];
            [oneCell addSubview:selectChainNameButton];
        }
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        oneCell.textLabel.text = [[rightCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return oneCell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark --selectChainName
-(void)selectChainName:(id)sender{
    GetServerData *getData = [[GetServerData alloc]init];
    [getData getServerDataMappingForClass:[RetailChainItem class] mappingsFromDictionary:@{@"id":@"rc_id",@"name":@"rc_name"} pathPattern:nil keyPath:@"merchant" appendingUrlString:@"Merchant/all.json" Delegate:self];
}
#pragma  mark ----serverDataDelegate
-(void)getServerDataDidFinish:(NSArray *)serverData{
    getChainNamesArray = [serverData copy];//很重要，要用copy；
    NSLog(@"[getChainNamesArray count]----->%d",[getChainNamesArray count]);
    for (int i=0; i<[getChainNamesArray count]; i++) {
        RetailChainItem *rcItem = (RetailChainItem*)[getChainNamesArray objectAtIndex:i];
        [chainNamesPickerViewArray addObject:rcItem.rc_name];
    }
    if (!chainNameButtonIsRetouched) {
        chainNamesPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(745, 86, 250, 50)];
        chainNamesPickerView.showsSelectionIndicator = YES;
        chainNamesPickerView.delegate = self;
        chainNamesPickerView.dataSource = self;
        [self.view addSubview:chainNamesPickerView];
        [chainNamesPickerView release];
        chainNameButtonIsRetouched = YES;
    }else{
        [chainNamesPickerViewArray removeAllObjects];
        [chainNamesPickerView removeFromSuperview];
        chainNameButtonIsRetouched = NO;
    }

}
-(void)getServerDateFailed{
    NSLog(@"getServerDateFailed");
}
#pragma  mark ----UIPickerViewDataSource,UIPickerViewDelegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [chainNamesPickerViewArray count];
    NSLog(@"[pickerView.pickerViewItemsArray count]--->%d",[chainNamesPickerViewArray count]);
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [chainNamesPickerViewArray objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"[chainNamesPickerViewArray objectAtIndex:row]--->%@",[chainNamesPickerViewArray objectAtIndex:row]);
    [selectChainNameButton setTitle:[chainNamesPickerViewArray objectAtIndex:row] forState:UIControlStateNormal];
    [chainNamesPickerView removeFromSuperview];
    chainNameButtonIsRetouched = NO;
    RetailChainItem *rcItem = (RetailChainItem*)[getChainNamesArray objectAtIndex:row];
    selectedChainId = rcItem.rc_id;
    // 显示完之后全部删掉；
    [chainNamesPickerViewArray removeAllObjects];
    //NSLog(@"selectedChainId---->%@",selectedChainId);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
