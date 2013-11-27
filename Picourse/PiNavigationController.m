//
//  PiNavigationController.m
//  Picourse
//
//  Created by BILLY HO on 10/31/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import "PiNavigationController.h"
#import "PiMenuViewController.h"
#import "UIViewController+REFrostedViewController.h"

@interface PiNavigationController ()

@end

@implementation PiNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe)];
	[recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
	[self.view addGestureRecognizer:recognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightSwipe
{
	if(self.viewControllers.count <= 1)
		[self.frostedViewController presentMenuViewController];
	else
		[self popViewControllerAnimated:YES];
}

@end
