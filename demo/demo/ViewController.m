//
//  ViewController.m
//  demo
//
//  Created by 罗思成 on 16/2/29.
//  Copyright © 2016年 罗思成. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma - View Lify Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showNormalPicker = [[UIButton alloc] init];
    [self.showNormalPicker setTitle:@"Normal SCAlertPicker" forState:UIControlStateNormal];
    self.showNormalPicker.backgroundColor = [UIColor purpleColor];
    [self.showNormalPicker addTarget:self action:@selector(actionShowNormalPicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showNormalPicker];
    
    self.showDatePicker = [[UIButton alloc] init];
    [self.showDatePicker setTitle:@"Date SCAlertPicker" forState:UIControlStateNormal];
    self.showDatePicker.backgroundColor = [UIColor purpleColor];
    [self.showDatePicker addTarget:self action:@selector(actionShowDatePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showDatePicker];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.showNormalPicker.frame = CGRectMake(20, 30, CGRectGetWidth(self.view.frame) - 20*2, 40);
    self.showDatePicker.frame = CGRectMake(20, 30 + 40 + 10, CGRectGetWidth(self.view.frame) - 20*2, 40);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - Show SCAlertPicker

- (void)actionShowNormalPicker {
    self.normalAlertPicker = [[SCAlertPicker alloc] initWithButtonTitle:@"OK" pickerData:[self getTestData] pickerIndex:@[@0, @0] delegate:self];
    [self.normalAlertPicker show];
}

- (void)actionShowDatePicker {
    self.dateAlertPicker = [[SCAlertPicker alloc] initWithButtonTitle:@"OK" datePickerMode:UIDatePickerModeDate delegate:self];
    [self.dateAlertPicker show];
}

#pragma - Generate Test Data

- (NSArray *)getTestData {
    NSMutableArray *testData = [[NSMutableArray alloc] init];
    [testData addObject:@[@"Guangzhou", @"Beijing", @"Shanghai"]];
    [testData addObject:@[@"front-end", @"back-end", @"iOS", @"Android"]];
    return [testData copy];
}

#pragma - SCAlertPicker Delegate

- (void)SCAlertPicker:(SCAlertPicker *)SCAlertPicker ClickWithValues:(NSArray *)values {
    if (SCAlertPicker == self.normalAlertPicker) {
        NSLog(@"SCAlertPicker::%@:%@", values[0], values[1]);
    }
}

- (void)SCAlertPicker:(SCAlertPicker *)SCAlertPicker ClickWithDate:(NSDate *)date {
    if (SCAlertPicker == self.dateAlertPicker) {
        NSLog(@"SCAlertPicker::%@", date);
    }
}

@end
