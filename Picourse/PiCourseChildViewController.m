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
		cell.nameLabel.text = [NSString stringWithFormat: @"page %d course %ld" ,self.index,(long)indexPath.row];
		cell.detailLabel.text = @"this is detail of the course";
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];
	PiCourseDetailViewController *detailview = [[PiCourseDetailViewController alloc] initWithNibName:@"PiCourseDetailViewController" bundle:nil];
	[self.navigationController pushViewController:detailview animated:YES];

}

@end
