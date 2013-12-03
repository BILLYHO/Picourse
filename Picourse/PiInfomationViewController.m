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
#import "KxMenu.h"


#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define base_url @"http://121.199.60.94/picourse/index.php/"
#define aRGB(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/1.0f]

@interface PiInfomationViewController ()

@end

@implementation PiInfomationViewController

static NSString *topCellIdentifier = @"TopCell";
static NSString *normalCellIdentifier = @"NormalCell";
static NSString *loadMoreCell = @"LoadMoreCell";

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
	
	_infoArr = [NSMutableArray arrayWithArray:[self loadDataAtPage:1]];
	[self.tableView reloadData];
    
    self.backButton.image = [UIImage imageNamed:@"Back.png"];
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, 10, 40)];
    tempLabel.text = _infoName;
    tempLabel.font = [UIFont boldSystemFontOfSize:18];
    CGSize newSize = [tempLabel sizeThatFits:tempLabel.frame.size];
    CGRect frame = tempLabel.frame;
    frame.size = newSize;
    frame.size.height = 40;
    frame.size.width += 20;
    UILabel *finalNameLabel = [[UILabel alloc] initWithFrame:frame];
    finalNameLabel.text = tempLabel.text;
    finalNameLabel.backgroundColor = aRGB(107, 183, 225, 1);
    finalNameLabel.textColor = [UIColor whiteColor];
    finalNameLabel.font = [UIFont boldSystemFontOfSize:18];
    finalNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:finalNameLabel];
	
	UINib *topnib = [UINib nibWithNibName:@"PiTopCell" bundle:nil];
	[self.tableView registerNib:topnib forCellReuseIdentifier:topCellIdentifier];
	UINib *normalnib = [UINib nibWithNibName:@"PiNormalCell" bundle:nil];
	[self.tableView registerNib:normalnib forCellReuseIdentifier:normalCellIdentifier];
	
	UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBackButton)];
	[recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
	[self.tableView addGestureRecognizer:recognizer];
	
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

#pragma mark - Load Data
- (NSArray *)loadDataAtPage:(int)page
{
	NSError *error;
	NSString *urlString = [base_url stringByAppendingString:
						   [NSString stringWithFormat:@"%@/get%@ByPage/page_num/%d",_category,_category,page]];
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSDictionary *infoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
	NSArray *infoArr = [infoDic objectForKey:@"data"];
	return infoArr;
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_infoArr == nil)
		return 0;
	return [_infoArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    if (indexPath.section == 0 && indexPath.row % [_itemPerPage intValue] == 0)
	{
		PiTopCell *cell = (PiTopCell *)[tableView dequeueReusableCellWithIdentifier:topCellIdentifier];
		
		NSDictionary *infoInfo = [_infoArr objectAtIndex:indexPath.row];
		if (cell == nil)
		{
			cell = [[PiTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topCellIdentifier];
		}
		cell.cellImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.199.60.94/%@",[infoInfo objectForKey: @"img_url"]]]]];
		cell.titleLabel.textColor = [UIColor whiteColor];
		cell.titleLabel.text = [infoInfo objectForKey:@"title"];
		cell.companyLabel.textColor = [UIColor whiteColor];
        cell.companyLabel.text = [infoInfo objectForKey:@"agency_name"];
        
		if([_category isEqualToString:@"ViewInfo"] || [_category isEqualToString:@"SolutionInfo"])
        {
            NSString *author = [NSString stringWithFormat:@"%@",[infoInfo objectForKey:@"teach_id"]];
            cell.companyLabel.text = [NSString stringWithFormat:@"%@  %@",cell.companyLabel.text,author];
        }
#warning        2013-12-02 行业新闻时间后台仍未添加
//        else if ([_category isEqualToString:@"NewsInfo"])
//        {
//
//            NSString *originalTime = [NSString stringWithFormat:@"%@",[infoInfo objectForKey:@"time"]];
//            NSString *year = [originalTime substringWithRange:NSMakeRange(0, 4)];
//            NSString *month = [originalTime substringWithRange:NSMakeRange(5, 2)];
//            NSString *day = [originalTime substringWithRange:NSMakeRange(8, 2)];
//            NSString *finalTime = [NSString stringWithFormat:@"%@年%@月%@日",year,month,day];
//            cell.companyLabel.text = [NSString stringWithFormat:@"%@  %@",cell.companyLabel.text,finalTime];
//        }
        cell.backView.alpha = 0.65;
		return cell;
	}
	else if (indexPath.section == 0)
	{
		PiNormalCell *cell = (PiNormalCell *)[tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
		if (cell == nil)
		{
			cell = [[PiNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellIdentifier];
		}
#warning TBD
		NSDictionary *infoInfo = [_infoArr objectAtIndex: indexPath.row];
		cell.cellImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.199.60.94/%@",[infoInfo objectForKey: @"img_url"]]]]];
        cell.titleLabel.text = [infoInfo objectForKey:@"title"];
        
        cell.contentLabel.text = [infoInfo objectForKey:@"intro"];
        cell.contentLabel.textColor = [UIColor colorWithRed:0.44 green:0.44 blue:0.44 alpha:1.00];
		
		cell.companyLabel.text = [infoInfo objectForKey:@"agency_name"];
        cell.companyLabel.textColor = [UIColor colorWithRed:0.44 green:0.44 blue:0.44 alpha:1.00];
        
		if([_category isEqualToString:@"ViewInfo"] || [_category isEqualToString:@"SolutionInfo"])
        {
            NSString *author = [NSString stringWithFormat:@"%@",[infoInfo objectForKey:@"teach_id"]];
            cell.companyLabel.text = [NSString stringWithFormat:@"%@  %@",cell.companyLabel.text,author];
            cell.companyLabel.adjustsFontSizeToFitWidth = YES;
        }
//        if([_category isEqualToString:@"NewsInfo"])
//        {
//            NSString *originalTime = [NSString stringWithFormat:@"%@",[infoInfo objectForKey:@"time"]];
//            NSString *year = [originalTime substringWithRange:NSMakeRange(0, 4)];
//            NSString *month = [originalTime substringWithRange:NSMakeRange(5, 2)];
//            NSString *day = [originalTime substringWithRange:NSMakeRange(8, 2)];
//            NSString *finalTime = [NSString stringWithFormat:@"%@年%@月%@日",year,month,day];
//            cell.companyLabel.text = [NSString stringWithFormat:@"%@  %@",cell.companyLabel.text,time];
//            cell.companyLabel.adjustsFontSizeToFitWidth = YES;
//        }
		
        
        if(indexPath.row % 2 != 0)
            cell.backgroundColor = aRGB(239, 239, 239, 1);
        else
            cell.backgroundColor = [UIColor whiteColor];
            
		return cell;
	}
	else
	{
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoadMoreCell"];
		if(cell == nil)
		{
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loadMoreCell];
		}
		
        cell.textLabel.text = @"load more";
		return cell;
	}
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0 )
		return indexPath.row % [_itemPerPage intValue] == 0 ? 175 : 110;
	else
		return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSDictionary *infoInfo = [_infoArr objectAtIndex:indexPath.row];
	PiInfomationDetailViewController *detailview = [[PiInfomationDetailViewController alloc]initWithNibName:@"PiInfomationDetailViewController" bundle:nil];
	detailview.url = [NSString stringWithFormat:@"http://121.199.60.94/web/detailPage/info.html?info=%@&id=%@",_category,[infoInfo objectForKey:@"id"]];
	[self.navigationController pushViewController:detailview animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row + 1 == [_infoArr count])
	{
		NSArray *newArr = [self loadDataAtPage: indexPath.row/[_itemPerPage intValue] + 2];
		if (newArr != nil)
		{
			[_infoArr addObjectsFromArray:newArr];
			[tableView reloadData];
		}
	}
}

#pragma menu
- (IBAction)showMenu:(UIBarButtonItem *)sender
{
	NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"学位项目" image:nil target:nil action:NULL],
      [KxMenuItem menuItem:@"非学位项目" image:nil target:nil action:NULL],
      [KxMenuItem menuItem:@"战略管理" image:nil target:nil action:NULL],
      [KxMenuItem menuItem:@"市场营销" image:nil target:nil action:NULL],
      [KxMenuItem menuItem:@"财务与资本运营" image:nil target:nil action:NULL],
      [KxMenuItem menuItem:@"组织与人力资源" image:nil target:nil action:NULL],
	  [KxMenuItem menuItem:@"领导力" image:nil target:nil action:NULL],
	  [KxMenuItem menuItem:@"运营与供应链" image:nil target:nil action:NULL],
	  [KxMenuItem menuItem:@"其他" image:nil target:nil action:NULL],
	  [KxMenuItem menuItem:@"返回" image:nil target:self action:@selector(didClickBackButton)]
      ];
    
    [KxMenu showMenuInView:self.view fromRect:CGRectMake(272, iPhone5?524:524-88, 44, 44)
				 menuItems:menuItems];
}

@end
