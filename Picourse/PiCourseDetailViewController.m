//
//  PiCourseDetailViewController.m
//  Picourse
//
//  Created by BILLY HO on 10/10/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import "PiCourseDetailViewController.h"

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
		[_detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://121.199.60.94/web/detailPage/course.html?course=OpenCourse&id=10"]]];
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
