//
//  SalePurchaseViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 8/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "SalePurchaseViewController.h"
#import "PostDataToServer.h"
#import "PostReturnValue.h"
@interface SalePurchaseViewController ()
@end

@implementation SalePurchaseViewController
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
    
    //初始化post到server端的数组 和 server端的字段数组
    postToServerDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    serverKeysArray = [[NSArray alloc]initWithObjects:@"customer_id",@"customer_firstname",@"customer_lastname",@"discount",@"store_name",@"user_name",@"total_amount",@"actual_amount",@"date_entered",@"merchant_name",@"merchant_id",@"store_id",@"customer_countrycode",@"customer_phonenumber",nil];
    
    NSMutableArray *purchaseCell = [[NSMutableArray alloc]initWithObjects:@"Customer firstname",@"Customer lastname",@"Discount",@"Store",@"User",@"Purchase amount that qualifies for discount/points",@"Net Amount(actual amount transacted)",@"Points redeemed",@"Comments",nil];
    purchaseCellArray = [[NSMutableArray alloc]initWithObjects:purchaseCell,nil];
    
    UIImageView *setiaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(35,768-44-35-189, 169, 169)];
    [setiaImageView setImage:[UIImage imageNamed:@"logo-setia.png"]];
    [self.view addSubview:setiaImageView];
    [setiaImageView release];
    
    UIButton *makeSaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [makeSaleButton setBackgroundImage:[UIImage imageNamed:@"btn-make-sale-orange.png"] forState:UIControlStateNormal];
    makeSaleButton.frame = CGRectMake(682, 768-44-35-209, 300, 40);
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
-(void)makeSale{
    [self.view endEditing:YES];
    if(self.customerId!=nil){
        [postToServerDataArray addObject:self.customerId];
    }else{
        [postToServerDataArray addObject:@""];
    }
    for (int i=100; i<=106; i++) {
        UITextField *tf = (UITextField *)[self.view viewWithTag:i];
        [postToServerDataArray addObject:tf.text];
    }
    UITextView *tv = (UITextView*)[self.view viewWithTag:108];
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
    if(indexPath.row == 8)
        return 80;
    else
        return 43;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"General";
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"leftcell"];
    if(oneCell == nil)
    {
        oneCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"] autorelease];
    }
    detailField = [[UITextField alloc]initWithFrame:CGRectMake(762, 12, 300, 25)];
    detailField.tag = indexPath.row + 100;
    if(indexPath.row == 5){
        detailField.placeholder = @"Input purechase amount";
        detailField.delegate = self;
    }
    if (indexPath.row == 2) {
        detailField.text = @"1.00";
    }
    if(indexPath.row == 8){
        detailField.enabled = NO;
        commentsTextView = [[UITextView alloc]initWithFrame:CGRectMake(662, 0, 300, 80)];
        commentsTextView.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
        commentsTextView.font = [UIFont systemFontOfSize:18];
        commentsTextView.backgroundColor = [UIColor clearColor];
        commentsTextView.text = @"";
        commentsTextView.tag = 108;
        [oneCell addSubview:commentsTextView];
        [commentsTextView release];
    }
    detailField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
    detailField.text = @"";
    [oneCell addSubview:detailField];
    [detailField release];
    switch (indexPath.row) {
        case 0:
            if(self.customerFirstName != nil)
            detailField.text = self.customerFirstName;
            break;
        case 1:
            if(self.customerLastName != nil)
                detailField.text = self.customerLastName;
            break;
        case 2:
            if(self.discount != nil){
                detailField.text = self.saleItem.discount;
            }else{
                detailField.text = @"1.00";
            }
            break;
        case 3:
            if([[NSUserDefaults standardUserDefaults]objectForKey:@"storename"]!=nil){
                detailField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"storename"];
            }
            break;
        case 4:
            //detailField.text = self.user;
            if([[NSUserDefaults standardUserDefaults]objectForKey:@"account"]!=nil){
                detailField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"account"];
            }
            break;
        default:
            break;
    }
    oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
    oneCell.textLabel.text = [[purchaseCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return oneCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    UITextField *discountAmountTF = (UITextField*)[self.view viewWithTag:102];
    UITextField *purchaseAmountTF = (UITextField*)[self.view viewWithTag:105];
    UITextField *netAmountTF = (UITextField*)[self.view viewWithTag:106];
    if(textField == purchaseAmountTF){
        netAmountTF.text = [NSString stringWithFormat:@"%.2f",[discountAmountTF.text floatValue]*[purchaseAmountTF.text floatValue]];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(PurchaseTableView.contentOffset.y>140 || PurchaseTableView.contentOffset.y<-1){
        PurchaseTableView.scrollEnabled = NO;
        [self performSelector:@selector(setTableViewScrolled) withObject:nil afterDelay:0.01];
    }
}
-(void)setTableViewScrolled{
    PurchaseTableView.scrollEnabled = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
