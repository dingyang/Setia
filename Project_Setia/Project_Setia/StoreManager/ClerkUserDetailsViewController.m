//
//  ClerkUserDetailsViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 8/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "ClerkUserDetailsViewController.h"
#import "PostReturnValue.h"
#import "GetServerData.h"
#import "ClerkUserItem.h"
#import "MBHUDUtil.h"
@interface ClerkUserDetailsViewController ()
@end
@implementation ClerkUserDetailsViewController
@synthesize leftTableView;
@synthesize rightTableView;
@synthesize roleValue;
@synthesize isUpdateClerkUser;
@synthesize clerkUserItem;
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
    self.title = @"Store User Details";
    //初始化post到server端的数组 和 server端的字段数组
    postToServerDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    serverKeysArray = [[NSArray alloc]initWithObjects:@"type",@"firstname",@"lastname",@"country_code",@"user_name",@"email",@"password",@"phone_number1",@"phone_number2",@"merchant_id",@"merchant_name",@"store_id",@"store_name",nil];
    
    //初始化chainNamesPickerViewArray
    //chainNamesPickerViewArray = [[NSArray alloc]init];
    if(self.isUpdateClerkUser == YES){
        UIBarButtonItem *userButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Update" style:UIBarButtonItemStylePlain target:self action:@selector(updateUser)];
        self.navigationItem.rightBarButtonItem = userButtonItem;
        [userButtonItem release];
    }else{
        UIBarButtonItem *userButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveUser)];
        self.navigationItem.rightBarButtonItem = userButtonItem;
        [userButtonItem release];
    }
    leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 512, 768-44-35) style:UITableViewStyleGrouped];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.scrollEnabled = NO;
    leftTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:leftTableView];
    [leftTableView release];
    
    rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(512, 0, 512, 768-44-35) style:UITableViewStyleGrouped];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    rightTableView.scrollEnabled = NO;
    [self.view addSubview:rightTableView];
    [rightTableView release];
    
    UIImageView *setiaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(35,768-44-35-189, 169, 169)];
    [setiaImageView setImage:[UIImage imageNamed:@"logo-setia.png"]];
    [self.view addSubview:setiaImageView];
    [setiaImageView release];
    
    NSArray *leftGeneralArray = [[NSArray alloc]initWithObjects:@"Type",@"Firstname",@"Lastname",@"Countrycode",@"Username",@"Email",@"Password",@"Phone #1",@"Phone #2",nil];
    leftCellArray = [[NSMutableArray alloc]initWithObjects:leftGeneralArray,nil];
    [leftGeneralArray release];
    NSArray *rightRetailChainsArray = [[NSArray alloc]initWithObjects:@"Chain name", nil];
    self.roleValue = [[NSUserDefaults standardUserDefaults] integerForKey:@"roleValue"];
    NSLog(@"%d",self.roleValue);
    if(self.roleValue !=3)
    {
        NSArray *rightStoreArray = [[NSArray alloc]initWithObjects:@"Store name", nil];
        rightCellArray = [[NSMutableArray alloc]initWithObjects:rightRetailChainsArray,rightStoreArray,nil];
        [rightStoreArray release];
    }else{
        rightCellArray = [[NSMutableArray alloc]initWithObjects:rightRetailChainsArray,nil];
    }
    [rightRetailChainsArray release];
    //注册键盘弹出和隐藏事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark ---UIKeyboardWillShow/HideNotification
