//
//  SaleViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 3/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "SaleViewController.h"
#import "SalePurchaseViewController.h"
#import "RestKit/RestKit.h"
#import "TopUpView.h"
#import "PutDataToServer.h"
#import "PutReturnValue.h"
@interface SaleViewController ()

@end

@implementation SaleViewController
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
        self.title = @"Sales";
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    dataArray = [[NSArray alloc]init];
    customerItem = [[CustomerItem alloc]init];
    
    leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 512, 768-44-35) style:UITableViewStyleGrouped];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.scrollEnabled = NO;
    [self.view addSubview:leftTableView];
    [leftTableView release];
    
    //query view    
    codeField = [[UITextField alloc]initWithFrame:CGRectMake(35, 40, 40, 40)];
    codeField.keyboardType = UIKeyboardTypeNumberPad;
    codeField.backgroundColor = [UIColor whiteColor];
    codeField.borderStyle = UITextBorderStyleRoundedRect;
    codeField.text = @"65";
    [self.view addSubview:codeField];
    [codeField release];
    
    phoneField = [[UITextField alloc]initWithFrame:CGRectMake(85, 40, 230, 40)];
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.backgroundColor = [UIColor whiteColor];
    phoneField.borderStyle = UITextBorderStyleRoundedRect;
    phoneField.placeholder = @"Please enter phone number";
    [self.view addSubview:phoneField];
    [phoneField release];
    
    UILabel *noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 80, 400, 40)];
    noteLabel.backgroundColor = [UIColor clearColor];
    noteLabel.text = @"Notes: enter code and phone number";
    [noteLabel setFont:[UIFont boldSystemFontOfSize:18]];
    noteLabel.textColor = [UIColor colorWithRed:0.2353f green:0.2627f blue:0.3569f alpha:1.0];
    noteLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:noteLabel];
    [noteLabel release];
    
    UIButton *queryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    queryButton.frame = CGRectMake(35, 120, 280, 40);
    [queryButton setBackgroundImage:[UIImage imageNamed:@"btn_query.png"] forState:UIControlStateNormal];
    [queryButton addTarget:self action:@selector(queryCustomer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queryButton];

    UIButton *saleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saleButton.frame = CGRectMake(35, 170, 280, 40);
    [saleButton setBackgroundImage:[UIImage imageNamed:@"btn_sale.png"] forState:UIControlStateNormal];
    [saleButton addTarget:self action:@selector(purchaseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saleButton];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"] isEqual:@"Prepaid"]){
        topUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        topUpButton.frame = CGRectMake(35, 220, 280, 40);
        //[topUpButton setBackgroundImage:[UIImage imageNamed:@"btn_sale.png"] forState:UIControlStateNormal];
        topUpButton.enabled = NO;
        [topUpButton setTitle:@"Top Up" forState:UIControlStateNormal];
        [topUpButton addTarget:self action:@selector(topUpAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:topUpButton];
    }
    
    UIImageView *setiaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(35,768-44-35-189, 169, 169)];
    [setiaImageView setImage:[UIImage imageNamed:@"logo-setia.png"]];
    [self.view addSubview:setiaImageView];
    [setiaImageView release];
    
    rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(512, 0, 512, 768-44-35) style:UITableViewStyleGrouped];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.scrollEnabled = NO;
    [self.view addSubview:rightTableView];
    [rightTableView release];
        
    NSMutableArray *rightCellArray_customerInformation = [[NSMutableArray alloc]initWithObjects:@"Customer firstname",@"Customer lastname",@"Country of origin",@"Customer email",@"Customer mobile",@"Date of birth",nil];
    rightCellArray = [[NSMutableArray alloc]initWithObjects:rightCellArray_customerInformation,nil];
    
    //初始化SalePurchaseViewController
    //salePurchaseVcl = [[SalePurchaseViewController alloc]init];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeTopUpView) name:@"closeTopUpView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(prepaidAction) name:@"prepay" object:nil];
}
-(void)removeTopUpView{
    [topView removeFromSuperview];
}
-(void)prepaidAction{
    prepaidAlert = [[UIAlertView alloc]initWithTitle:nil message:[[NSString alloc] initWithFormat:@"Will prepay %@ to %@ %@'s account?",topView.prepaidTF.text,customerItem.cus_Firstname,customerItem.cus_Lastname] delegate:self cancelButtonTitle:@"Sure" otherButtonTitles:@"Cancel",nil];
    [prepaidAlert show];
    [prepaidAlert release];
    

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == prepaidAlert && buttonIndex == 0) {
        NSString *pathStr = [[NSString alloc]initWithFormat:@"http://198.199.107.25/API/Points/customer_id:%@,merchant_id:%@.json",customerItem.cus_LoginId,[[NSUserDefaults standardUserDefaults] objectForKey:@"chainid"]];
        NSDictionary *params = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:topView.prepaidTF.text,nil] forKeys:[NSArray arrayWithObjects:@"new_points", nil]];
        PutDataToServer *putServer = [[PutDataToServer alloc]init];
        
        [putServer putServerDataMappingForClass:[PutReturnValue class] mappingsFromDictionary:@{@"status":@"returnValue"} urlString:@"http://198.199.107.25/API/Points/" postParameters:params pathPattern:nil keyPath:pathStr Delegate:self];
        [topView removeFromSuperview];
    }
    
}
-(void)putServerDataDidFinish:(NSArray *)serverData{
    dataArray = [serverData copy];
    PutReturnValue *value = (PutReturnValue *)[serverData objectAtIndex:0];
    NSLog(@"value.returnValue--->%@",value.returnValue);
    int points = [value.returnValue intValue];
    if (points>0) {
       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Prepaid successfully!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
        customerItem.cus_Discount = value.returnValue;
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Prepaid Failed,Please retry!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    
}
-(void)topUpAction{
    topView = [[TopUpView alloc]initWithFrame:CGRectMake(0, 0, 1024, 733)];
    [self.view addSubview:topView];    
}
-(void)queryCustomer
{
    if(codeField.text.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter country code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    if(phoneField.text.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter phone number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    if(isQueryBtnPressed == 0)
    {
        NSString *queryStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",@"Customer/country_code:",codeField.text,@",phone_number:",phoneField.text,@",merchant_id:",[[NSUserDefaults standardUserDefaults] objectForKey:@"chainid"],@".json"];
                
        serverDataGetter = [[GetServerData alloc]init];
        [serverDataGetter getServerDataMappingForClass:[CustomerItem class]mappingsFromDictionary:@{@"id": @"cus_LoginId",@"country_code": @"cus_CountryCode",@"phone_number": @"cus_PhoneNumber",@"firstname": @"cus_Firstname",@"lastname": @"cus_Lastname",@"birthday": @"cus_Date",@"email": @"cus_Email",@"gender": @"cus_Gender",@"country": @"cus_Country",@"password": @"cus_Password",@"city":@"cus_City",@"unit_number":@"cus_UnitNumber",@"building_name":@"cus_BuildingName",@"street_name":@"cus_StreetName",@"landmark":@"cus_Landmark",@"postal_code":@"cus_PostalCode",@"discount":@"cus_Discount",} pathPattern:nil keyPath:@"user" appendingUrlString:queryStr Delegate:self];
        isQueryBtnPressed = 1;
        return;
    }
    if(isQueryBtnPressed == 1)
    {
        topUpButton.enabled = NO;//查询完毕后，禁用充值按钮；
        
        codeField.text = @"65";
        phoneField.text = @"";
        firstNameField.text = @"";
        lastNameField.text = @"";
        countryField.text = @"";
        emailField.text = @"";
        mobileField.text = @"";
        dateField.text = @"";
        isQueryBtnPressed =0;
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"] isEqual:@"Fixed discount"]){
              customerItem.cus_Discount = @"1";
        }else{
            customerItem.cus_Discount = @"0";
        }
        return;
    }
}
-(void)getServerDataDidFinish:(NSArray *)serverData{
    isQuerySuccessful = YES;
    //能查到有此会员才能，充值；
    topUpButton.enabled = YES;
    dataArray = [serverData copy];
    customerItem = (CustomerItem*)[dataArray objectAtIndex:0];
    NSLog(@"customerItem.cus_Discount--->%@",customerItem.cus_Discount);
    [firstNameField removeFromSuperview];
    [lastNameField removeFromSuperview];
    [countryField removeFromSuperview];
    [emailField removeFromSuperview];
    [mobileField removeFromSuperview];
    [dateField removeFromSuperview];
    
    [rightTableView reloadData];
}
-(void)getServerDateFailed{
    NSLog(@"queryCustomerFailed");
    isQuerySuccessful = NO;
}
-(void)purchaseAction{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"] isEqual:@"Fixed discount"]){
        salePurchaseVcl = [[SalePurchaseViewController alloc]init];
        if(isQuerySuccessful == YES){
            salePurchaseVcl.customerId = customerItem.cus_LoginId;
            salePurchaseVcl.customerFirstName = firstNameField.text;
            salePurchaseVcl.customerLastName = lastNameField.text;
            if (customerItem.cus_Discount != nil) {
                salePurchaseVcl.discount = customerItem.cus_Discount;
            }else{
                salePurchaseVcl.discount = @"";
            }
        }
        salePurchaseVcl.customerCountryCode = codeField.text;
        salePurchaseVcl.customerPhoneNumber = phoneField.text;
        salePurchaseVcl.store = [[NSUserDefaults standardUserDefaults] objectForKey:@"storename"];
        salePurchaseVcl.user = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
        
        [self.navigationController pushViewController:salePurchaseVcl animated:YES];
        [self performSelector:@selector(removeData) withObject:nil afterDelay:0.5];
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"] isEqual:@"Points"]){
        salePurchasePointsVcl = [[SalePurchasePointsViewController alloc]init];
        if(isQuerySuccessful == YES){
            salePurchasePointsVcl.customerId = customerItem.cus_LoginId;
            salePurchasePointsVcl.customerFirstName = firstNameField.text;
            salePurchasePointsVcl.customerLastName = lastNameField.text;
            salePurchasePointsVcl.discount = customerItem.cus_Discount;
        }
        salePurchasePointsVcl.customerCountryCode = codeField.text;
        salePurchasePointsVcl.customerPhoneNumber = phoneField.text;
        salePurchasePointsVcl.store = [[NSUserDefaults standardUserDefaults] objectForKey:@"storename"];
        salePurchasePointsVcl.user = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
        
        [self.navigationController pushViewController:salePurchasePointsVcl animated:YES];
        [self performSelector:@selector(removeData) withObject:nil afterDelay:0.5];

    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"] isEqual:@"Prepaid"]){
        salePurchasePrepaidVcl = [[SalePurchasePrepaidViewController alloc]init];
        if(isQuerySuccessful == YES){
            salePurchasePrepaidVcl.customerId = customerItem.cus_LoginId;
            salePurchasePrepaidVcl.customerFirstName = firstNameField.text;
            salePurchasePrepaidVcl.customerLastName = lastNameField.text;
            salePurchasePrepaidVcl.discount = customerItem.cus_Discount;
        }
        salePurchasePrepaidVcl.customerCountryCode = codeField.text;
        salePurchasePrepaidVcl.customerPhoneNumber = phoneField.text;
        salePurchasePrepaidVcl.store = [[NSUserDefaults standardUserDefaults] objectForKey:@"storename"];
        salePurchasePrepaidVcl.user = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
        
        [self.navigationController pushViewController:salePurchasePrepaidVcl animated:YES];
        [self performSelector:@selector(removeData) withObject:nil afterDelay:0.5];
    }
}
-(void)removeData{
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == leftTableView)
        return 1;
    else
        return [rightCellArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == leftTableView){
        return 0;
    }else
    {
        return [[rightCellArray objectAtIndex:section] count];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView == leftTableView){
        return @"Query customer";
    }else{
        return @"Customer Information";
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == leftTableView){
        UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"leftcell"];
        return oneCell;
    }else{
        UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"rightcell"];
        if(oneCell == nil)
        {
            oneCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rightcell"] autorelease];
        }
