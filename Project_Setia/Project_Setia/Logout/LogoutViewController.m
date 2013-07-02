//
//  LogoutViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 24/4/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "LogoutViewController.h"
#import "PostDataToServer.h"
#import "StoreItem.h"
#import "PostReturnValue.h"
#import "TableViewCell.h"
@interface LogoutViewController ()

@end

@implementation LogoutViewController
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
        self.title = @"Settings";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    settingsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 512, 768-44-35) style:UITableViewStyleGrouped];
    settingsTableView.delegate = self;
    settingsTableView.dataSource = self;
    settingsTableView.scrollEnabled = NO;
    [self.view addSubview:settingsTableView];
    [settingsTableView release];
    
    blankTableView = [[UITableView alloc]initWithFrame:CGRectMake(512, 0, 512, 768-44-35) style:UITableViewStyleGrouped];
    blankTableView.delegate = self;
    blankTableView.dataSource = self;
    blankTableView.scrollEnabled = NO;
    [self.view addSubview:blankTableView];
    [blankTableView release];
    
    UIImageView *setiaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(35,768-44-35-189, 169, 169)];
    [setiaImageView setImage:[UIImage imageNamed:@"logo-setia.png"]];
    [self.view addSubview:setiaImageView];
    [setiaImageView release];
    
    NSMutableArray *settingsCell = [[NSMutableArray alloc]initWithObjects:@"Logout The Current Account",@"Change The Current Password",@"Modify The User Information",nil];
    settingsCellArray = [[NSMutableArray alloc]initWithObjects:settingsCell,nil];
    
    blankCell = [[NSMutableArray alloc]initWithObjects:@"Original password",@"New password",@"New password again",nil];
    blankCellInfor = [[NSMutableArray alloc]initWithObjects:@"Firstname",@"Lastname",@"Countrycode",@"Email",@"Phone #1",@"Phone #2", nil];
    blankCellArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //[submit setBackgroundImage:[UIImage imageNamed:@"btn_login.png"] forState:UIControlStateNormal];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor colorWithRed:0.1294f green:0.4353f blue:0.7608f alpha:1.0f] forState:UIControlStateNormal];
   // [submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == settingsTableView)
        return [settingsCellArray count];
    else
        return [blankCellArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == settingsTableView)
        return [[settingsCellArray objectAtIndex:section] count];
    else
        return [[blankCellArray objectAtIndex:section]count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(tableView == settingsTableView)
        return @"Settings";
    else
        return @"Information List";
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == settingsTableView){
        UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(oneCell == nil)
        {
            oneCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
        }
        oneCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        oneCell.selectionStyle = UITableViewCellSelectionStyleGray;
        oneCell.textLabel.text = [[settingsCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];       
        return oneCell;
    }else{
        TableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(oneCell == nil)
        {
            oneCell = [[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
        }
        oneCell.textField.text = @"";
        if(selectedCellIndex == 2){
            switch (indexPath.row) {
                case 0:
                    oneCell.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"firstname"];
                    break;
                case 1:
                    oneCell.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastname"];
                    break;
                case 2:
                    oneCell.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"];;
                    break;
                case 3:
                    oneCell.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
                    break;
                case 4:
                    oneCell.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone1"];
                    break;
                case 5:
                    //detailField.text = retailChainUserItem.password;
                    oneCell.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone2"];
                    break;
                default:
                    break;
            }
        }
        oneCell.tag = indexPath.row;
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        oneCell.textLabel.text = [[blankCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return oneCell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(tableView == settingsTableView){
        if(indexPath.row == 0)
            [[NSNotificationCenter defaultCenter]postNotificationName:@"logout" object:nil];
        else if(indexPath.row == 1){
            selectedCellIndex = indexPath.row;
            [blankCellArray removeAllObjects];
            [blankCellArray addObject:blankCell];
            [blankTableView reloadData];
            //调整按钮位置，并且设置事件的方法；
            submitButton.frame = CGRectMake(32+512+300, 180, 150, 40);
            [submitButton removeTarget:self action:@selector(submitInformationAction)  forControlEvents:UIControlEventTouchUpInside];
            [submitButton addTarget:self action:@selector(submitPasswordAction) forControlEvents:UIControlEventTouchUpInside];
        }
        else if(indexPath.row == 2){
            selectedCellIndex = indexPath.row;
            [blankCellArray removeAllObjects];
            [blankCellArray addObject:blankCellInfor];
            [blankTableView reloadData];
            //调整按钮位置，并且设置事件的方法；
            submitButton.frame = CGRectMake(32+512+300, 320, 150, 40);
            [submitButton removeTarget:self action:@selector(submitPasswordAction)  forControlEvents:UIControlEventTouchUpInside];
            [submitButton addTarget:self action:@selector(submitInformationAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
-(void)submitPasswordAction{
    NSLog(@"submitPasswordAction");
}
-(void)submitInformationAction{
    NSLog(@"submitInformationAction");
}
#pragma mark - upload
-(void)uploadPictureWithPath:(NSString *)path
{
    NSLog(@"uploadPictureWithPath:%@",path);
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //根据url初始化request
    NSString *urlString = [NSString stringWithFormat:@"http://www.guangqinggong.com/Setia/API/Merchant/add.json"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSDictionary *params = [[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"ggyy",@"ggyy",@"ggyy",@"ggyy",@"ggyy",@"ggyy",@"ggyy",@"ggyy",@"ggyy",@"ggyy",@"ggyy",@"ggyy",@"ggyy",@"ggyy",@"ggyy", nil] forKeys:@[@"id",@"name",@"description",@"email",@"url",@"discount",@"building_name",@"unit_number",@"street_name",@"landmark",@"postal_code",@"country",@"city",@"phone_1",@"phone_2"]];
    NSArray *keys= [params allKeys];
    //遍历keys
    for(int i=0;i<[keys count];i++)
    {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //如果key不是pic，说明value是字符类型，比如name：Boris
        if(![key isEqualToString:@"pic"])
        {
            //添加分界线，换行
            [body appendFormat:@"%@\r\n",MPboundary];
            //添加字段名称，换2行
            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
            //添加字段的值
            [body appendFormat:@"%@\r\n",[params objectForKey:key]];
        }
    }
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%d", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    //建立连接，设置代理
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
}
#pragma mark - connection
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error");
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"<==========%@===========>",str);
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"finish");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
