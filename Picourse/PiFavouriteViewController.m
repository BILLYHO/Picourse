//
//  PiFavouriteViewController.m
//  Picourse
//
//  Created by BILLY HO on 11/27/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import "PiFavouriteViewController.h"
#import "PiNormalCell.h"
#import "Favourite.h"
#import "PiAppDelegate.h"

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
		PiAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
		_fetchedRecordsArray = [appDelegate getAllFavourite];
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)back:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_fetchedRecordsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	Favourite *info = [_fetchedRecordsArray objectAtIndex:indexPath.row];
	
	PiNormalCell *cell = (PiNormalCell *)[tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
	if (cell == nil)
	{
		cell = [[PiNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellIdentifier];
	}
	cell.cellImage.image = [UIImage imageNamed:@"avatar"];
	cell.titleLabel.text = info.category;
	cell.contentLabel.text = [NSString stringWithFormat:@"row %@",info.identifier];
	cell.companyLabel.text = [NSString stringWithFormat:@"%@    %@", info.company, info.auther];
//		cell.cellImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.199.60.94/%@",[infoInfo objectForKey: @"img_url"]]]]];
//        cell.titleLabel.text = [infoInfo objectForKey:@"title"];
//        cell.contentLabel.text = [infoInfo objectForKey:@"intro"];
//		cell.contentLabel.numberOfLines = 3;
//		cell.companyLabel.text = [infoInfo objectForKey:@"agency_name"];
//        if([_category isEqualToString:@"ViewInfo"] || [_category isEqualToString:@"SolutionInfo"])
//        {
//            NSString *author = [NSString stringWithFormat:@"%@",[infoInfo objectForKey:@"teach_id"]];
//            cell.companyLabel.text = [NSString stringWithFormat:@"%@  %@",cell.companyLabel.text,author];
//            cell.companyLabel.adjustsFontSizeToFitWidth = YES;
//        }
//        if([_category isEqualToString:@"NewsInfo"])
//        {
//            NSString *time = [NSString stringWithFormat:@"%@",[infoInfo objectForKey:@"time"]];
//            //time = [time substringWithRange:NSMakeRange(0, 10)];
//            cell.companyLabel.text = [NSString stringWithFormat:@"%@  %@",cell.companyLabel.text,time];
//            cell.companyLabel.adjustsFontSizeToFitWidth = YES;
//        }
		
        
        if(indexPath.row % 2 != 0)
            cell.backgroundColor = aRGB(239, 239, 239, 1);
        else
            cell.backgroundColor = [UIColor whiteColor];
		
		return cell;
	
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	
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
