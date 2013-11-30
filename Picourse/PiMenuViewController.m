//
//  PiMenuViewController.m
//  Picourse
//
//  Created by BILLY HO on 10/31/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import "PiMenuViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "PiSettingViewController.h"
#import "PiFeedbackViewController.h"
#import "PiFavouriteViewController.h"


@interface PiMenuViewController ()

@end

@implementation PiMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.20 alpha:1.00];
    
	self.tableView.tableHeaderView = (
	{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 0, 70)];
		view.backgroundColor = [UIColor colorWithRed:0.14 green:0.19 blue:0.24 alpha:1.00];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 171, 29)];
		imageView.image = [UIImage imageNamed:@"Picourse"];
		
        [view addSubview:imageView];
        view;
    });

}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.backgroundColor = [UIColor colorWithRed:0.14 green:0.19 blue:0.24 alpha:1.00];
	cell.layer.borderColor = [UIColor colorWithRed:0.12 green:0.16 blue:0.20 alpha:1.00].CGColor;
	cell.layer.borderWidth = 0.3f;
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
	cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
	UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
	back.backgroundColor = [UIColor colorWithRed:0.07 green:0.09 blue:0.12 alpha:1.00];
	cell.selectedBackgroundView = back;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UINavigationController *navigationController = (UINavigationController *)self.frostedViewController.contentViewController;
	
	
	
    if (indexPath.row == 3)
	{
        PiSettingViewController *settingView = [[PiSettingViewController alloc] initWithNibName:@"PiSettingViewController" bundle:nil];
		settingView.navigationItem.title = @"设置";
		[navigationController pushViewController:settingView animated:YES];
    }
	else if (indexPath.row == 1)
	{
		PiFavouriteViewController *infoView = [[PiFavouriteViewController alloc] initWithNibName:@"PiFavouriteViewController" bundle:nil];
		navigationController.navigationBarHidden = NO;
		infoView.navigationItem.title = @"收藏列表";
		infoView.navigationController.navigationBarHidden = NO;
		[navigationController pushViewController:infoView animated:YES];
	}
	else if (indexPath.row == 2)
	{
        PiFeedbackViewController *feedbackview = [[PiFeedbackViewController alloc] initWithNibName:@"PiFeedbackViewController" bundle:nil];
		navigationController.navigationBarHidden = NO;
		feedbackview.navigationItem.title = @"意见反馈";
		[navigationController pushViewController:feedbackview animated:YES];
    }
    
    [self.frostedViewController hideMenuViewController];
}

#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

	NSArray *titles = @[@"首页", @"收藏列表", @"意见反馈",@"使用帮助"];
	NSArray *pics = @[[UIImage imageNamed:@"Home"], [UIImage imageNamed:@"Favourite"], [UIImage imageNamed:@"Feedback"],[UIImage imageNamed:@"Setting"]];
	cell.textLabel.text = titles[indexPath.row];
	cell.imageView.image = pics[indexPath.row];
    return cell;
}


@end
