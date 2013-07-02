//
//  DictionaryViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//
/*
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 // Do any additional setup after loading the view from its nib.
 
 [self.view setBackgroundColor:[UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.0f]];
 self.title = @"Transaction List";
 pickerViewItemsArray = [[NSArray alloc]initWithObjects:@"GaoYi",@"DingYang",@"DuRuiGuang",nil];
 
 UIApplication *app = [UIApplication sharedApplication];
 [app setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
 mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
 mySearchBar.delegate = self;
 UIView *segment = [mySearchBar.subviews objectAtIndex:0];
 [segment removeFromSuperview];
 mySearchBar.backgroundColor = [UIColor colorWithRed:1 green:0.3 blue:0.5 alpha:0.5];
 
 UITextField *searchField = [[mySearchBar subviews] lastObject];
 [searchField setReturnKeyType:UIReturnKeyDone];
 
 mySearchBar.barStyle = UIBarStyleBlackTranslucent;
 mySearchBar.keyboardType = UIKeyboardAppearanceDefault;
 mySearchBar.placeholder = @"Please Enter Something";
 //mySearchBar.prompt = @"Hello";
 mySearchBar.showsBookmarkButton = YES;
 mySearchBar.showsCancelButton = YES;
 mySearchBar.showsSearchResultsButton = YES;
 mySearchBar.showsScopeBar = YES;
 
 NSInteger numViews = [mySearchBar.subviews count];
 for(int i=0;i<numViews;i++)
 {
 if([[mySearchBar.subviews objectAtIndex:i] isKindOfClass:[UIButton class]])
 {
 UIButton *cancelbutton = (UIButton *)[mySearchBar.subviews objectAtIndex:i];
 [cancelbutton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
 }
 }
 
 [self.view addSubview:mySearchBar];
 
 pickerView = [[PickerView alloc]initWithFrame:CGRectMake(200, 100, 100, 50)];
 pickerView.showsSelectionIndicator = YES;
 pickerView.pickerViewItemsArray = [NSArray arrayWithArray:pickerViewItemsArray];
 NSLog(@"[pickerView.pickerViewItemsArray count]--->%d",[pickerView.pickerViewItemsArray count]);
 [self.view addSubview:pickerView];
 [pickerView release];
 
 
 
 onebutton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
 onebutton.frame = CGRectMake(400, 200, 100, 50);
 [onebutton setTitle:@"touch" forState:UIControlStateNormal];
 [onebutton addTarget:self action:@selector(showCurrentDate) forControlEvents:UIControlEventTouchUpInside];
 [self.view addSubview:onebutton];
 
 
 datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(100, 300, 200, 100)];
 datePicker.datePickerMode = UIDatePickerModeDate;
 [self.view addSubview:datePicker];
 [datePicker release];
 
 NSDate *select = [datePicker date];
 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
 [dateFormatter setDateFormat:@"yyyy-MM-dd"];
 NSString *date =  [dateFormatter stringFromDate:select];
 NSLog(@"date----->%@",date);
 }
 -(void)showCurrentDate{
 NSDate *select = [datePicker date];
 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
 [dateFormatter setDateFormat:@"yyyy-MM-dd"];
 NSString *date =  [dateFormatter stringFromDate:select];
 NSLog(@"date----->%@",date);
 }
 -(void)addAction{
 [self.view endEditing:YES];
 }
 -(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
 [onebutton resignFirstResponder];
 }
 //-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
 //{
 //    return 3;
 //}
 //-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
 //{
 //    return 1;
 //}
 //-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
 //    return [pickerViewItemsArray objectAtIndex:row];
 //}
 //-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
 //    NSLog(@"%@",[pickerViewItemsArray objectAtIndex:row]);
 //}
 -(void)cancelAction
 {
 [mySearchBar removeFromSuperview];
 }
 #pragma UISearchBarDelegate
 //任务编辑文本
 -(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
 {
 NSLog(@"shouldBeginEditing");
 return YES;
 }
 //开始编辑UISearchBar的textView时，调用此函数
 -(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
 {
 NSLog(@"didBeginEditing");
 }
 //要求
 -(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
 {
 NSLog(@"shouldEndEditing");
 return YES;
 }
 //当编辑完成之后调用此函数
 -(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
 {
 NSLog(@"didEndEditing");
 }
 //当textView的文字改变或者清除的时候调用此方法，搜索栏当前的状态正在编辑，在搜索文本字段中的当前文本
 -(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
 {
 NSLog(@"textDidChange:%@",searchText);
 }
 //当点击search的时候调用
 -(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
 {
 NSLog(@"searchButtonClicked");
 }
 */
/*Name, phone number, Gross Amount, Nett Amount*/

#import "DictionaryViewController.h"
#import "TransactionCellView.h"
#import "MBHUDUtil.h"
#import "TransactionItem.h"
@interface DictionaryViewController ()

@end

