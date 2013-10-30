//
//  PiCourseChildViewController.m
//  Picourse
//
//  Created by BILLY HO on 10/10/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import "PiCourseChildViewController.h"
#import "PiCollectionCell.h"
#import "PiCourseDetailViewController.h"

#define base_url @"http://121.199.60.94/picourse/index.php/"

@interface PiCourseChildViewController ()

@end

@implementation PiCourseChildViewController

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
	[self.piCollectionView registerClass:[PiCollectionCell class] forCellWithReuseIdentifier:@"PiCollectionCell"];
    [self.piCollectionView setBackgroundColor:[UIColor whiteColor]];
    [self.imageView setImage:[UIImage imageNamed:@"ted.jpg"]];
    [self.labelOfImage setText:@"this is the detail of the picture"];
	
	#pragma mark - ImageView touch inside
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
											 initWithTarget:self action:@selector(ClickEventOnImage:)];
	[tapRecognizer setNumberOfTouchesRequired:1];
	[tapRecognizer setDelegate:self];
	//Don't forget to set the userInteractionEnabled to YES, by default It's NO.
	_imageView.userInteractionEnabled = YES;
	[_imageView addGestureRecognizer:tapRecognizer];
	
	int num = 0;
		if ([_category isEqualToString:@"OpenCourse"])
		{
			num = 8;
		}
		if ([_category isEqualToString:@"HighCourse"] || [_category isEqualToString:@"MidCourse"])
		{
			num = 6;
		}
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
	_courseInfo = [courseArr objectAtIndex:0];
	
}

-(void) ClickEventOnImage:(id) sender
{
	PiCourseDetailViewController *detailview = [[PiCourseDetailViewController alloc] initWithNibName:@"PiCourseDetailViewController" bundle:nil];
	[self.navigationController pushViewController:detailview animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Collection View Stuff
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //return the count of cells.
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	
    PiCollectionCell *cell = (PiCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PiCollectionCell" forIndexPath:indexPath];

//	int num = 0;
//	if ([_category isEqualToString:@"OpenCourse"])
//	{
//		num = 8 + indexPath.row;
//	}
//	if ([_category isEqualToString:@"HighCourse"] || [_category isEqualToString:@"MidCourse"])
//	{
//		num = 6 + indexPath.row;
//	}
//	
//    //fetch data from the server
//    NSError *error;
//    //加载一个NSURL对象
//    NSString *urlString = [base_url stringByAppendingString:
//						   [NSString stringWithFormat:@"%@/get%@ById/id/%d",_category,_category,num]];
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//    NSDictionary *courseDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//    NSArray *courseArr = [courseDic objectForKey:@"data"];
//	NSDictionary *courseInfo = [courseArr objectAtIndex:0];
    
    //cell.nameLabel.text = [NSString stringWithFormat: @"page %ld course %ld" ,self.index,(long)indexPath.row];
    //cell.detailLabel.text = @"this is detail of the course";
	cell.nameLabel.text = [NSString stringWithFormat:@"%@",[_courseInfo objectForKey:@"theme"]];
    cell.detailLabel.text = [NSString stringWithFormat:@"%@",[_courseInfo objectForKey:@"target"]];
    return cell;
	
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PiCollectionCell *selectedCell = (PiCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIView* selectedBGView = [[UIView alloc] init];
    selectedBGView.backgroundColor = [UIColor grayColor];
    selectedCell.selectedBackgroundView = selectedBGView;
	PiCourseDetailViewController *detailview = [[PiCourseDetailViewController alloc] initWithNibName:@"PiCourseDetailViewController" bundle:nil];
	[self.navigationController pushViewController:detailview animated:YES];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}



@end
