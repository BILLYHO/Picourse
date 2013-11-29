//
//  PiCourseDetailViewController.h
//  Picourse
//
//  Created by BILLY HO on 10/10/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PiCourseDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *courseDetailWebView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *favouriteButton;

@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSString *titleName;
@property (nonatomic, retain) NSString *company;

@end
