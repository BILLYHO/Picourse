//
//  PiInfomationViewController.h
//  Picourse
//
//  Created by BILLY HO on 10/9/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PiInfomationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UIToolbar *infoToolBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;

@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *itemPerPage;
@property (strong, nonatomic) NSString *infoName;
@property (strong, nonatomic) NSArray *infoArr;
@end
