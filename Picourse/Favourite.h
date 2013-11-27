//
//  Favourite.h
//  Picourse
//
//  Created by BILLY HO on 11/27/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Favourite : NSManagedObject

@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *categoryNum;
@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSString *company;
@property (nonatomic, retain) NSString *auther;

@end
