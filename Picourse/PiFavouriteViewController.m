//
//  PiFavouriteViewController.m
//  Picourse
//
//  Created by BILLY HO on 11/27/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import "PiFavouriteViewController.h"
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
		self.navigationController.navigationBarHidden = NO;
		PiAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
		_infoArray = [appDelegate getAllInfo];
		_courseArray = [appDelegate getAllCourse];
		_record = [NSMutableArray arrayWithArray:_infoArray];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	UINib *normalnib = [UINib nibWithNibName:@"PiNormalCell" bundle:nil];
	[self.favouriteTableView registerNib:normalnib forCellReuseIdentifier:normalCellIdentifier];
	
	UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBackButton)];
	[recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
	[self.favouriteTableView addGestureRecognizer:recognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Back Button
- (void)didClickBackButton
{
	self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)back:(id)sender
{
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
		cell.titleLabel.text = cellInfo.category;
		cell.contentLabel.text = [NSString stringWithFormat:@"row %@",cellInfo.identifier];
		cell.companyLabel.text = [NSString stringWithFormat:@"%@    %@", cellInfo.company, cellInfo.auther];
	}
	else
	{
		Course *cellInfo = [_record objectAtIndex:indexPath.row];
		cell.titleLabel.text = cellInfo.category;
		cell.companyLabel.text = cellInfo.company;
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
	return @"删除";
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 100;
}


@end
