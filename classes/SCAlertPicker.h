//
//  SCAlertPicker.h
//  demo
//
//  Created by 罗思成 on 16/2/29.
//  Copyright © 2016年 罗思成. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCAlertPickerDelegte;

@interface SCAlertPicker : UIView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) id<SCAlertPickerDelegte> delegate;
@property (strong, nonatomic) UIPickerView *picker;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) NSMutableArray *valueIndex;
@property (copy, nonatomic) NSArray *pickerData;
@property (strong, nonatomic) UIButton *submitButton;
@property (strong, nonatomic) UIWindow *alertWindow;

- (instancetype)initWithButtonTitle:(NSString *)buttonTitle
                         pickerData:(NSArray *)pickerData
                        pickerIndex:(NSArray *)pickerIndex
                           delegate:(id<SCAlertPickerDelegte>)delegate;

- (instancetype)initWithButtonTitle:(NSString *)buttonTile
                     datePickerMode:(UIDatePickerMode)datePickerMode
                           delegate:(id<SCAlertPickerDelegte>)delegate;

- (void)show;

@end

@protocol SCAlertPickerDelegte <NSObject>

@optional

-(void)SCAlertPicker:(SCAlertPicker *)SCAlertPicker ClickWithValues:(NSArray *)values;
-(void)SCAlertPicker:(SCAlertPicker *)SCAlertPicker ClickWithDate:(NSDate *)date;

@end