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

#define base_url @"http://121.199.60.94/picourse/index.php/"

@interface PiInfomationViewController ()

@end

@implementation PiInfomationViewController

static NSString *topCellIdentifier = @"TopCell";
static NSString *normalCellIdentifier = @"NormalCell";
int cellNum = 5;

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
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
		return cellNum;
	else
		return 1;//5;//rand()%10+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	int num = 0;
	if ([_category isEqualToString:@"SelectedCourse"])
	{
		num = 7 + indexPath.row % 5;
	}
	if ([_category isEqualToString:@"SolutionInfo"] || [_category isEqualToString:@"ViewInfo"])
	{
		num = 1;
	}
	if ([_category isEqualToString:@"NewsInfo"] || [_category isEqualToString:@"AcInfo"])
	{
		num = 1 + indexPath.row % 5;
	}
	
	//fetch data from the server
    NSError *error;
    //加载一个NSURL对象
    NSString *urlString = [base_url stringByAppendingString:
						   [NSString stringWithFormat:@"%@/get%@ById/id/%d",_category,_category,num]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *courseDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    NSArray *courseArr = [courseDic objectForKey:@"data"];
	NSDictionary *courseInfo = [courseArr objectAtIndex:0];


	NSString *title, *content;
	if ([_category isEqualToString:@"SelectedCourse"])
	{
		title = [NSString stringWithFormat:@"%@ ",[courseInfo objectForKey:@"theme"]];
		content = [NSString stringWithFormat:@"%@",[courseInfo objectForKey:@"target"]];
	}
	if ([_category isEqualToString:@"SolutionInfo"] || [_category isEqualToString:@"ViewInfo"]){
		title = [NSString stringWithFormat:@"%@ ",[courseInfo objectForKey:@"title"]];
		content = [NSString stringWithFormat:@"%@",[courseInfo objectForKey:@"content"]];
	}
	if ([_category isEqualToString:@"NewsInfo"] || [_category isEqualToString:@"AcInfo"])
	{
		title = [NSString stringWithFormat:@"%@ ",[courseInfo objectForKey:@"title"]];
		content = [NSString stringWithFormat:@"%@",[courseInfo objectForKey:@"intro"]];
	}
	
	
    if (indexPath.section == 0 && indexPath.row % 5 == 0)
	{
		PiTopCell *cell = (PiTopCell *)[tableView dequeueReusableCellWithIdentifier:topCellIdentifier];
        
		if (cell == nil)
		{
			cell = [[PiTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topCellIdentifier];
		}
		cell.cellImage.image = [UIImage imageNamed:@"ted.jpg"];
		cell.titleLabel.textColor = [UIColor whiteColor];
		cell.titleLabel.text = title;
		cell.titleLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
		cell.companyLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
		//cell.titleLabel.font = [UIFont fontNamesForFamilyName:@"Helvetica"];
		cell.companyLabel.textColor = [UIColor whiteColor];
		cell.companyLabel.text = @"主办机构";
		return cell;
	}
	else if (indexPath.section == 0)
	{
		PiNormalCell *cell = (PiNormalCell *)[tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
		if (cell == nil)
		{
			cell = [[PiNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellIdentifier];
		}
		[self.tableView setRowHeight:100];
		cell.cellImage.image = [UIImage imageNamed:@"ted.jpg"];
        cell.titleLabel.text = title;
        cell.companyLabel.text = [NSString stringWithFormat:@"%@",[courseInfo objectForKey:@"agency_id"]];
        cell.contentLabel.text = content;
		cell.contentLabel.numberOfLines = 3;
		return cell;
	}
	else
	{
		PiNormalCell *cell = (PiNormalCell *)[tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
		if (cell == nil)
		{
			cell = [[PiNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellIdentifier];
		}
        cell.textLabel.text = @"load more";
		return cell;
	}
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0)
		return indexPath.row % 5 == 0 ? 210 : 100;
	else
		return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1)
	{
		cellNum += 5;
		[tableView reloadData];
	}
	else
	{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	PiInfomationDetailViewController *detailview = [[PiInfomationDetailViewController alloc]initWithNibName:@"PiInfomationDetailViewController" bundle:nil];
	[self.navigationController pushViewController:detailview animated:YES];
	}
}

@end
