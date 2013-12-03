//
//  PiAppDelegate.m
//  Picourse
//
//  Created by BILLY HO on 10/8/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import "PiAppDelegate.h"
#import "PiMainViewController.h"
#import "PiNavigationController.h"
#import "PiMenuViewController.h"

#import "Info.h"
#import "Course.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation PiAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[self.window makeKeyAndVisible];
	PiMainViewController *mainView = [[PiMainViewController alloc]initWithNibName:@"PiMainViewController" bundle:nil];
	PiNavigationController *navigationView = [[PiNavigationController alloc] initWithRootViewController:mainView];
	
    PiMenuViewController *menuController = [[PiMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationView menuViewController:menuController];
    frostedViewController.direction = REFrostedViewControllerDirectionRight;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.delegate = self;
	[self.window setRootViewController:frostedViewController];
	
	[self addToDB];
	
    return YES;
}

- (void) addToDB
{
	Info *entry = (Info *)[NSEntityDescription insertNewObjectForEntityForName:@"Info" inManagedObjectContext:self.managedObjectContext];
	[entry setCategory:@"AcInfo"];
	[entry setIdentifier:@"1"];
	[entry setImageUrl:@"\/picourse\/Public\/pic\/default.png"];
	[entry setTitle:@"大笨象会跳舞"];
	[entry setContent:@"内容内容"];
	[entry setCompany:@"公司名称"];
	[entry setAuther:@"作者"];
	
	Course *entry2 = (Course *)[NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
	[entry2 setCategory:@"OpenCourse"];
	[entry2 setIdentifier:@"10"];
	[entry2 setTitle:@"服装行业专场沙龙"];
	[entry2 setCompany:@"华南理工大学管理学院"];
	
	NSError *error;
	if(![self.managedObjectContext save:&error])
		NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
	else
		NSLog(@"ok!");
}

- (NSArray *)getAllInfo
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Info"
								inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setEntity:entity];
	NSError* error;
	NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

	return fetchedRecords;
}

- (NSArray *)getAllCourse
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course"
								inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setEntity:entity];
	NSError* error;
	NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	
	return fetchedRecords;
}

- (void) saveData
{
	NSError *error;
	if(![self.managedObjectContext save:&error])
		NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
	else
		NSLog(@"Data saved!");
}

- (void) deleteItem : (NSManagedObject *) item
{
	[self.managedObjectContext deleteObject:item];
	[self saveData];
}

- (NSManagedObjectContext *) managedObjectContext
{
	if (_managedObjectContext != nil)
		return _managedObjectContext;

	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (coordinator != nil)
	{
		_managedObjectContext = [[NSManagedObjectContext alloc] init];
		[_managedObjectContext setPersistentStoreCoordinator: coordinator];
	}
	return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
	if (_managedObjectModel != nil)
		return _managedObjectModel;
	
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"picourse" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
	if (_persistentStoreCoordinator != nil)
		return _persistentStoreCoordinator;
	
	NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
											   stringByAppendingPathComponent: @"picourse.sqlite"]];
	NSError *error = nil;
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
								   initWithManagedObjectModel:[self managedObjectModel]];
	if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
												  configuration:nil URL:storeUrl options:nil error:&error]) {
		/*Error for store creation should be handled in here*/
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
	}
	
	return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory
{
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
