//
//  PiCourseViewController.h
//  Picourse
//
//  Created by BILLY HO on 10/9/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PiCourseViewController : UIViewController

@property (strong, nonatomic) IBOutlet UICollectionView *piCollectionView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIToolbar *courseToolBar;

@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *itemPerPage;
@property (strong, nonatomic) NSString *courseName;
@property (strong, nonatomic) NSArray *courseArr;

@end
