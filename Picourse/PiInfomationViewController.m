//
//  PiInfomationViewController.m
//  Picourse
//
//  Created by BILLY HO on 10/9/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import "PiInfomationViewController.h"
#import "UIBarButtonItem+ProjectButton.h"
#import "PiTopCell.h"
#import "PiNormalCell.h"
#import "PiInfomationDetailViewController.h"

@interface PiInfomationViewController ()



@end

@implementation PiInfomationViewController

static NSString *topCellIdentifier = @"TopCell";
static NSString *normalCellIdentifier = @"NormalCell";

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
	[self customNavigationBar];
	
	UINib *topnib = [UINib nibWithNibName:@"PiTopCell" bundle:nil];
	[self.tableView registerNib:topnib forCellReuseIdentifier:topCellIdentifier];
	UINib *normalnib = [UINib nibWithNibName:@"PiNormalCell" bundle:nil];
	[self.tableView registerNib:normalnib forCellReuseIdentifier:normalCellIdentifier];
	//[self.tableView setRowHeight:210];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Navigation Bar
- (void)customNavigationBar
{
	self.navigationItem.leftBarButtonItems = [UIBarButtonItem createEdgeButtonWithImage:[UIImage imageNamed:@"Back"] WithTarget:self action:@selector(didClickBackButton)];
}

#pragma mark - Back Button
- (void)didClickBackButton
{
	self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;//rand()%10+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    if (indexPath.row == 0)
	{
		PiTopCell *cell = (PiTopCell *)[tableView dequeueReusableCellWithIdentifier:topCellIdentifier];
		if (cell == nil)
		{
			cell = [[PiTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topCellIdentifier];
		}
		cell.cellImage.image = [UIImage imageNamed:@"ted.jpg"];
		cell.titleLabel.textColor = [UIColor whiteColor];
		cell.titleLabel.text = @"标题";
		cell.companyLabel.textColor = [UIColor whiteColor];
		cell.companyLabel.text = @"主办机构";
		return cell;
	}
	else
	{
		PiNormalCell *cell = (PiNormalCell *)[tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
		if (cell == nil)
		{
			cell = [[PiNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellIdentifier];
		}
		[self.tableView setRowHeight:100];
		cell.cellImage.image = [UIImage imageNamed:@"ted.jpg"];
		cell.titleLabel.text = @"标题";
		cell.companyLabel.text = @"主办机构";
		cell.contentLabel.text = @"内容有很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多很多";
		cell.contentLabel.numberOfLines = 3;
		return cell;
	}
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return indexPath.row == 0 ? 210 : 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	PiInfomationDetailViewController *detailview = [[PiInfomationDetailViewController alloc]initWithNibName:@"PiInfomationDetailViewController" bundle:nil];
	[self.navigationController pushViewController:detailview animated:YES];
}

@end
