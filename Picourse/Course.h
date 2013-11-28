//
//  Course.h
//  Picourse
//
//  Created by BILLY HO on 11/28/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Course : NSManagedObject

@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *company;

@end
