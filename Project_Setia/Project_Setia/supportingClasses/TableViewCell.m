//
//  TableViewCell.m
//  Project_Setia
//
//  Created by Ding Yang on 21/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell
@synthesize textField;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self performSelector:@selector(makeView)];
    }
    return self;
}
-(void)makeView{
    textField = [[UITextField alloc]initWithFrame:CGRectMake(250, 12, 250, 25)];
    //textField = [[UITextField alloc]initWithFrame:CGRectMake(250, 0, 230, 45)];
    textField.textColor = [UIColor colorWithRed:0.25f green:0.376f blue:0.67f alpha:1.0f];
    textField.text = @"";
    //textField.borderStyle = UITextBorderStyleBezel;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self addSubview:textField];
    [textField release];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
