//
//  PiCourseViewController.m
//  Picourse
//
//  Created by BILLY HO on 10/9/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

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

@interface PiCourseViewController ()

@end

@implementation PiCourseViewController


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
	_nameLabel.text = _courseName;
    _nameLabel.textColor = [UIColor whiteColor];
	
	_courseArr = [NSMutableArray arrayWithArray:[self loadDataAtPage:1]];
	[self.piCollectionView reloadData];
	
	[self.piCollectionView registerClass:[PiCollectionCell class] forCellWithReuseIdentifier:@"PiCollectionCell"];
	[self.piCollectionView registerClass:[PiBigCollectionCell class] forCellWithReuseIdentifier:@"PiBigCollectionCell"];
	[self.piCollectionView registerClass:[PiCourseLoadMoreCell class] forCellWithReuseIdentifier:@"PiCourseLoadMoreCell"];
	self.piCollectionView.backgroundColor = [UIColor whiteColor];
    _nameLabel.backgroundColor = aRGB(101, 186, 225, 1);//101	186	225
    _nameLabel.adjustsFontSizeToFitWidth = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Back Button
- (void)didClickBackButton
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
	NSDictionary *courseDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
	NSArray *courseArr = [courseDic objectForKey:@"data"];
	return courseArr;
}


#pragma mark - Collection View Stuff
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 2;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	if (section == 0)
	{
		if(_courseArr == nil)
			return 0;
		return [_courseArr count];
	}
	else
		return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	
	
	if(indexPath.section == 0 && indexPath.row % [_itemPerPage intValue] == 0)
	{
		PiBigCollectionCell *cell = (PiBigCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PiBigCollectionCell" forIndexPath:indexPath];
		
#warning TBD
		NSDictionary *courseInfo = [_courseArr objectAtIndex:indexPath.row];
        if([_category isEqualToString:@"AcInfo"])
        {
            cell.titleLabel.text = [courseInfo objectForKey:@"title"];
        }
        else
        {
            cell.titleLabel.text = [courseInfo objectForKey:@"theme"];
        }
		cell.titleLabel.textColor = [UIColor whiteColor];
		cell.compangLabel.text = [courseInfo objectForKey:@"agency_name"];
		cell.compangLabel.textColor = [UIColor whiteColor];
        cell.titleLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
		cell.compangLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
        cell.dateNplaceLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
        if([_category isEqualToString:@"OpenCourse"]||[_category isEqualToString:@"AcInfo"])
        {
            cell.dateNplaceLabel.text = [NSString stringWithFormat:@"%@",[courseInfo objectForKey:@"time"]];
            cell.dateNplaceLabel.text = [cell.dateNplaceLabel.text substringWithRange:NSMakeRange(0, 10)];
            cell.dateNplaceLabel.text = [NSString stringWithFormat:@"( %@ )",cell.dateNplaceLabel.text];
            cell.dateNplaceLabel.textColor = [UIColor whiteColor];
        }
        else
        {
            cell.dateNplaceLabel.text = [NSString stringWithFormat:@" "];
        }
		cell.photo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.199.60.94/%@",[courseInfo objectForKey: @"img_url"]]]]];
		[cell.layer setBorderColor:[UIColor colorWithRed:213.0/255.0f green:210.0/255.0f blue:199.0/255.0f alpha:1.0f].CGColor];
		[cell.layer setBorderWidth:1.0f];
		[cell.layer setShadowOffset:CGSizeMake(0, 1)];
		[cell.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
		[cell.layer setShadowRadius:8.0];
		[cell.layer setShadowOpacity:0.8];
		return cell;
		
	}
	else if(indexPath.section == 0)
	{
        NSDictionary *courseInfo = [_courseArr objectAtIndex: indexPath.row ];
		
		PiCollectionCell *cell = (PiCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PiCollectionCell" forIndexPath:indexPath];
		//cell.nameLabel.text = [NSString stringWithFormat:@"%@",[courseInfo objectForKey:@"theme"]];
		cell.dateNplaceLabel.hidden = YES;
		if([_category isEqualToString:@"AcInfo"])
		{
			cell.nameLabel.text = [courseInfo objectForKey:@"title"];
			cell.dateNplaceLabel.text =[NSString stringWithFormat:@"( %@",[courseInfo objectForKey:@"time"]];
			cell.dateNplaceLabel.text = [cell.dateNplaceLabel.text substringWithRange:NSMakeRange(0, 12)];
			cell.dateNplaceLabel.text = [NSString stringWithFormat:@"%@ )",cell.dateNplaceLabel.text];
			cell.dateNplaceLabel.hidden = NO;
		}
		else
		{
			cell.nameLabel.text = [courseInfo objectForKey:@"theme"];
		}
		//		cell.detailLabel.text = [NSString stringWithFormat:@"%@",[courseInfo objectForKey:@"target"]];
		cell.companyLabel.text = [NSString stringWithFormat:@"%@",[courseInfo objectForKey:@"agency_name"]];
		if([_category isEqualToString:@"OpenCourse"])
		{
			cell.dateNplaceLabel.text = [NSString stringWithFormat:@"%@",[courseInfo objectForKey:@"time"]];
			cell.dateNplaceLabel.text = [cell.dateNplaceLabel.text substringWithRange:NSMakeRange(0, 10)];
			NSString *place = [NSString stringWithFormat:@"%@",[courseInfo objectForKey:@"place"]];
			cell.dateNplaceLabel.text = [NSString stringWithFormat:@"( %@ %@ )",cell.dateNplaceLabel.text,place];
			cell.dateNplaceLabel.hidden = NO;
		}
        
		[cell.layer setBorderColor:[UIColor colorWithRed:213.0/255.0f green:210.0/255.0f blue:199.0/255.0f alpha:1.0f].CGColor];
		[cell.layer setBorderWidth:1.0f];
		[cell.layer setShadowOffset:CGSizeMake(0, 1)];
		[cell.layer setShadowColor:[[UIColor darkGrayColor] CGColor]];
		[cell.layer setShadowRadius:8.0];
		[cell.layer setShadowOpacity:0.8];
		return cell;
	}
	else
	{
		PiCourseLoadMoreCell *cell = (PiCourseLoadMoreCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PiCourseLoadMoreCell" forIndexPath:indexPath];
		return cell;
	}
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PiCollectionCell *selectedCell = (PiCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIView* selectedBGView = [[UIView alloc] init];
    selectedBGView.backgroundColor = [UIColor grayColor];
    selectedCell.selectedBackgroundView = selectedBGView;
	
	if (indexPath.section == 1 )
	{
		[collectionView deselectItemAtIndexPath:indexPath animated:YES];
		NSArray *newArr = [self loadDataAtPage:([_courseArr count]-1) / [_itemPerPage intValue] + 2];
		if(newArr != nil )
		{
			[_courseArr addObjectsFromArray:newArr];
			[collectionView reloadData];
		}
		else
		{
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"已经是最后了" message:@"O(∩_∩)O哈哈~" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
			[alert show];
		}
	}
	else
	{
		PiCourseDetailViewController *detailview = [[PiCourseDetailViewController alloc] initWithNibName:@"PiCourseDetailViewController" bundle:nil];
		[self.navigationController pushViewController:detailview animated:YES];
		[collectionView deselectItemAtIndexPath:indexPath animated:YES];
	}
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0 && indexPath.row % [_itemPerPage intValue] == 0)
		return CGSizeMake(320, 180);
	else if (indexPath.section == 0)
		return CGSizeMake(160, 90);
	else
		return CGSizeMake(320, 44);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
	return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
	return 0.0f;
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
	  [KxMenuItem menuItem:@"返回" image:nil target:self action:@selector(didClickBackButton)],
      ];
    
    [KxMenu showMenuInView:self.view fromRect:CGRectMake(264, iPhone5?524:524-88, 44, 44)
				 menuItems:menuItems];
}

@end
