//
//  ChangePasswordViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 24/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "PostReturnValue.h"
@interface ChangePasswordViewController ()

@end
@implementation ChangePasswordViewController
@synthesize _tableView,blankTableView;
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
    self.title = @"Reset Password Request";
    
    // init "POST" postToServerDataArray
    postToServerDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    serverKeysArray = [[NSArray alloc]initWithObjects:@"user_name",@"email",nil];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 512, 768-44) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    blankTableView = [[UITableView alloc]initWithFrame:CGRectMake(512, 0, 512, 768-44) style:UITableViewStyleGrouped];
    blankTableView.delegate = self;
    blankTableView.dataSource = self;
    blankTableView.scrollEnabled = NO;
    [self.view addSubview:blankTableView];
    [blankTableView release];
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //[submit setBackgroundImage:[UIImage imageNamed:@"btn_login.png"] forState:UIControlStateNormal];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor colorWithRed:0.1294f green:0.4353f blue:0.7608f alpha:1.0f] forState:UIControlStateNormal];
    submit.frame = CGRectMake(32, 150, 450, 40);
    [submit addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];

    UIImageView *setiaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(35,768-44-189, 169, 169)];
    [setiaImageView setImage:[UIImage imageNamed:@"logo-setia.png"]];
    [self.view addSubview:setiaImageView];
    [setiaImageView release];
    
    NSMutableArray *settingsCell = [[NSMutableArray alloc]initWithObjects:@"Registered ID",@"Registered Email",nil];
    textLableNames = [[NSMutableArray alloc]initWithObjects:settingsCell,nil];
}
-(void)submitAction{
    [self.view endEditing:YES];
    if([accountField.text isEqualToString:@""] ||[emailField.text isEqualToString:@""]){
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:nil message:@"The two items cann't be empty!" delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:nil];
        [alertview show];
        [alertview release];
        return;
    }
    [postToServerDataArray addObject:accountField.text];
    [postToServerDataArray addObject:emailField.text];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjects:postToServerDataArray forKeys:serverKeysArray];
    PostDataToServer *postServer = [[PostDataToServer alloc]init];
    [postServer postServerDataMappingForClass:[PostReturnValue class] mappingsFromDictionary:@{@"status":@"returnValue"}
                           appendingUrlString:@"Resetpass" postParameters:dict pathPattern:nil keyPath:nil Delegate:self];
}
#pragma mark ----PostServerDataDelegate
-(void)postServerDataDidFinish:(NSArray *)serverData{
    PostReturnValue *value = (PostReturnValue *)[serverData objectAtIndex:0];
    NSLog(@"value.returnValue--->%@",value.returnValue);
    if([value.returnValue isEqualToString:@"1"]){
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Password reset application has been sent successfully, the administrator will contact you." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        accountField.text = @"";
        emailField.text = @"";
    }
}
-(void)postServerDateFailed{
    
}
#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == _tableView)
        return [textLableNames count];
    else
        return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _tableView)
        return [[textLableNames objectAtIndex:section] count];
    else
        return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Reset Password Request";
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
        accountField = [[UITextField alloc]initWithFrame:CGRectMake(180, 2, 301, 40)];
        accountField.text = @"";
        accountField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
        accountField.borderStyle = UITextBorderStyleBezel;
        accountField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [oneCell addSubview:accountField];
        [accountField release];
    }
    if(indexPath.row == 1)
    {
        emailField = [[UITextField alloc]initWithFrame:CGRectMake(180, 2, 301, 40)];
        emailField.text = @"";
        emailField.textColor = [UIColor colorWithRed:0.1176f green:0.5569f blue:0.8745f alpha:1.0f];
        emailField.borderStyle = UITextBorderStyleBezel;
        emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [oneCell addSubview:emailField];
        [emailField release];
    }

    oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
    oneCell.textLabel.text = [[textLableNames objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return oneCell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
