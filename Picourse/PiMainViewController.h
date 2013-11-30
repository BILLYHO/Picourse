//
//  PiMainViewController.h
//  Picourse
//
//  Created by BILLY HO on 10/8/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PiMainViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *selectedCourseButton;
@property (strong, nonatomic) IBOutlet UIButton *solutionButton;
@property (strong, nonatomic) IBOutlet UIButton *perspectiveButton;
@property (strong, nonatomic) IBOutlet UIButton *infomationButton;
@property (strong, nonatomic) IBOutlet UIButton *seniorCourseButton;
@property (strong, nonatomic) IBOutlet UIButton *generalCourseButton;
@property (strong, nonatomic) IBOutlet UIButton *activityButton;
@property (strong, nonatomic) IBOutlet UIButton *openCourseButton;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;


- (IBAction)selectedCourseClicked:(id)sender;
- (IBAction)solutionClicked:(id)sender;
- (IBAction)perspectiveClicked:(id)sender;
- (IBAction)infoClicked:(id)sender;
- (IBAction)seniorCourseClicked:(id)sender;
- (IBAction)generalCourseClicked:(id)sender;
- (IBAction)activityClicked:(id)sender;
- (IBAction)openCourseClicked:(id)sender;

@end
