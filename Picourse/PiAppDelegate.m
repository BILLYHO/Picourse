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

#import "Favourite.h"

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
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.delegate = self;
	[self.window setRootViewController:frostedViewController];
	
	//[self addToDB];
	
    return YES;
}

- (void) addToDB
{
	NSLog(@"testing");
	
	Favourite *entry = (Favourite *)[NSEntityDescription insertNewObjectForEntityForName:@"Favourite" inManagedObjectContext:self.managedObjectContext];
	[entry setCategory:@"123"];
	[entry setCategoryNum:@"1"];
	[entry setIdentifier:@"lalala1"];
	[entry setImageUrl:@"default.png"];
	[entry setCompany:@"kkkk"];
	[entry setAuther:@"me"];
	
	Favourite *entry2 = (Favourite *)[NSEntityDescription insertNewObjectForEntityForName:@"Favourite" inManagedObjectContext:self.managedObjectContext];
	[entry2 setCategory:@"123"];
	[entry2 setCategoryNum:@"1"];
	[entry2 setIdentifier:@"lalala2"];
	[entry2 setImageUrl:@"\/picourse\/Public\/pic\/default.png"];
	[entry2 setCompany:@"kkkk"];
	[entry2 setAuther:@"me"];
	
	Favourite *entry3 = (Favourite *)[NSEntityDescription insertNewObjectForEntityForName:@"Favourite" inManagedObjectContext:self.managedObjectContext];
	[entry3 setCategory:@"123"];
	[entry3 setCategoryNum:@"1"];
	[entry3 setIdentifier:@"lalala3"];
	[entry3 setImageUrl:@"\/picourse\/Public\/pic\/default.png"];
	[entry3 setCompany:@"kkkk"];
	[entry3 setAuther:@"me"];
	
	NSError *error;
	if(![self.managedObjectContext save:&error])
		NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
	else
		NSLog(@"ok!");
}

- (NSArray *)getAllFavourite
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	
	//Setting Entity to be Queried
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favourite"
								inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setEntity:entity];
	NSError* error;
	
	// Query on managedObjectContext With Generated fetchRequest
	NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	
	// Returning Fetched Records
	return fetchedRecords;
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
