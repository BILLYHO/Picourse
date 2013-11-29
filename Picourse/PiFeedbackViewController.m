//
//  PiFeedbackViewController.m
//  Picourse
//
//  Created by BILLY HO on 10/9/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import "PiFeedbackViewController.h"
#import "UIBarButtonItem+ProjectButton.h"

@interface PiFeedbackViewController ()

@end

@implementation PiFeedbackViewController

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
	[self customizeNavigationBar];
	
	UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBackButton)];
	[recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
	[self.view addGestureRecognizer:recognizer];
	
	}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Back Button
- (void)didClickBackButton
{
	self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)customizeNavigationBar
{
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem createEdgeButtonWithImage:[UIImage imageNamed:@"Back"] WithTarget:self action:@selector(didClickBackButton)];
}

- (IBAction)showWithGradient:(id)sender
{
	
	_HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:_HUD];
	_HUD.labelText = @"正在提交...";
	_HUD.dimBackground = YES;
	
	// Regiser for HUD callbacks so we can remove it from the window at the right time
	_HUD.delegate = self;
	
	// Show the HUD while the provided method executes in a new thread
	[_HUD showWhileExecuting:@selector(myMixedTask) onTarget:self withObject:nil animated:YES];
}

- (void)myMixedTask
{
	// Indeterminate mode
	sleep(2);
	// UIImageView is a UIKit class, we have to initialize it on the main thread
	__block UIImageView *imageView;
	dispatch_sync(dispatch_get_main_queue(), ^{
		UIImage *image = [UIImage imageNamed:@"37x-Checkmark.png"];
		imageView = [[UIImageView alloc] initWithImage:image];
	});
	
	_HUD.customView = imageView;
	_HUD.mode = MBProgressHUDModeCustomView;
	_HUD.labelText = @"已提交";
	sleep(2);
}

#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
	// Remove HUD from screen when the HUD was hidded
	[_HUD removeFromSuperview];
	_HUD = nil;
}

@end
