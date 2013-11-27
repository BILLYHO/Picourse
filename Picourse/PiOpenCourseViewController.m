//
//  PiOpenCourseViewController.m
//  Picourse
//
//  Created by Bloodshed on 13-11-24.
//  Copyright (c) 2013年 BILLY HO. All rights reserved.
//

#import "PiOpenCourseViewController.h"
#import "PiCourseViewController.h"
#import "UIBarButtonItem+ProjectButton.h"
#import "PiCollectionCell.h"
#import "PiBigCollectionCell.h"
#import "PiCourseLoadMoreCell.h"
#import "PiCollectionHeaderCell.h"
#import "PiCourseDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "KxMenu.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define base_url @"http://121.199.60.94/picourse/index.php/"
#define aRGB(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/1.0f]

@interface PiOpenCourseViewController ()

@end

@implementation PiOpenCourseViewController

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

- (IBAction)showTime:(UIBarButtonItem *)sender
{
	NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"三个月内" image:nil target:nil action:NULL],
      [KxMenuItem menuItem:@"半年内" image:nil target:nil action:NULL],
      [KxMenuItem menuItem:@"一年内" image:nil target:nil action:NULL],
	  [KxMenuItem menuItem:@"其他" image:nil target:nil action:NULL],
	  [KxMenuItem menuItem:@"返回" image:nil target:self action:@selector(didClickBackButton)],
      ];
    
    [KxMenu showMenuInView:self.view fromRect:CGRectMake(86, iPhone5?524:524-88, 44, 44)
				 menuItems:menuItems];
}

- (IBAction)showPlace:(UIBarButtonItem *)sender
{
	NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"北京" image:nil target:nil action:NULL],
      [KxMenuItem menuItem:@"南京" image:nil target:nil action:NULL],
      [KxMenuItem menuItem:@"东京" image:nil target:nil action:NULL],
	  [KxMenuItem menuItem:@"其他" image:nil target:nil action:NULL],
	  [KxMenuItem menuItem:@"返回" image:nil target:self action:@selector(didClickBackButton)],
      ];
    
    [KxMenu showMenuInView:self.view fromRect:CGRectMake(175, iPhone5?524:524-88, 44, 44)
				 menuItems:menuItems];
}

@end
