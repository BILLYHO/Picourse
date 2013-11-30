//
//  PiMainViewController.m
//  Picourse
//
//  Created by BILLY HO on 10/8/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import "PiMainViewController.h"
#import "PiInfomationViewController.h"
#import "PiCourseViewController.h"
#import "PiOpenCourseViewController.h"
#import "PiSettingViewController.h"
#import "PiFeedbackViewController.h"
#import "PiNavigationController.h"
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface PiMainViewController ()

@end

@implementation PiMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.navigationController.navigationBarHidden = YES;
	
	[self.selectedCourseButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 10, 10)];
	[self.selectedCourseButton setImage:[UIImage imageNamed:@"SelectedCourse"] forState:UIControlStateNormal];
	[self.selectedCourseButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -15, 5, 5)];
	[self.selectedCourseButton setTitle:@"精选课程" forState:UIControlStateNormal];
	self.selectedCourseButton.titleLabel.textAlignment = NSTextAlignmentCenter;
	
	[self.solutionButton setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 10, 10)];
	[self.solutionButton setImage:[UIImage imageNamed:@"Solution"] forState:UIControlStateNormal];
	[self.solutionButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -50, 5, 5)];
	[self.solutionButton setTitle:@"解决方案" forState:UIControlStateNormal];
	
	[self.perspectiveButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 10, 10)];
	[self.perspectiveButton setImage:[UIImage imageNamed:@"Perspective"] forState:UIControlStateNormal];
	[self.perspectiveButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -60, 5, 5)];
	[self.perspectiveButton setTitle:@"观察与观点" forState:UIControlStateNormal];

	
	[self.infomationButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 10, 10)];
	[self.infomationButton setImage:[UIImage imageNamed:@"Infomatiom"] forState:UIControlStateNormal];
	[self.infomationButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -15, 5, 5)];
	[self.infomationButton setTitle:@"行业新闻" forState:UIControlStateNormal];
	
	[self.seniorCourseButton setImageEdgeInsets:UIEdgeInsetsMake(-15, 30, 10, 10)];
	[self.seniorCourseButton setImage:[UIImage imageNamed:@"SeniorCourse"] forState:UIControlStateNormal];
	[self.seniorCourseButton setTitleEdgeInsets:UIEdgeInsetsMake(45, -15, 5, 15)];
	[self.seniorCourseButton setTitle:@"高层管理课程" forState:UIControlStateNormal];
	self.seniorCourseButton.titleLabel.numberOfLines = 2;
	self.seniorCourseButton.titleLabel.textAlignment = NSTextAlignmentCenter;

	[self.generalCourseButton setImageEdgeInsets:UIEdgeInsetsMake(-15, 30, 10, 10)];
	[self.generalCourseButton setImage:[UIImage imageNamed:@"GeneralCourse"] forState:UIControlStateNormal];
	[self.generalCourseButton setTitleEdgeInsets:UIEdgeInsetsMake(45, -40, 5, 5)];
	[self.generalCourseButton setTitle:@"中基层人员\n管理课程" forState:UIControlStateNormal];
	self.generalCourseButton.titleLabel.numberOfLines = 3;
	self.generalCourseButton.titleLabel.textAlignment = NSTextAlignmentCenter;
	
	[self.activityButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 10, 10)];
	[self.activityButton setImage:[UIImage imageNamed:@"Activity"] forState:UIControlStateNormal];
	[self.activityButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -15, 5, 5)];
	[self.activityButton setTitle:@"行业活动" forState:UIControlStateNormal];
	
	[self.openCourseButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 10, 10)];
	[self.openCourseButton setImage:[UIImage imageNamed:@"OpenCourse"] forState:UIControlStateNormal];
	[self.openCourseButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -15, 5, 5)];
	[self.openCourseButton setTitle:@"公开课程" forState:UIControlStateNormal];

	
	[_menuButton addTarget:(PiNavigationController *)self.navigationController action:@selector(leftSwipe) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)selectedCourseClicked:(id)sender
{
	PiCourseViewController *courseView = [[PiCourseViewController alloc] initWithNibName:@"PiCourseViewController" bundle:nil];
    courseView.category = @"SelectedCourse";
	courseView.courseName = @"精选课程";
	courseView.itemPerPage = @"5";
	[self.navigationController pushViewController:courseView animated:YES];
}

- (IBAction)solutionClicked:(id)sender
{
	PiInfomationViewController *infoView = [[PiInfomationViewController alloc] initWithNibName:@"PiInfomationViewController" bundle:nil];
    infoView.category = @"SolutionInfo";
	infoView.infoName = @"解决方案";
	infoView.itemPerPage = @"3";
	[self.navigationController pushViewController:infoView animated:YES];
}

- (IBAction)perspectiveClicked:(id)sender
{
	PiInfomationViewController *infoView = [[PiInfomationViewController alloc] initWithNibName:@"PiInfomationViewController" bundle:nil];
	infoView.category = @"ViewInfo";
	infoView.infoName = @"视野观察";
	infoView.itemPerPage = @"4";
	[self.navigationController pushViewController:infoView animated:YES];
}

- (IBAction)infoClicked:(id)sender
{
	PiInfomationViewController *infoView = [[PiInfomationViewController alloc] initWithNibName:@"PiInfomationViewController" bundle:nil];
	infoView.category = @"NewsInfo";
	infoView.infoName = @"行业新闻";
	infoView.itemPerPage = @"4";
	[self.navigationController pushViewController:infoView animated:YES];
}

- (IBAction)seniorCourseClicked:(id)sender
{
	PiCourseViewController *highCourseView = [[PiCourseViewController alloc] initWithNibName:@"PiCourseViewController" bundle:nil];
    highCourseView.category = @"HighCourse";
	highCourseView.courseName = @"高层管理课程";
	highCourseView.itemPerPage = @"5";
	[self.navigationController pushViewController:highCourseView animated:YES];
}

- (IBAction)generalCourseClicked:(id)sender
{
	PiCourseViewController *courseView = [[PiCourseViewController alloc] initWithNibName:@"PiCourseViewController" bundle:nil];
    courseView.category = @"MidCourse";
	courseView.courseName = @"中基层人员管理课程";
	courseView.itemPerPage = @"5";
	[self.navigationController pushViewController:courseView animated:YES];
}

- (IBAction)activityClicked:(id)sender
{
	PiOpenCourseViewController *courseView = [[PiOpenCourseViewController alloc] initWithNibName:@"PiOpenCourseViewController" bundle:nil];
    //PiAcinfoViewController *acInfoView = [[PiAcinfoViewController alloc]initWithNibName:@"PiAcinfoViewController" bundle:nil];
	courseView.category = @"AcInfo";
	courseView.courseName = @"行业活动";
	courseView.itemPerPage = @"5";
	[self.navigationController pushViewController:courseView animated:YES];
}

- (IBAction)openCourseClicked:(id)sender
{
	PiOpenCourseViewController *courseView = [[PiOpenCourseViewController alloc] initWithNibName:@"PiOpenCourseViewController" bundle:nil];
    courseView.category = @"OpenCourse";
	courseView.courseName = @"公开课程";
	courseView.itemPerPage = @"5";
	[self.navigationController pushViewController:courseView animated:YES];
}

- (IBAction)shareClicked:(id)sender
{
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"分享" message:@"hello" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
	[alert show];
}

@end
