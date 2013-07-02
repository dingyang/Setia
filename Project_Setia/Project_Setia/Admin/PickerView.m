//
//  PickerView.m
//  Project_Setia
//
//  Created by Ding Yang on 5/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "PickerView.h"

@implementation PickerView
@synthesize pickerViewItemsArray;
-(void)dealloc
{
    [pickerViewItemsArray release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pickerViewItemsArray = [[NSArray alloc]init];
    }
    return self;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerViewItemsArray count];
    NSLog(@"[pickerView.pickerViewItemsArray count]--->%d",[pickerViewItemsArray count]);
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerViewItemsArray objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"%@",[pickerViewItemsArray objectAtIndex:row]);
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
