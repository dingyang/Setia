//
//  StoreManagerViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 9/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "StoreManagerViewController.h"
#import "ClerkUserCellView.h"
#import "ClerkUserItem.h"
#import "StoreUserDetailsViewController.h"
#import "ClerkUserDetailsViewController.h"
#import "MBHUDUtil.h"
@interface StoreManagerViewController ()

@end

@implementation StoreManagerViewController

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
    [self.view setBackgroundColor:[UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.0f]];
    //    [self.view setBackgroundColor:[UIColor colorWithRed:0.43f green:0.447f blue:0.494f alpha:1.0f]];
    self.title = @"User List";
    
    dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768-44-35)style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    UIBarButtonItem *addUserItem = [[UIBarButtonItem alloc]initWithTitle:@"Add user" style:UIBarButtonItemStylePlain target:self action:@selector(addUser)];
    self.navigationItem.rightBarButtonItem = addUserItem;
    [addUserItem release];
    
    serverDataGetter = [[GetServerData alloc]init];
    [serverDataGetter getServerDataMappingForClass:[ClerkUserItem class]mappingsFromDictionary:@{@"type":@"type",@"firstname":@"firstname",@"lastname":@"lastname",@"country_code":@"code",@"user_name":@"username",@"email":@"email",@"password":@"password",@"phone_number1":@"phone1",@"phone_number2":@"phone2",@"merchant_name":@"chainname"} pathPattern:nil keyPath:@"user" appendingUrlString:[NSString stringWithFormat:@"User/store_id:%@,type:0.json",[[NSUserDefaults standardUserDefaults] objectForKey:@"storeid"]] Delegate:self];
}
#pragma mark ----ServerDataDelegate
-(void)getServerDataDidFinish:(NSArray *)serverData{
    for(int i=0;i<serverData.count;i++){
        [dataArray addObject:[serverData objectAtIndex:i]];
    }
    //dataArray = [serverData copy];
    [_tableView reloadData];
    [MBHUDUtil HUDShowMsg:self.view msg:@"Refresh finished" yOffset:100];
}
-(void)getServerDateFailed{
    NSLog(@"getServerDateFailed");
    [MBHUDUtil HUDShowMsg:self.view msg:@"Refresh failed !!! Check the network is available." yOffset:100];
}

-(void)addUser{
    ClerkUserDetailsViewController *userDetailsVcl = [[ClerkUserDetailsViewController alloc]init];
    [userDetailsVcl addParentViewControllerUserListItem:^(ClerkUserItem *clerkUserItem) {
        [dataArray insertObject:clerkUserItem atIndex:0];
        [_tableView reloadData];
    }];
    [self.navigationController pushViewController:userDetailsVcl animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @" Id                  Code                                    Firstname                               Lastname                               Username";
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
    ClerkUserCellView *cellView = [[ClerkUserCellView alloc]initWithFrame:CGRectMake(45, 0, 933, 42)];
    [cell addSubview:cellView];
    [cellView release];
    if([dataArray count]!= 0){
        ClerkUserItem *item = (ClerkUserItem *)[dataArray objectAtIndex:indexPath.row];
        cellView.idTField.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
        cellView.codeTField.text = item.code;
        cellView.firstnameTField.text = item.firstname;
        cellView.lastnameTField.text = item.lastname;
        cellView.usernameTField.text = item.username;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ClerkUserDetailsViewController *userDetailsVcl = [[ClerkUserDetailsViewController alloc]init];
    userDetailsVcl.clerkUserItem = [dataArray objectAtIndex:indexPath.row];
    userDetailsVcl.isUpdateClerkUser = YES;
    [self.navigationController pushViewController:userDetailsVcl animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
