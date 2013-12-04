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
	NSLog(_url);
	NSLog(_company);
	NSLog(_titleName);
	UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBackButton)];
	[recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
	[_courseDetailWebView addGestureRecognizer:recognizer];
	[_courseDetailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
	
	NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
	NSArray *course = [dataBase objectForKey:@"CourseFavourite"];
	BOOL flag = FALSE;
	for (NSDictionary *tmp in course)
	{
		if ([[tmp objectForKey:@"url"] isEqualToString:_url])
		{
			flag = TRUE;
			break;
		}
	}
	if(flag)
		_favouriteButton.tintColor = aRGB(255, 200, 0, 1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Back Button
- (void)didClickBackButton
{
	if ([_flag isEqualToString:@"fav"])
		self.navigationController.navigationBarHidden = NO;
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)back:(id)sender
{
	if ([_flag isEqualToString:@"fav"])
		self.navigationController.navigationBarHidden = NO;
	[self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)didClickedFavouriteButton:(id)sender
{
	if ([_favouriteButton.tintColor isEqual:aRGB(255, 200, 0, 1)])
	{
		_favouriteButton.tintColor = aRGB(0, 122, 255, 1);
		NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
		NSArray *course = [dataBase objectForKey:@"CourseFavourite"];
		NSMutableArray *newCourse = [[NSMutableArray alloc]initWithArray:course];
		for (int i=0; i<[newCourse count]; i++)
		{
			NSDictionary *tmp = [newCourse objectAtIndex:i];
			if ([[tmp objectForKey:@"url"] isEqualToString:_url])
			{
				[newCourse removeObjectAtIndex:i];
				break;
			}
		}
		[dataBase setObject:newCourse forKey:@"CourseFavourite"];
		[dataBase synchronize];
	}
	else
	{
		_favouriteButton.tintColor = aRGB(255, 200, 0, 1);
		NSArray *courseObj = @[_url ,_titleName, _company];
		NSArray *courseKey = @[@"url" ,@"title", @"company"];
		NSDictionary *entry = [[NSDictionary alloc] initWithObjects:courseObj forKeys:courseKey];
		NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
		NSArray *course = [dataBase objectForKey:@"CourseFavourite"];
		NSMutableArray *newCourse = [[NSMutableArray alloc]initWithArray:course];
		[newCourse addObject:entry];
		[dataBase setObject:newCourse forKey:@"CourseFavourite"];
		[dataBase synchronize];
	}
}

@end
