//
//  PiFeedbackViewController.h
//  Picourse
//
//  Created by BILLY HO on 10/9/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface PiFeedbackViewController : UIViewController<MBProgressHUDDelegate>

@property (strong, nonatomic) MBProgressHUD *HUD;

@end
