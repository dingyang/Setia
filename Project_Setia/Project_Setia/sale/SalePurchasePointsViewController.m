//
//  SalePurchasePointsViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 19/7/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "SalePurchasePointsViewController.h"
#import "PostDataToServer.h"
#import "PostReturnValue.h"
@interface SalePurchasePointsViewController ()
@end

@implementation SalePurchasePointsViewController
@synthesize PurchaseTableView;
@synthesize customerItem;
@synthesize saleItem;
@synthesize customerFirstName,customerLastName;
@synthesize discount,store,user,purchaseAmount,netAmount,pointsRedeemed,comments,customerCountryCode,customerPhoneNumber;
-(void)dealloc
{
    [PurchaseTableView release];
    [purchaseCellArray release];
    [customerItem release];
    [saleItem release];
    [customerFirstName release];
    [customerLastName release];
    self.discount = nil;
    self.store = nil;
    self.user = nil;
    self.purchaseAmount = nil;
    self.netAmount = nil;
    self.pointsRedeemed = nil;
    self.comments = nil;
    self.customerPhoneNumber = nil;
    self.customerCountryCode = nil;

    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Purchase";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"customerCountryCode------>%@",self.customerCountryCode);
    NSLog(@"customerPhoneNumber------>%@",self.customerPhoneNumber);
    PurchaseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768-44-35) style:UITableViewStyleGrouped];
    PurchaseTableView.delegate = self;
    PurchaseTableView.dataSource = self;
    PurchaseTableView.scrollEnabled = NO;
    [self.view addSubview:PurchaseTableView];
    [PurchaseTableView release];
        
    //初始化静态UITableViewCell;
    [self initUITableViewCell];
    //初始化post到server端的数组 和 server端的字段数组
    postToServerDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    serverKeysArray = [[NSArray alloc]initWithObjects:@"customer_id",@"customer_firstname",@"customer_lastname",@"discount",@"store_name",@"user_name",@"total_amount",@"actual_amount",@"date_entered",@"merchant_name",@"merchant_id",@"store_id",@"customer_countrycode",@"customer_phonenumber",nil];
    
    NSMutableArray *purchaseCell = [[NSMutableArray alloc]initWithObjects:@"Customer firstname",@"Customer lastname",@"Balance Points before this transaction",@"Store",@"User",@"Purchase amount that qualifies for discount",@"Points that offset the price of this purchase",@"Net Amount (actual amount transacted)",@"Points redeemed",@"Comments",nil];
    purchaseCellArray = [[NSMutableArray alloc]initWithObjects:purchaseCell,nil];
    
    UIImageView *setiaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(35,768-44-35-180, 169, 169)];
    [setiaImageView setImage:[UIImage imageNamed:@"logo-setia.png"]];
    [self.view addSubview:setiaImageView];
    [setiaImageView release];
    
    UIButton *makeSaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [makeSaleButton setBackgroundImage:[UIImage imageNamed:@"btn-make-sale-orange.png"] forState:UIControlStateNormal];
    makeSaleButton.frame = CGRectMake(682, 768-44-35-166, 300, 40);
    [makeSaleButton addTarget:self action:@selector(makeSale) forControlEvents:UIControlEventTouchUpInside];
    [PurchaseTableView addSubview:makeSaleButton];
    
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
    PurchaseTableView.frame = CGRectMake(0, 0, 1024, 768-44-35-size.width + 35);
    PurchaseTableView.scrollEnabled = YES;
    [UIView commitAnimations];
}
-(void)keyboardWillHide:(NSNotification*)noti{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    PurchaseTableView.frame = CGRectMake(0, 0,1024, 768-44-35);
    PurchaseTableView.scrollEnabled = NO;
    [UIView commitAnimations];
}
-(void)resignKeyBoard{
    [detailField resignFirstResponder];
}
#pragma mark ----makeSale
-(void)makeSale{
    [self.view endEditing:YES];
    if ([pointsField.text intValue]< [pointsOffsettingField.text intValue]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Points that offset the price of this purchase shouldn't be more than Balance Points before this transaction!"  delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    if(self.customerId!=nil){
        [postToServerDataArray addObject:self.customerId];
    }else{
        [postToServerDataArray addObject:@""];
    }
    for (int i=100; i<=105; i++) {
        if (i==102) {
            [postToServerDataArray addObject:[NSString stringWithFormat:@"%d",[pointsField.text intValue]-[pointsOffsettingField.text intValue]+ [pointsRedeemedField.text intValue]]];
        }else{
        UITextField *tf = (UITextField *)[self.view viewWithTag:i];
        [postToServerDataArray addObject:tf.text];
        }
    }
    [postToServerDataArray addObject:netAmountField.text];
    
    UITextView *tv = (UITextView*)[self.view viewWithTag:109];
    [postToServerDataArray addObject:tv.text];
    //add chainname
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"chainname"]!=nil){
        [postToServerDataArray addObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"chainname"]];
    }else{
        [postToServerDataArray addObject:@""];
    }
    //add chainid
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"chainid"]!=nil){
        [postToServerDataArray addObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"chainid"]];
    }else{
        [postToServerDataArray addObject:@""];
    }
    //add storeid
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"storeid"]!=nil){
        [postToServerDataArray addObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"storeid"]];
    }else{
        [postToServerDataArray addObject:@""];
    }
    //add customerContryCode
    if(self.customerCountryCode!=nil){
        [postToServerDataArray addObject:self.customerCountryCode];
    }else{
        [postToServerDataArray addObject:@""];
    }
    //add customerPhoneNumber
    if(self.customerPhoneNumber!=nil){
        [postToServerDataArray addObject:self.customerPhoneNumber];
    }else{
        [postToServerDataArray addObject:@""];
    }
    NSLog(@"[postToServerDataArray count]----->%d",[postToServerDataArray count]);
    NSDictionary *dict = [[NSDictionary alloc]initWithObjects:postToServerDataArray forKeys:serverKeysArray];
    PostDataToServer *postServer = [[PostDataToServer alloc]init];
    [postServer postServerDataMappingForClass:[PostReturnValue class] mappingsFromDictionary:@{@"status":@"returnValue"}
                           appendingUrlString:@"Trx" postParameters:dict pathPattern:nil keyPath:nil Delegate:self];
    [postToServerDataArray removeAllObjects];
}
#pragma mark ----PostServerDataDelegate
-(void)postServerDataDidFinish:(NSArray *)serverData{
    PostReturnValue *value = (PostReturnValue *)[serverData objectAtIndex:0];
    NSLog(@"value.returnValue--->%@",value.returnValue);
    UIAlertView *alart = [[UIAlertView alloc]initWithTitle:@"Notification" message:@"Transaction successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alart show];
    [alart release];
}
-(void)postServerDateFailed{
    NSLog(@"postServerDateFailed");
    UIAlertView *alart = [[UIAlertView alloc]initWithTitle:@"Notification" message:@"Transaction failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alart show];
    [alart release];
}
#pragma mark ---UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [purchaseCellArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[purchaseCellArray objectAtIndex:section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 9)
        return 80;
    else
        return 43;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"General";
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row == 0) {
            firstnameCell.textLabel.text = [[purchaseCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            return firstnameCell;
        }else if(indexPath.row == 1){
            lastnameCell.textLabel.text = [[purchaseCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            return lastnameCell;
        }else if(indexPath.row == 2){
            pointsCell.textLabel.text = [[purchaseCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            return pointsCell;
        }else if(indexPath.row == 3){
            storeCell.textLabel.text = [[purchaseCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            return storeCell;
        }else if(indexPath.row == 4){
            userCell.textLabel.text = [[purchaseCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            return userCell;
        }else if(indexPath.row == 5){
            if (![[isHasContent objectAtIndex:indexPath.row] intValue]) {
                grossAmountField.placeholder = @"Input purchase amount";
            }
            grossAmountCell.textLabel.text = [[purchaseCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            return grossAmountCell;
        }else if(indexPath.row == 6){
            pointsOffsettingCell.textLabel.text = [[purchaseCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            return pointsOffsettingCell;
        }else if(indexPath.row == 7){
            if (![[isHasContent objectAtIndex:indexPath.row] intValue]) {
                netAmountField.placeholder = @"Input net amount";
            }
            netAmountCell.textLabel.text = [[purchaseCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            return netAmountCell;
        }else if(indexPath.row == 8){
            pointsRedeemedCell.textLabel.text = [[purchaseCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                return pointsRedeemedCell;
        }
        else{
            commentCell.textLabel.text = [[purchaseCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            return commentCell;
    }    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [isHasContent replaceObjectAtIndex:textField.tag+100 withObject:[NSNumber numberWithBool:YES]];
    UITextField *netAmountTF = (UITextField*)[self.view viewWithTag:107];
    if(textField == netAmountTF){
        UITextField *pointsRedeemedTF = (UITextField*)[self.view viewWithTag:108];
        pointsRedeemedTF.text =netAmountTF.text;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if(PurchaseTableView.contentOffset.y >= 187 || PurchaseTableView.contentOffset.y <=-1){
//        PurchaseTableView.scrollEnabled = NO;
//        [self performSelector:@selector(setTableViewScrolled) withObject:nil afterDelay:0.01];
//    }
//    NSLog(@"%f",PurchaseTableView.contentOffset.y);
}
-(void)setTableViewScrolled{
    PurchaseTableView.scrollEnabled = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ---init UITableViewCell
-(void)initUITableViewCell{
    firstnameCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    firstnameCell.selectionStyle = UITableViewCellSelectionStyleNone;
    firstnameField = [[UITextField alloc]initWithFrame:CGRectMake(762, 12, 300, 25)];
    [firstnameCell addSubview:firstnameField];
    if(self.customerFirstName != nil)
        firstnameField.text = self.customerFirstName;
    else
        firstnameField.text = @"";
    firstnameField.delegate = self;
    firstnameField.tag = 100;
    firstnameField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
    [firstnameField release];
    
    lastnameCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    lastnameCell.selectionStyle = UITableViewCellSelectionStyleNone;
    lastnameField = [[UITextField alloc]initWithFrame:CGRectMake(762, 12, 300, 25)];
    [lastnameCell addSubview:lastnameField];
    if(self.customerLastName != nil)
        lastnameField.text = self.customerLastName;
    else
        lastnameField.text = @"";
    lastnameField.delegate = self;
    lastnameField.tag = 101;
    lastnameField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
    [lastnameField release];
    
    pointsCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"] ;
    pointsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    pointsField = [[UITextField alloc]initWithFrame:CGRectMake(762, 12, 300, 25)];
    [pointsCell addSubview:pointsField];
    if(self.discount != nil)
        pointsField.text = self.discount;
    else
        pointsField.text = @"0";
    pointsField.enabled = NO;
    pointsField.delegate = self;
    pointsField.tag = 102;
    pointsField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
    [pointsField release];
    
    storeCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    storeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    storeField = [[UITextField alloc]initWithFrame:CGRectMake(762, 12, 300, 25)];
    [storeCell addSubview:storeField];
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"storename"]!=nil)
        storeField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"storename"];
    else
        storeField.text = @"";
    storeField.delegate = self;
    storeField.tag = 103;
    storeField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
    [storeField release];
    
    userCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    userCell.selectionStyle = UITableViewCellSelectionStyleNone;
    userField= [[UITextField alloc]initWithFrame:CGRectMake(762, 12, 300, 25)];
    [userCell addSubview:userField];
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"account"]!=nil)
        userField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"account"];
    else
        userField.text = @"";
    userField.delegate = self;
    userField.tag = 104;
    userField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
    [userField release];
    
    grossAmountCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    grossAmountCell.selectionStyle = UITableViewCellSelectionStyleNone;
    grossAmountField= [[UITextField alloc]initWithFrame:CGRectMake(762, 12, 300, 25)];
    [grossAmountCell addSubview:grossAmountField];
    grossAmountField.text = @"";
    grossAmountField.delegate = self;
    grossAmountField.tag = 105;
    grossAmountField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
    [grossAmountField release];
    
    pointsOffsettingCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    pointsOffsettingCell.selectionStyle = UITableViewCellSelectionStyleNone;
    pointsOffsettingField= [[UITextField alloc]initWithFrame:CGRectMake(762, 12, 300, 25)];
    [pointsOffsettingCell addSubview:pointsOffsettingField];
    pointsOffsettingField.text = @"";
    pointsOffsettingField.delegate = self;
    pointsOffsettingField.tag = 106;
    pointsOffsettingField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
    [pointsOffsettingField release];
    
    netAmountCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    netAmountCell.selectionStyle = UITableViewCellSelectionStyleNone;
    netAmountField= [[UITextField alloc]initWithFrame:CGRectMake(762, 12, 300, 25)];
    [netAmountCell addSubview:netAmountField];
    netAmountField.text = @"";
    netAmountField.delegate = self;
    netAmountField.tag = 107;
    netAmountField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
    [netAmountField release];
    
    pointsRedeemedCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    pointsRedeemedCell.selectionStyle = UITableViewCellSelectionStyleNone;
    pointsRedeemedField= [[UITextField alloc]initWithFrame:CGRectMake(762, 12, 300, 25)];
    [pointsRedeemedCell addSubview:pointsRedeemedField];
    pointsRedeemedField.text = @"";
    pointsRedeemedField.delegate = self;
    pointsRedeemedField.tag = 108;
    pointsRedeemedField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
    [pointsRedeemedField release];
    
    commentCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"];
    commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    commentsTextView = [[UITextView alloc]initWithFrame:CGRectMake(662, 0, 300, 80)];
    commentsTextView.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
    commentsTextView.font = [UIFont systemFontOfSize:18];
    commentsTextView.backgroundColor = [UIColor clearColor];
    commentsTextView.text = @"";
    commentsTextView.tag = 109;
    [commentCell addSubview:commentsTextView];
    [commentsTextView release];
    
    for (int i=100; i<109; i++) {
		[isHasContent addObject:[NSNumber numberWithBool:NO]];
	}
}

@end
