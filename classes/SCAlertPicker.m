//
//  SCAlertPicker.m
//  demo
//
//  Created by 罗思成 on 16/2/29.
//  Copyright © 2016年 罗思成. All rights reserved.
//

#import "SCAlertPicker.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation SCAlertPicker

/**
 *  init with normal picker
 *
 *  @param buttonTitle button text
 *  @param pickerData  2d-array stores picker data
 *  @param pickerIndex picker's first position
 *  @param delegate    action when button was clicked
 *
 *  @return SCAlertPicker with normal picker
 */
- (instancetype)initWithButtonTitle:(NSString *)buttonTitle
                         pickerData:(NSArray *)pickerData
                        pickerIndex:(NSArray *)pickerIndex
                           delegate:(id<SCAlertPickerDelegte>)delegate {
    self = [super init];
    
    if (self) {
        // setup size and position
        CGFloat viewWidth = CGRectGetWidth([UIScreen mainScreen].bounds) * 2 / 3;
        CGFloat viewHeight = 300;
        CGFloat viewLeft = viewWidth / 2 / 2;
        CGFloat viewTop = (CGRectGetHeight([UIScreen mainScreen].bounds) - viewHeight) / 2 - 30;
        
        CGFloat buttonHeight = 50;
        
        self.frame = CGRectMake(viewLeft, viewTop, viewWidth, viewHeight);
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.5;
        self.clipsToBounds = YES;
        
        self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight - buttonHeight)];
        self.picker.dataSource = self;
        self.picker.delegate = self;
        [self addSubview:self.picker];
        
        self.submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight - buttonHeight, viewWidth, buttonHeight)];
        [self.submitButton setTitle:buttonTitle forState:UIControlStateNormal];
        
        UIImage *submitButtonBackGround = [self imageFromColor:UIColorFromRGB(0x7cbf6f)];
        UIImage *submitButtonBackgroundHighlighted = [self imageFromColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        [self.submitButton setBackgroundImage:submitButtonBackGround forState:UIControlStateNormal];
        [self.submitButton setBackgroundImage:submitButtonBackgroundHighlighted forState:UIControlStateHighlighted];
        
        [self.submitButton addTarget:self action:@selector(actionSubmit) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.submitButton];
        
        self.pickerData = pickerData;
        self.picker.backgroundColor = [UIColor clearColor];
        self.valueIndex = [[NSMutableArray alloc] initWithArray:pickerIndex];
        
        for (int i = 0; i < [self.valueIndex count]; i++) {
            NSInteger index = [self.valueIndex[i] integerValue];
            [self.picker selectRow:index inComponent:i animated:NO];
        }
        
        self.delegate = delegate;
    }
    
    return self;
}

- (instancetype)initWithButtonTitle:(NSString *)buttonTitle
                     datePickerMode:(UIDatePickerMode)datePickerMode
                           delegate:(id<SCAlertPickerDelegte>)delegate {
    self = [super init];
    
    if (self) {
        NSLog(@"%.lf", CGRectGetWidth([UIScreen mainScreen].bounds));
        // setup size and position
        CGFloat viewWidth = MAX(CGRectGetWidth([UIScreen mainScreen].bounds) * 4 / 5, 300);
        CGFloat viewHeight = 300;
        CGFloat viewLeft = (CGRectGetWidth([UIScreen mainScreen].bounds) - viewWidth) / 2;
        CGFloat viewTop = (CGRectGetHeight([UIScreen mainScreen].bounds) - viewHeight) / 2 - 30;
        
        CGFloat buttonHeight = 50;
        
        self.frame = CGRectMake(viewLeft, viewTop, viewWidth, viewHeight);
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.5;
        self.clipsToBounds = YES;
        
        self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight - buttonHeight)];
        self.datePicker.datePickerMode = datePickerMode;
        [self addSubview:self.datePicker];
        
        self.submitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight - buttonHeight, viewWidth, buttonHeight)];
        [self.submitButton setTitle:buttonTitle forState:UIControlStateNormal];
        
        UIImage *submitButtonBackGround = [self imageFromColor:UIColorFromRGB(0x7cbf6f)];
        UIImage *submitButtonBackgroundHighlighted = [self imageFromColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        [self.submitButton setBackgroundImage:submitButtonBackGround forState:UIControlStateNormal];
        [self.submitButton setBackgroundImage:submitButtonBackgroundHighlighted forState:UIControlStateHighlighted];
        
        [self.submitButton addTarget:self action:@selector(actionSubmit) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.submitButton];
        
        self.datePicker.backgroundColor = [UIColor clearColor];
        self.delegate = delegate;
    }
    
    return self;
}

#pragma - Picker Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [self.pickerData count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerData[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([self.pickerData[component][row] isKindOfClass:[NSString class]]) {
        return self.pickerData[component][row];
    } else {
        return @"";
    }
}

#pragma - Picker Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.valueIndex[component] = [NSNumber numberWithInteger:row];
}

#pragma - Show View

- (void)show {
    self.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.alertWindow.backgroundColor = [UIColor clearColor];
    self.alertWindow.windowLevel = UIWindowLevelAlert;
    [self.alertWindow addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap;
    })];
    
    // create effect
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    // add effect to an effect view
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.alertWindow.frame;
    
    [self.alertWindow addSubview:effectView];
    [self.alertWindow addSubview:self];
    [self.alertWindow makeKeyAndVisible];
    self.alertWindow.alpha = 0;
    self.alpha = 0;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alertWindow.alpha = 1;
        self.alpha = 1;
    } completion:nil];
}

#pragma - Click Submit Button

- (void)actionSubmit {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0;
        self.alertWindow.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alertWindow.hidden = YES;
        self.alertWindow = nil;
    }];
    
    NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:[self.valueIndex count]];
    
    for (int i = 0; i < [self.valueIndex count]; i++) {
        NSInteger index = [self.valueIndex[i] integerValue];
        [values addObject:self.pickerData[i][index]];
    }
    
    if (self.picker && [self.delegate respondsToSelector:@selector(SCAlertPicker:ClickWithValues:)]) {
        [self.delegate SCAlertPicker:self ClickWithValues:[values copy]];
    }
    
    if (self.datePicker && [self.delegate respondsToSelector:@selector(SCAlertPicker:ClickWithDate:)]) {
        [self.delegate SCAlertPicker:self ClickWithDate:[self.datePicker date]];
    }
}

#pragma - View Dismiss

- (void)dismiss {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0;
        self.alertWindow.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alertWindow.hidden = YES;
        self.alertWindow = nil;
    }];
}

#pragma - Image Work

- (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

