//
//  PiFavouriteViewController.h
//  Picourse
//
//  Created by BILLY HO on 11/27/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface PiFavouriteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate >
@property (strong, nonatomic) IBOutlet UITableView *favouriteTableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segementBar;

@property (nonatomic, strong) NSArray *infoArray;
@property (nonatomic, strong) NSArray *courseArray;
@property (nonatomic, strong) NSMutableArray *record;

@end
