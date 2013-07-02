//
//  ClerkViewController.m
//  Project_Setia
//
//  Created by Ding Yang on 9/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "ClerkViewController.h"

@interface ClerkViewController ()

@end

@implementation ClerkViewController
@synthesize settingsTableView;
@synthesize blankTableView;
-(void)dealloc
{
    [settingsTableView release];
    [blankTableView release];
    [dataArray release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Clerk Main View";
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
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Settings";
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(oneCell == nil)
    {
        oneCell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
    }
    return oneCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"logout" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
