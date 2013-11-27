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
    [self.navigationController popViewControllerAnimated:YES];
}


@end
