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
#import "PiSettingViewController.h"
#import "PiFeedbackViewController.h"

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
	
	[self.solutionButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 10, 10)];
	[self.solutionButton setImage:[UIImage imageNamed:@"Solution"] forState:UIControlStateNormal];
	[self.solutionButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -15, 5, 5)];
	[self.solutionButton setTitle:@"解决方案" forState:UIControlStateNormal];
	
	[self.perspectiveButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 10, 10)];
	[self.perspectiveButton setImage:[UIImage imageNamed:@"Perspective"] forState:UIControlStateNormal];
	[self.perspectiveButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -15, 5, 5)];
	[self.perspectiveButton setTitle:@"观察与观点" forState:UIControlStateNormal];
	
	[self.infomationButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 10, 10)];
	[self.infomationButton setImage:[UIImage imageNamed:@"Infomatiom"] forState:UIControlStateNormal];
	[self.infomationButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -15, 5, 5)];
	[self.infomationButton setTitle:@"行业资讯" forState:UIControlStateNormal];
	
	[self.seniorCourseButton setImageEdgeInsets:UIEdgeInsetsMake(-15, 30, 10, 10)];
	[self.seniorCourseButton setImage:[UIImage imageNamed:@"SeniorCourse"] forState:UIControlStateNormal];
	[self.seniorCourseButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -15, 5, 15)];
	[self.seniorCourseButton setTitle:@"高层管理课程" forState:UIControlStateNormal];
	self.seniorCourseButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	self.seniorCourseButton.titleLabel.textAlignment = NSTextAlignmentCenter;
	
	[self.generalCourseButton setImageEdgeInsets:UIEdgeInsetsMake(-15, 30, 10, 10)];
	[self.generalCourseButton setImage:[UIImage imageNamed:@"GeneralCourse"] forState:UIControlStateNormal];
	[self.generalCourseButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -25, 5, 5)];
	[self.generalCourseButton setTitle:@"中基层人员管理课程" forState:UIControlStateNormal];
	self.generalCourseButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	self.generalCourseButton.titleLabel.lineBreakMode = NSTextAlignmentCenter;
	
	[self.activityButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 10, 10)];
	[self.activityButton setImage:[UIImage imageNamed:@"Activity"] forState:UIControlStateNormal];
	[self.activityButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -15, 5, 5)];
	[self.activityButton setTitle:@"行业活动" forState:UIControlStateNormal];
	
	[self.openCourseButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 10, 10)];
	[self.openCourseButton setImage:[UIImage imageNamed:@"OpenCourse"] forState:UIControlStateNormal];
	[self.openCourseButton setTitleEdgeInsets:UIEdgeInsetsMake(60, -15, 5, 5)];
	[self.openCourseButton setTitle:@"公开课程" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectedCourseClicked:(id)sender
{
	PiInfomationViewController *infoView = [[PiInfomationViewController alloc] initWithNibName:@"PiInfomationViewController" bundle:nil];
	self.navigationController.navigationBarHidden = NO;
	infoView.navigationItem.title = @"精选课程";
	[self.navigationController pushViewController:infoView animated:YES];
}

- (IBAction)solutionClicked:(id)sender
{
	PiInfomationViewController *infoView = [[PiInfomationViewController alloc] initWithNibName:@"PiInfomationViewController" bundle:nil];
	self.navigationController.navigationBarHidden = NO;
	infoView.navigationItem.title = @"解决方案";
	[self.navigationController pushViewController:infoView animated:YES];
}

- (IBAction)perspectiveClicked:(id)sender
{
	PiInfomationViewController *infoView = [[PiInfomationViewController alloc] initWithNibName:@"PiInfomationViewController" bundle:nil];
	self.navigationController.navigationBarHidden = NO;
	infoView.navigationItem.title = @"观察与观点";
	[self.navigationController pushViewController:infoView animated:YES];
}

- (IBAction)infoClicked:(id)sender
{
	PiInfomationViewController *infoView = [[PiInfomationViewController alloc] initWithNibName:@"PiInfomationViewController" bundle:nil];
	self.navigationController.navigationBarHidden = NO;
	infoView.navigationItem.title = @"行业资讯";
	[self.navigationController pushViewController:infoView animated:YES];
}

- (IBAction)seniorCourseClicked:(id)sender
{
	PiCourseViewController *courseView = [[PiCourseViewController alloc] initWithNibName:@"PiCourseViewController" bundle:nil];
	self.navigationController.navigationBarHidden = NO;
	courseView.navigationItem.title = @"高层管理课程";
	[self.navigationController pushViewController:courseView animated:YES];
}

- (IBAction)generalCourseClicked:(id)sender
{
	PiCourseViewController *courseView = [[PiCourseViewController alloc] initWithNibName:@"PiCourseViewController" bundle:nil];
	self.navigationController.navigationBarHidden = NO;
	courseView.navigationItem.title = @"中基层人员管理课程";
	[self.navigationController pushViewController:courseView animated:YES];
}

- (IBAction)activityClicked:(id)sender
{
	PiInfomationViewController *infoView = [[PiInfomationViewController alloc] initWithNibName:@"PiInfomationViewController" bundle:nil];
	self.navigationController.navigationBarHidden = NO;
	infoView.navigationItem.title = @"行业活动";
	[self.navigationController pushViewController:infoView animated:YES];
}

- (IBAction)openCourseClicked:(id)sender
{
	PiCourseViewController *courseView = [[PiCourseViewController alloc] initWithNibName:@"PiCourseViewController" bundle:nil];
	self.navigationController.navigationBarHidden = NO;
	courseView.navigationItem.title = @"公开课程";
	[self.navigationController pushViewController:courseView animated:YES];
}

- (IBAction)shareClicked:(id)sender
{
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"分享" message:@"hello" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
	[alert show];
}

- (IBAction)settingClicked:(id)sender
{
	PiSettingViewController *settingView = [[PiSettingViewController alloc] initWithNibName:@"PiSettingViewController" bundle:nil];
	self.navigationController.navigationBarHidden = NO;
	settingView.navigationItem.title = @"设置";
	[self.navigationController pushViewController:settingView animated:YES];
}

- (IBAction)favouriteClicked:(id)sender
{
	PiInfomationViewController *infoView = [[PiInfomationViewController alloc] initWithNibName:@"PiInfomationViewController" bundle:nil];
	self.navigationController.navigationBarHidden = NO;
	infoView.navigationItem.title = @"收藏";
	[self.navigationController pushViewController:infoView animated:YES];
}

- (IBAction)feedbackClicked:(id)sender
{
	PiFeedbackViewController *feedbackview = [[PiFeedbackViewController alloc] initWithNibName:@"PiFeedbackViewController" bundle:nil];
	self.navigationController.navigationBarHidden = NO;
	feedbackview.navigationItem.title = @"反馈";
	[self.navigationController pushViewController:feedbackview animated:YES];
}
@end
