//
//  CustomerDetailsViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 7/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "CustomerDetailsViewController.h"

@interface CustomerDetailsViewController ()

@end

@implementation CustomerDetailsViewController
@synthesize customerItem;
@synthesize leftTableView;
@synthesize rightTableView;
-(void)dealloc
{
    [customerItem release];
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
    self.title = @"Customer details";
    
//    UIBarButtonItem *userButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveRetailChain)];
//    self.navigationItem.rightBarButtonItem = userButtonItem;
//    [userButtonItem release];
    
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
    
    NSMutableArray *leftCellArray_general = [[NSMutableArray alloc]initWithObjects:@"Firstname",@"Lastname",@"Gender",@"Date of birth", nil];
    NSMutableArray *leftCellArray_address = [[NSMutableArray alloc]initWithObjects:@"Country",@"City",@"Unit number",@"Building name",@"Street name",@"Landmark",@"Postal code",nil];
    leftCellArray = [[NSMutableArray alloc]initWithObjects:leftCellArray_general,leftCellArray_address,nil];
    
    rightCellArray = [[NSMutableArray alloc]initWithObjects:@"Phone number",@"Email",@"Password",nil];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == leftTableView){
        return 2;
    }else{
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == leftTableView){
        return [[leftCellArray objectAtIndex:section] count];
    }
    else{
        return [rightCellArray count];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(tableView == leftTableView){
        if(section == 0)
            return @"General";
        else
            return @"Address information";
    }else{
        if(section == 0)
            return @"Contact information";
        else
            return @"Others";
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == leftTableView){
        UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"leftcell"];
        if(oneCell == nil)
        {
            oneCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"] autorelease];
        }
        detailField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
        [detailField setEnabled:NO];
        detailField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
        detailField.text = @"";
        [oneCell addSubview:detailField];
        [detailField release];
        if(indexPath.section == 0){
            switch (indexPath.row) {
                case 0:
                    detailField.text = self.customerItem.cus_Firstname;
                    break;
                case 1:
                    detailField.text = self.customerItem.cus_Lastname;
                    break;
                case 2:
                    detailField.text = self.customerItem.cus_Gender;
                    break;
                case 3:
                    detailField.text = self.customerItem.cus_Date;
                    break;
                default:
                    break;
            }
        }else{
            switch (indexPath.row) {
                case 0:
                    detailField.text = self.customerItem.cus_Country;
                    break;
                case 1:
                    detailField.text = self.customerItem.cus_City;
                    break;
                case 2:
                    detailField.text = self.customerItem.cus_UnitNumber;
                    break;
                case 3:
                    detailField.text = self.customerItem.cus_BuildingName;
                    break;
                case 4:
                    detailField.text = self.customerItem.cus_StreetName;
                    break;
                case 5:
                    detailField.text = self.customerItem.cus_Landmark;
                    break;
                case 6:
                    detailField.text = self.customerItem.cus_PostalCode;
                    break;
                default:
                    break;
            }
 
        }
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        oneCell.textLabel.text = [[leftCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return oneCell;
    }
    else
    {
        UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"rightcell"];
        if(oneCell == nil)
        {
            oneCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rightcell"] autorelease];
        }
        detailField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
        [detailField setEnabled:NO];
        detailField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
        detailField.text = @"";
        [oneCell addSubview:detailField];
        [detailField release];
        switch (indexPath.row) {
            case 0:
                detailField.text = self.customerItem.cus_PhoneNumber;
                break;
            case 1:
                detailField.text = self.customerItem.cus_Email;
                break;
            case 2:
                detailField.text = @"*******";
                break;
            default:
                break;
        }

        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        oneCell.textLabel.text = [rightCellArray objectAtIndex:indexPath.row];
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
