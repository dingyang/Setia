//
//  StoreDetailsViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 8/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "StoreDetailsViewController.h"
#import "PostReturnValue.h"
#import "MBHUDUtil.h"
#import "TableViewCell.h"
@interface StoreDetailsViewController ()

@end

@implementation StoreDetailsViewController
@synthesize storeItem;
@synthesize leftTableView;
@synthesize rightTableView;
@synthesize isUpdateStore;
-(void)dealloc
{
    [storeItem release];
    [leftTableView release];
    [rightTableView release];
    [leftCellArray release];
    [rightCellArray release];
    [super dealloc];
}
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
    self.title = @"Store Details";
    
    //初始化post到server端的数组 和 server端的字段数组
    postToServerDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    serverKeysArray = [[NSArray alloc]initWithObjects:@"name",@"description",@"email",@"url",@"discount",@"phone_1",@"phone_2",@"building_name",@"unit_number",@"street_name",@"landmark",@"postal_code",@"country",@"city",@"merchant_id",@"merchant_name",nil];
    if(self.isUpdateStore == YES){
        UIBarButtonItem *userButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Update" style:UIBarButtonItemStylePlain target:self action:@selector(updateStore)];
        self.navigationItem.rightBarButtonItem = userButtonItem;
        [userButtonItem release];
    }else{
        UIBarButtonItem *userButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveStore)];
        self.navigationItem.rightBarButtonItem = userButtonItem;
        [userButtonItem release];
    }
    leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 512, 768-44-35) style:UITableViewStyleGrouped];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.scrollEnabled = NO;
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
    
    //初始化cell.textLable.text
    leftCellArray = [[NSMutableArray alloc]initWithObjects:@"Name",@"Description",@"Email",@"URL",@"Discount",@"Phone #1",@"Phone #2",nil];
    rightCellArray = [[NSMutableArray alloc]initWithObjects:@"Building name",@"Unit number",@"Street name",@"Landmark",@"Postal code",@"Country",@"City", nil];
    
    //初始化cell.textFeild的显示内容
    if(self.storeItem!=nil){
        leftCellTextFeildArray = [[NSMutableArray alloc]initWithObjects:storeItem.st_name,storeItem.st_description,storeItem.st_email,storeItem.st_url,storeItem.st_discount, storeItem.st_phone1,storeItem.st_phone2,nil];
        
        rightCellTextFeildArray = [[NSMutableArray alloc]initWithObjects:storeItem.st_buildingName,storeItem.st_unitNumber,storeItem.st_streetName,storeItem.st_landmark,storeItem.st_postalCode,storeItem.st_country,storeItem.st_city, nil];
    }
}
#pragma mark -----updateStore
-(void)updateStore{
    
}
#pragma mark ---- saveButtonAction
-(void)saveStore{
    stItem = [[StoreItem alloc]init];
    [self.view endEditing:YES];
    // 遍历所有的UITextFeild
    for (int i=0; i<7; i++) {
        TableViewCell *cell = (TableViewCell*)[leftTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [postToServerDataArray addObject:cell.textField.text];
    }
    for (int j=0; j<7; j++) {
        TableViewCell *cell = (TableViewCell*)[rightTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:0]];
        [postToServerDataArray addObject:cell.textField.text];
    }
    //将数据写回数组，呈现到主列表中
    for (int i=0; i<[postToServerDataArray count]; i++) {
        NSString *string = [NSString stringWithString:[postToServerDataArray objectAtIndex:i]];
        switch (i) {
            case 0:
                stItem.st_name = string;
                break;
            case 1:
                stItem.st_description = string;
                break;
            case 2:
                stItem.st_email = string;
                break;
            case 3:
                stItem.st_url = string;
                break;
            case 4:
                stItem.st_discount = string;
                break;
            case 5:
                stItem.st_phone1 = string;
                break;
            case 6:
                stItem.st_phone2 = string;
                break;
            case 7:
                stItem.st_buildingName = string;
                break;
            case 8:
                stItem.st_unitNumber = string;
                break;
            case 9:
                stItem.st_streetName = string;
                break;
            case 10:
                stItem.st_landmark = string;
                break;
            case 11:
                stItem.st_postalCode = string;
                break;
            case 12:
                stItem.st_country = string;
                break;
            case 13:
                stItem.st_city = string;
                break;
            default:
                break;
        }
    }
    [postToServerDataArray addObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"chainid"]];
    [postToServerDataArray addObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"chainname"]];
    
    PostDataToServer *postServer = [[PostDataToServer alloc]init];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjects:postToServerDataArray forKeys:serverKeysArray];
    [postServer postServerDataMappingForClass:[PostReturnValue class] mappingsFromDictionary:@{@"status":@"returnValue"}
                           appendingUrlString:@"Store" postParameters:dict pathPattern:nil keyPath:nil Delegate:self];
    [postToServerDataArray removeAllObjects];
}
#pragma mark ---- PostServerDataDelegate
-(void)postServerDataDidFinish:(NSArray *)serverData
{
    NSLog(@"<===============serverData================>%@",serverData);
    PostReturnValue *value = (PostReturnValue*)[serverData objectAtIndex:0];
    NSLog(@"%@",value.returnValue);
    
    [MBHUDUtil HUDShowMsg:self.view msg:@"Add finished!" yOffset:100];
    saveCb(stItem);
    [self performSelector:@selector(backToParentViewController) withObject:nil afterDelay:2];
}
-(void)backToParentViewController{
    [self.navigationController popToViewController:[self.navigationController.childViewControllers objectAtIndex:0] animated:YES];
}
-(void)postServerDateFailed
{
    NSLog(@"<===============postServerDateFailed================>");
    [MBHUDUtil HUDShowMsg:self.view msg:@"Add failed !!! Check the network is available." yOffset:100];
}
#pragma mark ---addParentViewControllerUserListItem (Block)
-(void)addParentViewControllerUserListItem:(void(^)(StoreItem *stItem))cb{
    [saveCb release];
    saveCb = [cb copy];
}
#pragma mark --- UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == leftTableView)
    {
        return [leftCellArray count];
    }else{
        return [rightCellArray count];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView == leftTableView){
        return @"General";
    }else{
        return @"Address";
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == leftTableView){
        TableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"leftcell"];
        if(oneCell == nil)
        {
            oneCell = [[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"] autorelease];
        }
        oneCell.tag = indexPath.row;
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        oneCell.textLabel.text = [leftCellArray objectAtIndex:indexPath.row];
        if(leftCellTextFeildArray != nil){
            oneCell.textField.text = [leftCellTextFeildArray objectAtIndex:indexPath.row];
        }else{
            oneCell.textField.text = @"";
        }
        return oneCell;
    }
    else
    {
        TableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"rightcell"];
        if(oneCell == nil)
        {
            oneCell = [[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rightcell"] autorelease];
        }
        // [detailField setEnabled:NO];
        oneCell.tag = indexPath.row;
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        oneCell.textLabel.text = [rightCellArray objectAtIndex:indexPath.row];
        if(rightCellTextFeildArray != nil){
            oneCell.textField.text = [rightCellTextFeildArray objectAtIndex:indexPath.row];
        }
        return oneCell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
