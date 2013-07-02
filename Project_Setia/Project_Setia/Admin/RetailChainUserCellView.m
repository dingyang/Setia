//
//  RetailChainUserCellView.m
//  Project_Setia
//
//  Created by Ding Yang on 8/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "RetailChainUserCellView.h"

@implementation RetailChainUserCellView

@synthesize idTField;
@synthesize codeTField;
@synthesize firstnameTField;
@synthesize lastnameTField;
@synthesize usernameTField;

#define retailChainCellItemWidth 225.0f
#define retailChainCellItemHeigth 44.0f
#define retailChainTitle_idWidth 33.0f
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        idTField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, retailChainTitle_idWidth, retailChainCellItemHeigth)];
        idTField.borderStyle = UITextBorderStyleBezel;
        idTField.enabled = NO;
        [self addSubview:idTField];
        [idTField release];
        
        codeTField = [[UITextField alloc]initWithFrame:CGRectMake(retailChainTitle_idWidth, 0, retailChainCellItemWidth, retailChainCellItemHeigth)];
        codeTField.borderStyle = UITextBorderStyleBezel;
        codeTField.enabled = NO;
        [self addSubview:codeTField];
        [codeTField release];
        
        firstnameTField = [[UITextField alloc]initWithFrame:CGRectMake(retailChainTitle_idWidth+1*retailChainCellItemWidth, 0, retailChainCellItemWidth, retailChainCellItemHeigth)];
        firstnameTField.borderStyle = UITextBorderStyleBezel;
        firstnameTField.enabled = NO;
        [self addSubview:firstnameTField];
        [firstnameTField release];
        
        lastnameTField = [[UITextField alloc]initWithFrame:CGRectMake(retailChainTitle_idWidth+2*retailChainCellItemWidth, 0, retailChainCellItemWidth, retailChainCellItemHeigth)];
        lastnameTField.borderStyle = UITextBorderStyleBezel;
        lastnameTField.enabled = NO;
        [self addSubview:lastnameTField];
        [lastnameTField release];
        
        usernameTField = [[UITextField alloc]initWithFrame:CGRectMake(retailChainTitle_idWidth+3*retailChainCellItemWidth, 0, retailChainCellItemWidth, retailChainCellItemHeigth)];
        usernameTField.borderStyle = UITextBorderStyleBezel;
        usernameTField.enabled = NO;
        [self addSubview:usernameTField];
        [usernameTField release];
                
    }
    return self;
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