-(void)keyboardWillShow:(NSNotification*)noti{
    NSDictionary *dic = noti.userInfo;
    CGSize size = [[dic objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    leftTableView.frame = CGRectMake(0, 0, 512, 768-44-35-size.width + 35);
    rightTableView.frame = CGRectMake(512, 0, 512, 768-44-35-size.width + 35);
    [leftTableView setContentOffset:CGPointMake(0, 80) animated:YES];
    [UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification*)noti{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01];
    leftTableView.frame = CGRectMake(0, 0, 512, 768-44-35);
    rightTableView.frame = CGRectMake(512, 0, 512, 768-44-35);
    leftTableView.scrollEnabled = NO;
    [UIView commitAnimations];
}
-(void)resignKeyBoard{
    [detailField resignFirstResponder];
}
#pragma mark ----updateUser
-(void)updateUser{
    
}
#pragma mark ----postToServer
-(void)saveUser
{
    clerkUserItem = [[ClerkUserItem alloc]init];
    [self.view endEditing:YES];
    [postToServerDataArray addObject:@"0"];
    for (int i=101; i<=108; i++) {
        UITextField *tf = (UITextField *)[self.view viewWithTag:i];
        [postToServerDataArray addObject:tf.text];
        switch (i) {
            case 101:
                clerkUserItem.firstname = tf.text;
                break;
            case 102:
                clerkUserItem.lastname = tf.text;
                break;
            case 103:
                clerkUserItem.code = tf.text;
                break;
            case 104:
                clerkUserItem.username = tf.text;
                break;
            case 105:
                clerkUserItem.email = tf.text;
                break;
            case 107:
                clerkUserItem.phone1 = tf.text;
                break;
            case 108:
                clerkUserItem.phone2 = tf.text;
                break;
            default:
                break;
        }
    }
    clerkUserItem.chainname = chainNameLabel.text;
    clerkUserItem.storename = storeNameLabel.text;
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"chainid"]!= nil){
        [postToServerDataArray addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"chainid"]];
    }else{
        [postToServerDataArray addObject:@""];
    }
    [postToServerDataArray addObject:chainNameLabel.text];
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"storeid"]!= nil){
        [postToServerDataArray addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"storeid"]];
    }else{
       [postToServerDataArray addObject:@""]; 
    }
    [postToServerDataArray addObject:storeNameLabel.text];
    
    NSDictionary *dict = [[NSDictionary alloc]initWithObjects:postToServerDataArray forKeys:serverKeysArray];
    PostDataToServer *postServer = [[PostDataToServer alloc]init];
    [postServer postServerDataMappingForClass:[PostReturnValue class] mappingsFromDictionary:@{@"status":@"returnValue"}
                           appendingUrlString:@"User" postParameters:dict pathPattern:nil keyPath:nil Delegate:self];
}
#pragma mark ----PostServerDataDelegate
-(void)postServerDataDidFinish:(NSArray *)serverData{
    PostReturnValue *value = (PostReturnValue *)[serverData objectAtIndex:0];
    NSLog(@"value.returnValue--->%@",value.returnValue);
    [MBHUDUtil HUDShowMsg:self.view msg:@"Add finished!" yOffset:100];
    saveCb(clerkUserItem);
    [self performSelector:@selector(backToParentViewController) withObject:nil afterDelay:2];
}
-(void)backToParentViewController{
    [self.navigationController popToViewController:[self.navigationController.childViewControllers objectAtIndex:0] animated:YES];
}

-(void)postServerDateFailed
{
    NSLog(@"<===============postServerDateFailed================>");
    [MBHUDUtil HUDShowMsg:self.view msg:@"Add failed !!! Check the network is available." yOffset:100];
}
#pragma mark ---addParentViewControllerUserListItem (Block)
-(void)addParentViewControllerUserListItem:(void(^)(ClerkUserItem *clerkUserItem))cb{
    [saveCb release];
    saveCb = [cb copy];
}
#pragma mark ----UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == leftTableView)
        return [leftCellArray count];
    else
        return [rightCellArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == leftTableView){
        return [[leftCellArray objectAtIndex:section] count];
    }else{
        return [[rightCellArray objectAtIndex:section ] count];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(tableView == leftTableView)
        return @"General";
    else{
        if(section == 0)
            return @"Chain";
        else
            return @"Store";
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == leftTableView){
        UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"leftcell"];
        if(oneCell == nil){
            oneCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftcell"] autorelease];
        }
        if(indexPath.row == 0){
            clerkLabel = [[UILabel alloc]initWithFrame:CGRectMake(201, 0, 280, 46)];
            clerkLabel.backgroundColor = [UIColor clearColor];
            clerkLabel.font = [UIFont boldSystemFontOfSize:18];
            clerkLabel.text = @"Clerk";
            clerkLabel.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
            [oneCell addSubview:clerkLabel];
            [clerkLabel release];
        }else{
            detailField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 300, 25)];
            detailField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
            detailField.tag = 100 + indexPath.row;
            if(self.clerkUserItem != nil){
                switch (indexPath.row) {
                    case 1:
                        detailField.text = clerkUserItem.firstname;
                        break;
                    case 2:
                        detailField.text = clerkUserItem.lastname;
                        break;
                    case 3:
                        detailField.text = clerkUserItem.code;
                        break;
                    case 4:
                        detailField.text = clerkUserItem.username;
                        break;
                    case 5:
                        detailField.text = clerkUserItem.email;
                        break;
                    case 6:
                        //detailField.text = clerkUserItem.password;
                        detailField.text = @"*** ***";
                        break;
                    case 7:
                        detailField.text = clerkUserItem.phone1;
                        break;
                    case 8:
                        detailField.text = clerkUserItem.phone2;
                        break;
                    default:
                        break;
                }
            }else{
                detailField.text = @"";
            }
            
            [oneCell addSubview:detailField];
            [detailField release];
        }
        oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        oneCell.textLabel.text = [[leftCellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return oneCell;
    }else{
        UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"rightcell"];
        if(oneCell == nil){
            oneCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rightcell"] autorelease];
        }
        if(indexPath.section == 0){
            chainNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(201, 0, 280, 46)];
            chainNameLabel.backgroundColor = [UIColor clearColor];
            chainNameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"chainname"];
            chainNameLabel.font = [UIFont boldSystemFontOfSize:18];
            chainNameLabel.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
            [oneCell addSubview:chainNameLabel];
            [chainNameLabel release];
        }else{
            storeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(201, 0, 280, 46)];
            storeNameLabel.backgroundColor = [UIColor clearColor];
            storeNameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"storename"];
            storeNameLabel.font = [UIFont boldSystemFontOfSize:18];
            storeNameLabel.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
            [oneCell addSubview:storeNameLabel];
            [storeNameLabel release];
        }
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
