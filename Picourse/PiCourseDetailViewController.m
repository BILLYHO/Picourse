//
//  PiCourseDetailViewController.m
//  Picourse
//
//  Created by BILLY HO on 10/10/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import "PiCourseDetailViewController.h"
#define aRGB(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/1.0f]


@interface PiCourseDetailViewController ()

@end

@implementation PiCourseDetailViewController
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
	[_courseDetailWebView addGestureRecognizer:recognizer];
	[_courseDetailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}
- (IBAction)didClickedFavouriteButton:(id)sender
{
	if (_favouriteButton.tintColor != [UIColor yellowColor])
		_favouriteButton.tintColor = [UIColor yellowColor];
	else
		_favouriteButton.tintColor = aRGB(0, 122, 255, 1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	

}

- (IBAction)back:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
