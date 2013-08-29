//
//  TopUpView.m
//  Project_Setia
//
//  Created by Ding Yang on 25/7/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "TopUpView.h"

@implementation TopUpView
@synthesize prepaidTF;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(336, 200, 352, 150) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [self addSubview:_tableView];
        [_tableView release];
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        closeButton.frame = CGRectMake(668, 200, 20, 20);
        [closeButton setBackgroundImage:[UIImage imageNamed:@"button_close.png"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeTopUpAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        
        prepaidTF = [[UITextField alloc]initWithFrame:CGRectMake(35, 45, 280, 40)];
        prepaidTF.keyboardType = UIKeyboardTypeNumberPad;
        prepaidTF.delegate = self;
        prepaidTF.backgroundColor = [UIColor whiteColor];
        prepaidTF.borderStyle = UITextBorderStyleRoundedRect;
        prepaidTF.placeholder = @"Please enter prepaid amount";
        [_tableView addSubview:prepaidTF];
        [prepaidTF release];
        
        UIButton *saleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        saleButton.frame = CGRectMake(35, 100, 280, 40);
        [saleButton setBackgroundImage:[UIImage imageNamed:@"btn_sale.png"] forState:UIControlStateNormal];
        [saleButton addTarget:self action:@selector(topUpAction) forControlEvents:UIControlEventTouchUpInside];
        [_tableView addSubview:saleButton];
        
    }
    return self;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}
-(void)closeTopUpAction{
    NSLog(@"closeTopUpAction");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"closeTopUpView" object:nil];
}
-(void)topUpAction{
    NSLog(@"topUpAction");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"prepay" object:nil];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
 return @"Top Up System";
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *oneCell = [tableView dequeueReusableCellWithIdentifier:@"leftcell"];
    return oneCell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
