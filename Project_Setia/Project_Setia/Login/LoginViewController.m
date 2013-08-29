//
//  LoginViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "CheckNetWorkIsAvailable.h"
#import "SuperAdministratorItem.h"
#import "ChangePasswordViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
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
        self.title = @"Login";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //设置getterNum,区分getter;
    getterNum = 1;
    
    dataArray = [[NSArray alloc]init];
    
    settingsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 512, 768-44) style:UITableViewStyleGrouped];
    settingsTableView.delegate = self;
    settingsTableView.dataSource = self;
    settingsTableView.scrollEnabled = NO;
    [self.view addSubview:settingsTableView];
    [settingsTableView release];
    
    blankTableView = [[UITableView alloc]initWithFrame:CGRectMake(512, 0, 512, 768-44) style:UITableViewStyleGrouped];
    blankTableView.delegate = self;
    blankTableView.dataSource = self;
    blankTableView.scrollEnabled = NO;
    [self.view addSubview:blankTableView];
    [blankTableView release];
    
    UIImageView *setiaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(35,768-44-189, 169, 169)];
    [setiaImageView setImage:[UIImage imageNamed:@"logo-setia.png"]];
    [self.view addSubview:setiaImageView];
    [setiaImageView release];
    
    NSMutableArray *settingsCell = [[NSMutableArray alloc]initWithObjects:@"Registered ID",@"Password",nil];
    settingsCellArray = [[NSMutableArray alloc]initWithObjects:settingsCell,nil];
    
    UIButton *lonin = [UIButton buttonWithType:UIButtonTypeCustom];
    [lonin setBackgroundImage:[UIImage imageNamed:@"btn_login.png"] forState:UIControlStateNormal];
    lonin.frame = CGRectMake(32, 150, 450, 40);
    [lonin addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lonin];
    
    UIButton *pwButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pwButton.frame = CGRectMake(32, 200, 150, 40);
    [pwButton addTarget:self action:@selector(resetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    [pwButton setTitle:@"Forgot password?" forState:UIControlStateNormal];
//    [pwButton.titleLabel setTextColor:[UIColor colorWithRed:0.1294f green:0.4353f blue:0.7608f alpha:1.0f]];
//    [pwButton setTintColor:[UIColor colorWithRed:0.1294f green:0.4353f blue:0.7608f alpha:1.0f]];
    [pwButton setTitleColor:[UIColor colorWithRed:0.1294f green:0.4353f blue:0.7608f alpha:1.0f] forState:UIControlStateNormal];
    [pwButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:pwButton];
    
    UILabel *rightNoteLabel = [[UILabel alloc]initWithFrame:CGRectMake(490, 40, 450, 45)];
    rightNoteLabel.text = @"NOTE: RegisteredID is any of the login name authorised by merchant to carry out transactions on its behalf";
    rightNoteLabel.numberOfLines = 0;
    rightNoteLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:rightNoteLabel];
    [rightNoteLabel release];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissMainVCL) name:@"logout" object:nil];
    
    CheckNetWorkIsAvailable *checkNet = [[CheckNetWorkIsAvailable alloc]init];
    NSLog(@"%d",[checkNet netWorkIsExistence]);
}
-(void)resetPasswordAction{
    ChangePasswordViewController *pwVcl = [[ChangePasswordViewController alloc]init];
    [self.navigationController pushViewController:pwVcl animated:YES];
}
-(void)dismissMainVCL
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)loginAction
{
    /*
    MainViewController *mainVcl = [[MainViewController alloc]init];
    mainVcl.roleValue = 3;
    [self presentViewController:mainVcl animated:YES completion:nil];
     */
     defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accountField.text forKey:@"account"];
    [defaults setObject:passwordField.text forKey:@"password"];
    
    NSString *loginStr = [NSString stringWithFormat:@"%@%@%@%@%@",@"User/user_name:",accountField.text,@",password:",passwordField.text,@".json"];
    serverDataGetter = [[GetServerData alloc]init];
    [serverDataGetter getServerDataMappingForClass:[SuperAdministratorItem class]mappingsFromDictionary:@{@"id": @"userId",@"type": @"type",@"country_code": @"code",@"phone_number1": @"phone1number",@"phone_number2": @"phone2number",@"firstname": @"firstname",@"lastname": @"lastname",@"birthday": @"birthday",@"email": @"email",@"gender": @"gender",@"country": @"country",@"password": @"password",@"registertime": @"registertime",@"merchant_id": @"chainId",@"merchant_name": @"chainname",@"store_id": @"storeId",@"store_name": @"storename",@"user_name": @"username"} pathPattern:nil keyPath:@"user" appendingUrlString:loginStr Delegate:self];
        //添加指示器
        activiter = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
         activiter.frame = CGRectMake(200, 200, 100, 100);
        [activiter startAnimating];
        [self.view addSubview:activiter];
        [activiter release];
}
#pragma mark -ServerDataDelegate
-(void)getServerDataDidFinish:(NSArray *)serverData{
    getterNum ++;
    NSLog(@"getterNum---->%d",getterNum);
    if(getterNum%2 == 0){
        dataArray = [serverData copy];
        superAdminItem = (SuperAdministratorItem*)[dataArray objectAtIndex:0];
        MainViewController *mainVcl = [[MainViewController alloc]init];
        mainVcl.roleValue = [superAdminItem.type integerValue];
        NSLog(@"mainVcl.roleValue----->%d",mainVcl.roleValue);
        [defaults setObject:superAdminItem.type forKey:@"usertype"];//获取用户身份
        [defaults setObject:superAdminItem.userId forKey:@"userid"];
        [defaults setInteger:mainVcl.roleValue forKey:@"roleValue"];
        [defaults setObject:superAdminItem.chainname forKey:@"chainname"];
        [defaults setObject:superAdminItem.chainId forKey:@"chainid"];
        NSLog(@"superAdminItem.chainId--->%@",superAdminItem.chainId);
        [defaults setObject:superAdminItem.storename forKey:@"storename"];
        NSLog(@"storename----->%@",[defaults objectForKey:@"storename"]);
        [defaults setObject:superAdminItem.storeId forKey:@"storeid"];
        NSLog(@"superAdminItem.storeId--->%@",superAdminItem.storeId);
        [defaults setObject:superAdminItem.firstname forKey:@"firstname"];
        [defaults setObject:superAdminItem.lastname forKey:@"lastname"];
        [defaults setObject:superAdminItem.code forKey:@"countrycode"];
        [defaults setObject:superAdminItem.email forKey:@"email"];
        [defaults setObject:superAdminItem.phone1number forKey:@"phone1"];
        [defaults setObject:superAdminItem.phone2number forKey:@"phone2"];
        
        //每次登陆完毕要重新设置promotionType
        [defaults setObject:@"" forKey:@"promotionType"];
        
        [activiter stopAnimating];
        [self presentViewController:mainVcl animated:YES completion:nil];
        //每一次登陆完毕之后都要申请一次promotionType;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"chainname"] != nil)
        {
            NSString *loginStr = [NSString stringWithFormat:@"%@%@%@",@"Merchant/name:",[[NSUserDefaults standardUserDefaults] objectForKey:@"chainname"],@".json"];
            serverDataGetter_promotionType = [[GetServerData alloc]init];
            [serverDataGetter_promotionType getServerDataMappingForClass:[SuperAdministratorItem class]mappingsFromDictionary:@{@"promotion_type": @"promotionType"} pathPattern:nil keyPath:@"merchant" appendingUrlString:loginStr Delegate:self];
        }else{
            getterNum ++;
        }
    }else{
        dataArray = [serverData copy];
        superAdminItem = (SuperAdministratorItem*)[dataArray objectAtIndex:0];
        [defaults setObject:superAdminItem.promotionType forKey:@"promotionType"];
        NSLog(@"superAdminItem.promotionType--->%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"promotionType"]);
    }
}
-(void)getServerDateFailed{
    [activiter stopAnimating];
    
    alert = [[UIAlertView alloc]initWithTitle:@"Warnings" message:@"Account or password is wrong!" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == settingsTableView)
        return [settingsCellArray count];
    else
        return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == settingsTableView)
        return [[settingsCellArray objectAtIndex:section] count];
    else
        return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"MerchantSystem Login";
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(oneCell == nil)
    {
        oneCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
    }
    if(indexPath.row == 0)
    {
        accountField = [[UITextField alloc]initWithFrame:CGRectMake(150, 2, 320, 40)];
        accountField.borderStyle = UITextBorderStyleBezel;
        accountField.text = @"yaoxue";
        NSLog(@"%@",[defaults objectForKey:@"account"]);
        if([defaults objectForKey:@"account"] != NULL){
            accountField.text = [defaults objectForKey:@"account"];
        }
        accountField.delegate = self;
        accountField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [oneCell addSubview:accountField];
        [accountField release];
    }
    if(indexPath.row == 1)
    {
        passwordField = [[UITextField alloc]initWithFrame:CGRectMake(150, 2, 320, 40)];
        passwordField.text = @"123456";
        if([defaults objectForKey:@"password"] != NULL){
            passwordField.text = [defaults objectForKey:@"password"];
        }
        passwordField.borderStyle = UITextBorderStyleBezel;
        passwordField.secureTextEntry = YES;
        passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [oneCell addSubview:passwordField];
        [passwordField release];
    }
    oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
    oneCell.textLabel.text = [[settingsCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return oneCell;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
  
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"logout" object:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
