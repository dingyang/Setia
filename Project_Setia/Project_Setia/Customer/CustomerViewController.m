//
//  CustomerViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "CustomerViewController.h"
#import "CustomerCellView.h"
#import "CustomerDetailsViewController.h"
#import "RestKit/RestKit.h"
#import "CustomerItem.h"
#import "GetServerData.h"
@interface CustomerViewController ()

@end

@implementation CustomerViewController

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
    [self.view setBackgroundColor:[UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.0f]];
    self.title = @"Customer List";
    
    dataArray = [[NSArray alloc]init];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768-44-35)style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    [self makeRightBarButtonItems];
    
    serverDataGetter = [[GetServerData alloc]init];
    [serverDataGetter getServerDataMappingForClass:[CustomerItem class]mappingsFromDictionary:@{@"id": @"cus_LoginId",@"country_code": @"cus_CountryCode",@"phone_number": @"cus_PhoneNumber",@"firstname": @"cus_Firstname",@"lastname": @"cus_Lastname",@"birthday": @"cus_Date",@"email": @"cus_Email",@"gender": @"cus_Gender",@"country": @"cus_Country",@"password": @"cus_Password",@"city":@"cus_City",@"unit_number":@"cus_UnitNumber",@"building_name":@"cus_BuildingName",@"street_name":@"cus_StreetName",@"landmark":@"cus_Landmark",@"postal_code":@"cus_PostalCode",}
                                 pathPattern:nil keyPath:@"user" appendingUrlString:@"Customer/all.json" Delegate:self];
}

-(void)makeRightBarButtonItems
{
    addCustomerButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Refresh list" style:UIBarButtonItemStylePlain target:self action:@selector(refreshCustomer)];
    serchButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Search customer" style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    buttonsArray = [[NSArray alloc]initWithObjects:addCustomerButtonItem,serchButtonItem, nil];
    self.navigationItem.rightBarButtonItems = buttonsArray;
    [serchButtonItem release];
    [addCustomerButtonItem release];
    [buttonsArray release];
}
-(void)search
{
    customerSerch = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
    _tableView.tableHeaderView = customerSerch;
    [self.view addSubview:customerSerch];
    customerSerch.showsBookmarkButton = YES;
    customerSerch.showsCancelButton = YES;
    customerSerch.showsSearchResultsButton = YES;
    customerSerch.showsScopeBar = YES;
    [customerSerch release];
    
    //[self remakeRightBarButtonItems];
    
    NSInteger numViews = [customerSerch.subviews count];
    for(int i=0;i<numViews;i++)
    {
        if([[customerSerch.subviews objectAtIndex:i] isKindOfClass:[UIButton class]])
        {
            UIButton *cancelbutton = (UIButton *)[customerSerch.subviews objectAtIndex:i];
            [cancelbutton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }

}
-(void)cancelAction
{
      _tableView.tableHeaderView = nil;
//    [customerSerch removeFromSuperview];
}
-(void)cancelSearch
{
    _tableView.tableHeaderView = nil;
    [self makeRightBarButtonItems];
}
-(void)refreshCustomer
{
    [serverDataGetter getServerDataMappingForClass:[CustomerItem class]mappingsFromDictionary:@{@"id": @"cus_LoginId",@"country_code": @"cus_CountryCode",@"phone_number": @"cus_PhoneNumber",@"firstname": @"cus_Firstname",@"lastname": @"cus_Lastname",@"birthday": @"cus_Date",@"email": @"cus_Email",@"gender": @"cus_Gender",@"country": @"cus_Country",@"password": @"cus_Password",@"city":@"cus_City",@"unit_number":@"cus_UnitNumber",@"building_name":@"cus_BuildingName",@"street_name":@"cus_StreetName",@"landmark":@"cus_Landmark",@"postal_code":@"cus_PostalCode",}
                                       pathPattern:nil keyPath:@"user" appendingUrlString:@"Customer/all.json" Delegate:self];
}
#pragma mark ----ServerDataDelegate
-(void)getServerDataDidFinish:(NSArray *)serverData
{
    dataArray = [serverData copy];
    [_tableView reloadData];
}
-(void)getServerDateFailed{
    
}
#pragma mark ---- UITableViewDataSource,UITableViewDelegate.
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"   Firstname         Lastname                     Email                          CountryCode         phonenumber              Gender";
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // return dataArray.count;
    return [dataArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"] autorelease];
        
    }
    cellView = [[CustomerCellView alloc]initWithFrame:CGRectMake(45, 0, 933, 42)];
    [cell addSubview:cellView];
    [cellView release];
    if([dataArray count]!=0){
        CustomerItem *item = [dataArray objectAtIndex:indexPath.row];
        cellView.firstNameTField.text = item.cus_Firstname;
        cellView.lastnameTField.text = item.cus_Lastname;
        cellView.emailTField.text = item.cus_Email;
        cellView.phone1TField.text = item.cus_CountryCode;
        cellView.phone2TField.text = item.cus_PhoneNumber;
        cellView.LoginIdTField.text = item.cus_Gender;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CustomerItem *item = (CustomerItem*)[dataArray objectAtIndex:indexPath.row];
    CustomerDetailsViewController *cus_detailsVcl = [[CustomerDetailsViewController alloc]init];
    cus_detailsVcl.customerItem = item;
    NSLog(@"cus_detailsVcl.customerItem---%@",cus_detailsVcl.customerItem);
    [self.navigationController pushViewController:cus_detailsVcl animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
