//
//  Info.h
//  Picourse
//
//  Created by BILLY HO on 11/28/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Info : NSManagedObject

@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *company;
@property (nonatomic, retain) NSString *auther;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *content;

@end
