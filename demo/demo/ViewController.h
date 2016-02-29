//
//  ViewController.h
//  demo
//
//  Created by 罗思成 on 16/2/29.
//  Copyright © 2016年 罗思成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCAlertPicker.h"

@interface ViewController : UIViewController <SCAlertPickerDelegte>

@property (nonatomic, strong) UIButton *showNormalPicker;
@property (nonatomic, strong) UIButton *showDatePicker;

@property (nonatomic, strong) SCAlertPicker *normalAlertPicker;
@property (nonatomic, strong) SCAlertPicker *dateAlertPicker;

@end

