//
//  InfoVC.m
//  TimerTestTask
//
//  Created by Sasha Myshkina on 09.02.2020.
//  Copyright © 2020 Sasha Myshkina. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "InfoVC.h"

@implementation InfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tapLabel.text = @"Tap to start, pause or resume the stopwatch";
    self.doubleTapLabel.text = @"Double tap to stop the stopwatch";
    [self.okButton setTitle: @"OK" forState:UIControlStateNormal];
}

- (IBAction)handleOkButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
