//
//  InfoVC.h
//  TimerTestTask
//
//  Created by Sasha Myshkina on 09.02.2020.
//  Copyright © 2020 Sasha Myshkina. All rights reserved.
//
#import <UIKit/UIKit.h>
#ifndef InfoVC_h
#define InfoVC_h

@interface InfoVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *tapLabel;

@property (weak, nonatomic) IBOutlet UILabel *doubleTapLabel;

@property (weak, nonatomic) IBOutlet UIButton *okButton;

@end

#endif /* InfoVC_h */
