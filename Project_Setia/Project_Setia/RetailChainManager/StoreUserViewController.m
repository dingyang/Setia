//
//  StoreUserViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 8/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "StoreUserViewController.h"
#import "StoreUserCellView.h"
#import "StoreUserItem.h"
#import "StoreUserDetailsViewController.h"
#import "MBHUDUtil.h"
@interface StoreUserViewController ()

@end

@implementation StoreUserViewController

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
    [serverDataGetter getServerDataMappingForClass:[StoreUserItem class]mappingsFromDictionary:@{@"type":@"type",@"firstname":@"firstname",@"lastname":@"lastname",@"country_code":@"code",@"user_name":@"username",@"email":@"email",@"password":@"password",@"phone_number1":@"phone1",@"phone_number2":@"phone2",@"merchant_name":@"chainname"} pathPattern:nil keyPath:@"user" appendingUrlString:[NSString stringWithFormat:@"User/merchant_id:%@,type:1.json",[[NSUserDefaults standardUserDefaults] objectForKey:@"chainid"]] Delegate:self];
}
#pragma mark ----ServerDataDelegate
-(void)getServerDataDidFinish:(NSArray *)serverData{
    for(int i=0;i<serverData.count;i++){
        [dataArray addObject:[serverData objectAtIndex:i]];
    }
    // dataArray = [serverData copy];
    [_tableView reloadData];
    
    [MBHUDUtil HUDShowMsg:self.view msg:@"Download finished" yOffset:100];
}
-(void)getServerDateFailed{
    NSLog(@"getServerDateFailed");
    [MBHUDUtil HUDShowMsg:self.view msg:@"Refresh failed !!! Check the network is available." yOffset:100];
}
-(void)addUser{
    StoreUserDetailsViewController *userDetailsVcl = [[StoreUserDetailsViewController alloc]init];
    [userDetailsVcl addParentViewControllerUserListItem:^(StoreUserItem *stUserItem) {
        [dataArray insertObject:stUserItem atIndex:0];
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
    StoreUserCellView *cellView = [[StoreUserCellView alloc]initWithFrame:CGRectMake(45, 0, 933, 42)];
    [cell addSubview:cellView];
    [cellView release];
    if([dataArray count]!= 0){
        StoreUserItem *item = (StoreUserItem *)[dataArray objectAtIndex:indexPath.row];
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
    StoreUserDetailsViewController *userDetailsVcl = [[StoreUserDetailsViewController alloc]init];
    userDetailsVcl.storeUserItem = [dataArray objectAtIndex:indexPath.row];
    userDetailsVcl.isUpdateStoreUser = YES;
    [self.navigationController pushViewController:userDetailsVcl animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [super dealloc];
}

@end