@implementation DictionaryViewController
@synthesize leftTableView,rightTableView,dateString;

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
    self.title = @"Transaction List";
    
    dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 512, 768-44-35) style:UITableViewStyleGrouped];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.scrollEnabled = NO;
    [self.view addSubview:leftTableView];
    [leftTableView release];
    // 标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 3, 150, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"Transactions";
    titleLabel.textColor = [UIColor colorWithRed:0.2353f green:0.2627f blue:0.3569f alpha:1.0f];
    //titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:titleLabel];
    [titleLabel release];
    //Daily Report
    UILabel *dailyReportLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 300, 100)];
    dailyReportLabel.backgroundColor = [UIColor clearColor];
    dailyReportLabel.text = @"Daily Report";
    dailyReportLabel.textColor = [UIColor blackColor];
    dailyReportLabel.font = [UIFont systemFontOfSize:32];
    [self.view addSubview:dailyReportLabel];
    [dailyReportLabel release];
    //date Picker
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(30, 120, 250, 100)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:datePicker];
    [datePicker release];
    
    NSDate *select = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.dateString =  [dateFormatter stringFromDate:select];
    NSLog(@"date----->%@",dateString);
    
    UIButton *viewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    viewButton.frame = CGRectMake(35, 310, 120, 60);
    [viewButton addTarget:self action:@selector(viewTransactionList) forControlEvents:UIControlEventTouchUpInside];
    [viewButton setBackgroundImage:[UIImage imageNamed:@"view.png"] forState:UIControlStateNormal];
    [self.view addSubview:viewButton];
    
    UIButton *send_PDF_Button = [UIButton buttonWithType:UIButtonTypeCustom];
    send_PDF_Button.frame = CGRectMake(35, 400, 120, 60);
    [send_PDF_Button addTarget:self action:@selector(sendPDF) forControlEvents:UIControlEventTouchUpInside];
    [send_PDF_Button setBackgroundImage:[UIImage imageNamed:@"send_PDF.png"] forState:UIControlStateNormal];
    [self.view addSubview:send_PDF_Button];
    
    rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(512, 0, 512, 768-44-35) style:UITableViewStyleGrouped];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.scrollEnabled = YES;
    [self.view addSubview:rightTableView];
    [rightTableView release];
    
    NSMutableArray *settingsCell = [[NSMutableArray alloc]initWithObjects:@"Logout",nil];
    rightCellArray = [[NSMutableArray alloc]initWithObjects:settingsCell,nil];
}
-(void)sendPDF{
   //firstName,lastName,countryCode,phoneNumber,grossAmount,nettAmount;
}
-(void)viewTransactionList{
    NSString *appendingUrlString = [NSString stringWithFormat:@"Trx/store_id:%@,date_from:%@,date_to:%@.json",[[NSUserDefaults standardUserDefaults] objectForKey:@"storeid"],dateString,dateString];
   // NSLog(@"appendingUrlString----->%@",appendingUrlString);
    serverDataGetter = [[GetServerData alloc]init];
    [serverDataGetter getServerDataMappingForClass:[TransactionItem class]mappingsFromDictionary:@{@"customer_firstname":@"firstName",@"customer_lastname":@"lastName",@"customer_countrycode":@"countryCode",@"customer_phonenumber":@"phoneNumber",@"total_amount":@"grossAmount",@"actual_amount":@"nettAmount"} pathPattern:nil keyPath:@"trx" appendingUrlString:appendingUrlString Delegate:self];
}
#pragma mark ----ServerDataDelegate
-(void)getServerDataDidFinish:(NSArray *)serverData{
    dataArray = [serverData copy];
    [rightTableView reloadData];
    
    [MBHUDUtil HUDShowMsg:self.view msg:@"Download finished" yOffset:100];
}
-(void)getServerDateFailed{
    NSLog(@"getServerDateFailed");
    [MBHUDUtil HUDShowMsg:self.view msg:@"Download failed !!! Check the network is available." yOffset:100];
}

#pragma mark ----UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == leftTableView)
        return 0;
    else
        return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == leftTableView)
        return 0;
    else{
        if(section == 0){
            return 0;
        }else{
            //加载transaction列表的个数;
            return [dataArray count];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return [NSString stringWithFormat:@"Daily report for %@ for %@ chain:",dateString,[[NSUserDefaults standardUserDefaults]objectForKey:@"chainname"]];
    }
    if(section == 1){
        return @"    Cus.Name          Phone.Num        Gross.A      Nett.A";
    }
    return @"Settings";
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == leftTableView){
        UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(oneCell == nil)
        {
            oneCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
        }
        oneCell.selectionStyle = UITableViewCellSelectionStyleGray;
        oneCell.textLabel.text = @"";
        return oneCell;
    }else{
        UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(oneCell == nil)
        {
            oneCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
        }
        UITextField *idTField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 30, 44)];
        idTField.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
        idTField.borderStyle = UITextBorderStyleBezel;
        idTField.enabled = NO;
        [oneCell addSubview:idTField];
        [idTField release];
        
        TransactionCellView *cellView = [[TransactionCellView alloc]initWithFrame:CGRectMake(31, 0, 450, 44)];
        [oneCell addSubview:cellView];
        [cellView release];
        if([dataArray count]!= 0){
            TransactionItem *item = (TransactionItem *)[dataArray objectAtIndex:indexPath.row];
            cellView.nameTField.text = [NSString stringWithFormat:@"%@ %@",item.firstName,item.lastName];
            cellView.phoneTField.text = [NSString stringWithFormat:@"%@%@",item.countryCode,item.phoneNumber];
            cellView.grossAmountTField.text = item.grossAmount;
            cellView.nettAmountTField.text = item.nettAmount;
        }
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        oneCell.textLabel.text = @"";
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