//        detailField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
//        [detailField resignFirstResponder];
//        detailField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
        if([dataArray count] != 0)
        {
            if(indexPath.row == 0)
            {
                firstNameField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
                [firstNameField resignFirstResponder];
                firstNameField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
                firstNameField.text = customerItem.cus_Firstname;
                //[NSString stringWithFormat:@"%@ %@",customerItem.cus_Firstname,customerItem.cus_Lastname];
                [oneCell addSubview:firstNameField];
                [firstNameField release];
            }
            else if (indexPath.row == 1)
            {
                lastNameField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
                [lastNameField resignFirstResponder];
                lastNameField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
                lastNameField.text = customerItem.cus_Lastname;
                [oneCell addSubview:lastNameField];
                [lastNameField release];
            }
            else if(indexPath.row == 2)
            {
                countryField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
                [countryField resignFirstResponder];
                countryField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
                countryField.text = customerItem.cus_Country;
                [oneCell addSubview:countryField];
                [countryField release];
            }
            else if(indexPath.row == 3)
            {
                emailField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
                [emailField resignFirstResponder];
                emailField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
                emailField.text = customerItem.cus_Email;
                [oneCell addSubview:emailField];
                [emailField release];
            }
            else if(indexPath.row == 4)
            {
                mobileField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
                [mobileField resignFirstResponder];
                mobileField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
                mobileField.text = customerItem.cus_PhoneNumber;
                [oneCell addSubview:mobileField];
                [mobileField release];
            }
            else
            {
                dateField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
                [dateField resignFirstResponder];
                dateField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
                dateField.text = customerItem.cus_Date;
                [oneCell addSubview:dateField];
                [dateField release];
            }
        }
//        [oneCell addSubview:detailField];
//        [detailField release];
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        oneCell.textLabel.text = [[rightCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
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
