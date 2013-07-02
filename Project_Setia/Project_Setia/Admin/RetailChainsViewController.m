//
//  RetailChainsViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "RetailChainsViewController.h"
#import "RetailChainCellView.h"
#import "RetailChainItem.h"
#import "RetailChainDetailsViewController.h"
#import "RetailChainsUserViewController.h"
#import "MBHUDUtil.h"
@interface RetailChainsViewController ()

@end

@implementation RetailChainsViewController

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
    self.title = @"Setia Membership List";
    
    dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768-44-35)style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView release];
           
    UIBarButtonItem *addRetailChainButttonItem = [[UIBarButtonItem alloc]initWithTitle:@"Add retail chain" style:UIBarButtonItemStylePlain target:self action:@selector(addRetailChain)];
    UIBarButtonItem *userButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Users" style:UIBarButtonItemStylePlain target:self action:@selector(retailChainUser)];
    NSArray *rightBarButtonItemsArray = [[NSArray alloc]initWithObjects:addRetailChainButttonItem,userButtonItem,nil];
    self.navigationItem.rightBarButtonItems = rightBarButtonItemsArray;
    [addRetailChainButttonItem release];
    [userButtonItem release];
    [rightBarButtonItemsArray release];
    
    serverDataGetter = [[GetServerData alloc]init];
    [serverDataGetter getServerDataMappingForClass:[RetailChainItem class]mappingsFromDictionary:@{@"id":@"rc_id",@"name":@"rc_name",@"description":@"rc_description",@"email":@"rc_email",@"url":@"rc_url",@"discount":@"rc_discount",@"building_name":@"rc_buildingName",@"unit_number":@"rc_unitNumber",@"street_name":@"rc_streetName",@"landmark":@"rc_landmark",@"postal_code":@"rc_postalCode",@"country":@"rc_country",@"city":@"rc_city",@"phone_1":@"rc_phone1",@"phone_2":@"rc_phone2"} pathPattern:nil keyPath:@"merchant" appendingUrlString:@"Merchant/all.json" Delegate:self];
    
    activiter = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activiter.frame = CGRectMake(512, 200, 100, 100);
    [activiter startAnimating];
    [self.view addSubview:activiter];
    [activiter release];
    
}
#pragma mark ----ServerDataDelegate
-(void)getServerDataDidFinish:(NSArray *)serverData{
    
    [activiter stopAnimating];
    
    for(int i=0;i<serverData.count;i++){
        [dataArray addObject:[serverData objectAtIndex:i]];
    }
    //dataArray = [serverData copy];
    [_tableView reloadData];
    [MBHUDUtil HUDShowMsg:self.view msg:@"Refresh finished" yOffset:100];
}
-(void)getServerDateFailed{
    [activiter stopAnimating];
    NSLog(@"getServerDateFailed");
    [MBHUDUtil HUDShowMsg:self.view msg:@"Refresh failed !!! Check the network is available." yOffset:100];
}
-(void)retailChainUser
{
    RetailChainsUserViewController *userVcl = [[RetailChainsUserViewController alloc]init];
    [self.navigationController pushViewController:userVcl animated:YES];
}
-(void)addRetailChain
{
    RetailChainDetailsViewController *detailsVcl = [[RetailChainDetailsViewController alloc]init];
    [detailsVcl addParentViewControllerUserListItem:^(RetailChainItem *rcItem) {
        NSLog(@"rcItem---->%@",rcItem);
        [dataArray insertObject:rcItem atIndex:0];
        [_tableView reloadData];
    }];
    //detailsVcl.retailChainItem = [dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailsVcl animated:YES];
}
#pragma mark ---- UITableViewDataSource,UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @" Id        Retail chain         Description                  Email                   Phone #1                phone #2                  URL";
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
    RetailChainCellView *cellView = [[RetailChainCellView alloc]initWithFrame:CGRectMake(45, 0, 933, 42)];
    [cell addSubview:cellView];
    [cellView release];
    if([dataArray count]!= 0){
        RetailChainItem *item = (RetailChainItem *)[dataArray objectAtIndex:indexPath.row];
        cellView.idTField.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
        cellView.retailNameTField.text = item.rc_name;
        cellView.descriptionTField.text = item.rc_description;
        cellView.emailTField.text = item.rc_email;
        cellView.phone1TField.text = item.rc_phone1;
        cellView.phone2TField.text = item.rc_phone2;
        cellView.urlTField.text = item.rc_url;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RetailChainDetailsViewController *detailsVcl = [[RetailChainDetailsViewController alloc]init];
    detailsVcl.retailChainItem = (RetailChainItem *)[dataArray objectAtIndex:indexPath.row];
    detailsVcl.isUpdateRetailChain = YES;
    [self.navigationController pushViewController:detailsVcl animated:YES];
}
#pragma mark ---UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollView.contentOffset.y--->%f",scrollView.contentOffset.y);
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
     NSLog(@"scrollView.contentOffset.y--->%f",scrollView.contentOffset.y);
    NSLog(@"scrollView.contentSize.height--->%f",scrollView.contentSize.height);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [super dealloc];
}
@end
