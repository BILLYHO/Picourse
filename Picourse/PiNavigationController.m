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
	UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe)];
	[rightRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
	[self.view addGestureRecognizer:rightRecognizer];
	
	UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe)];
	[leftRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
	[self.view addGestureRecognizer:leftRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightSwipe
{
	[self popViewControllerAnimated:YES];
}

- (void)leftSwipe
{
	if(self.viewControllers.count <= 1)
		[self.frostedViewController presentMenuViewController];
}

@end
