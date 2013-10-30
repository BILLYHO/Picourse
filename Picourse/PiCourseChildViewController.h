//
//  PiCourseChildViewController.h
//  Picourse
//
//  Created by BILLY HO on 10/10/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PiCourseChildViewController : UIViewController

@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) IBOutlet UICollectionView *piCollectionView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *labelOfImage;

@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSDictionary *courseInfo;
@end
