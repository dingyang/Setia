//
//  PickerView.h
//  Project_Setia
//
//  Created by Ding Yang on 5/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerView : UIPickerView{
    UIPickerView *pickerView;
}
@property (nonatomic,retain)NSArray *pickerViewItemsArray;
@end
