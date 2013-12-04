//
//  PiInfomationDetailViewController.m
//  Picourse
//
//  Created by BILLY HO on 10/10/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import "PiInfomationDetailViewController.h"

#define aRGB(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/1.0f]
@interface PiInfomationDetailViewController ()

@end

@implementation PiInfomationDetailViewController

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
	[_infoDetailWebview addGestureRecognizer:recognizer];
	[_infoDetailWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
	
	NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
	NSArray *info = [dataBase objectForKey:@"InfoFavourite"];
	BOOL flag = FALSE;
	for (NSDictionary *tmp in info)
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

- (IBAction)didClickFavouriteButton:(id)sender
{
	if ([_favouriteButton.tintColor isEqual:aRGB(255, 200, 0, 1)])
	{
		_favouriteButton.tintColor = aRGB(0, 122, 255, 1);
		NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
		NSArray *info = [dataBase objectForKey:@"InfoFavourite"];
		NSMutableArray *newInfo = [[NSMutableArray alloc]initWithArray:info];
		for (int i=0; i<[newInfo count]; i++)
		{
			NSDictionary *tmp = [newInfo objectAtIndex:i];
			if ([[tmp objectForKey:@"url"] isEqualToString:_url])
			{
				[newInfo removeObjectAtIndex:i];
				break;
			}
		}
		[dataBase setObject:newInfo forKey:@"InfoFavourite"];
		[dataBase synchronize];
	}
	else
	{
		_favouriteButton.tintColor = aRGB(255, 200, 0, 1);
		NSArray *infoObj = @[_url ,_titleName, _content, _company, _imageUrl];
		NSArray *infoKey = @[@"url" ,@"title", @"content", @"company" ,@"imageUrl"];
		NSDictionary *entry = [[NSDictionary alloc] initWithObjects:infoObj forKeys:infoKey];
		NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
		NSArray *info = [dataBase objectForKey:@"InfoFavourite"];
		NSMutableArray *newInfo = [[NSMutableArray alloc]initWithArray:info];
		[newInfo addObject:entry];
		[dataBase setObject:newInfo forKey:@"InfoFavourite"];
		[dataBase synchronize];
	}
}
@end
