//
//  RetailChainManagerViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 9/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "RetailChainManagerViewController.h"
#import "RetailChainsViewController.h"
#import "StoreCellView.h"
#import "storeItem.h"
#import "RetailChainDetailsViewController.h"
#import "RetailChainsUserViewController.h"

#import "StoreDetailsViewController.h"
#import "StoreUserViewController.h"
#import "MBHUDUtil.h"
@interface RetailChainManagerViewController ()

@end

@implementation RetailChainManagerViewController

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
    // Do any additional setup after loading the view from its nib.
    self.title = @"Chain Manager Main View";
    
    dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768-44-35)style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    UIBarButtonItem *addRetailChainButttonItem = [[UIBarButtonItem alloc]initWithTitle:@"Add Store" style:UIBarButtonItemStylePlain target:self action:@selector(addStore)];
    UIBarButtonItem *userButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Users" style:UIBarButtonItemStylePlain target:self action:@selector(storeUser)];
    NSArray *rightBarButtonItemsArray = [[NSArray alloc]initWithObjects:addRetailChainButttonItem,userButtonItem,nil];
    self.navigationItem.rightBarButtonItems = rightBarButtonItemsArray;
    [addRetailChainButttonItem release];
    [userButtonItem release];
    [rightBarButtonItemsArray release];
    
    serverDataGetter = [[GetServerData alloc]init];
    [serverDataGetter getServerDataMappingForClass:[StoreItem class]mappingsFromDictionary:@{@"id":@"st_id",@"name":@"st_name",@"description":@"st_description",@"email":@"st_email",@"url":@"st_url",@"discount":@"st_discount",@"building_name":@"st_buildingName",@"unit_number":@"st_unitNumber",@"street_name":@"st_streetName",@"landmark":@"st_landmark",@"postal_code":@"st_postalCode",@"country":@"st_country",@"city":@"st_city",@"phone_1":@"st_phone1",@"phone_2":@"st_phone2"} pathPattern:nil keyPath:@"store" appendingUrlString:[NSString stringWithFormat:@"Store/merchant_id:%@.json",[[NSUserDefaults standardUserDefaults] objectForKey:@"chainid"]] Delegate:self];
}
#pragma mark ----ServerDataDelegate
-(void)getServerDataDidFinish:(NSArray *)serverData{
    for(int i=0;i<serverData.count;i++){
        [dataArray addObject:[serverData objectAtIndex:i]];
    }
    //dataArray = [serverData copy];
    [_tableView reloadData];
    
    [MBHUDUtil HUDShowMsg:self.view msg:@"Refresh finished" yOffset:100];
}
-(void)getServerDateFailed{
    NSLog(@"getServerDateFailed");
    [MBHUDUtil HUDShowMsg:self.view msg:@"Refresh failed !!! Check the network is available." yOffset:100];
}

-(void)storeUser{
    StoreUserViewController *userVcl = [[StoreUserViewController alloc]init];
    [self.navigationController pushViewController:userVcl animated:YES];
}
-(void)addStore
{
    StoreDetailsViewController *detailsVcl = [[StoreDetailsViewController alloc]init];
    [detailsVcl addParentViewControllerUserListItem:^(StoreItem *stItem) {
        [dataArray insertObject:stItem atIndex:0];
        [_tableView reloadData];
    }];
    [self.navigationController pushViewController:detailsVcl animated:YES];
}
#pragma mark ----UITableViewDataSource,UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @" Id          Country                    City                   Street name            Postal code             Phone #1                phone #2";
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"] autorelease];
    }
    StoreCellView *cellView = [[StoreCellView alloc]initWithFrame:CGRectMake(45, 0, 933, 42)];
    [cell addSubview:cellView];
    [cellView release];
    if([dataArray count]!= 0){
        StoreItem *item = (StoreItem *)[dataArray objectAtIndex:indexPath.row];
        cellView.idTField.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
        cellView.countryTField.text = item.st_country;
        cellView.cityTField.text = item.st_city;
        cellView.streetNameTField.text = item.st_streetName;
        cellView.phone1TField.text = item.st_phone1;
        cellView.phone2TField.text = item.st_phone2;
        cellView.postalCodeTField.text = item.st_postalCode;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StoreDetailsViewController *detailsVcl = [[StoreDetailsViewController alloc]init];
    detailsVcl.storeItem = (StoreItem *)[dataArray objectAtIndex:indexPath.row];
    detailsVcl.isUpdateStore = YES;
    [self.navigationController pushViewController:detailsVcl animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
