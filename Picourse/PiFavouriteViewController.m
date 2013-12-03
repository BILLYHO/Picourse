//
//  PiFavouriteViewController.m
//  Picourse
//
//  Created by BILLY HO on 11/27/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import "PiFavouriteViewController.h"
#import "UIBarButtonItem+ProjectButton.h"
#import "PiNormalCell.h"

#import "PiAppDelegate.h"
#import "Info.h"
#import "Course.h"

#define aRGB(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/1.0f]

@interface PiFavouriteViewController ()

@end

@implementation PiFavouriteViewController
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
	[self customizeNavigationBar];
	
	self.navigationController.navigationBarHidden = NO;
	PiAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
	_infoArray = [appDelegate getAllInfo];
	_courseArray = [appDelegate getAllCourse];
	_record = [NSMutableArray arrayWithArray:_infoArray];
	
	UINib *normalnib = [UINib nibWithNibName:@"PiNormalCell" bundle:nil];
	[self.favouriteTableView registerNib:normalnib forCellReuseIdentifier:normalCellIdentifier];
	
	UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBackButton)];
	[recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
	[self.favouriteTableView addGestureRecognizer:recognizer];
    _segementBar.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customizeNavigationBar
{
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem createEdgeButtonWithImage:[UIImage imageNamed:@"Back"] WithTarget:self action:@selector(didClickBackButton)];
}

#pragma mark - Back Button
- (void)didClickBackButton
{
	self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)back:(id)sender
{
	self.navigationController.navigationBarHidden = YES;
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma Segment stuff
- (IBAction)changeSegment:(UISegmentedControl *)sender
{
	
    if ([sender selectedSegmentIndex] == 0)
	{
        _record = [NSMutableArray arrayWithArray:_infoArray];
		[_favouriteTableView reloadData];
    }
	else
	{
		_record = [NSMutableArray arrayWithArray:_courseArray];
		[_favouriteTableView reloadData];
	}
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_record count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
//    if (sectionIndex == 0)
//        return 0;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	PiNormalCell *cell = (PiNormalCell *)[tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
	if (cell == nil)
	{
		cell = [[PiNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellIdentifier];
	}
	if([_segementBar selectedSegmentIndex] == 0)
	{
		Info *cellInfo = [_record objectAtIndex:indexPath.row];
		cell.cellImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.199.60.94/%@",cellInfo.imageUrl]]]];
		cell.titleLabel.text = cellInfo.title;
		cell.contentLabel.text = [NSString stringWithFormat:@"%@",cellInfo.content];
		//cell.companyLabel.text = [NSString stringWithFormat:@"%@    %@", cellInfo.company, cellInfo.auther];
        cell.companyLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
	}
	else
	{
		Course *cellInfo = [_record objectAtIndex:indexPath.row];
		cell.titleLabel.text = cellInfo.category;
		cell.companyLabel.text = @"";
		cell.cellImage.image = Nil;
		cell.contentLabel.text = cellInfo.company;
	}
	
		
	if(indexPath.row % 2 != 0)
		cell.backgroundColor = aRGB(239, 239, 239, 1);
	else
		cell.backgroundColor = [UIColor whiteColor];
		
	return cell;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	PiAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
	[appDelegate deleteItem:(NSManagedObject *)[_record objectAtIndex:indexPath.row]];
	
	[_record removeObjectAtIndex:indexPath.row];
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return @" 删 \n 除  ";
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 110;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
