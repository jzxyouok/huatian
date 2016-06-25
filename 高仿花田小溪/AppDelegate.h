//
//  AppDelegate.h
//  高仿花田小溪
//
//  Created by Lee on 16/6/23.
//  Copyright © 2016年 Lee. All rights reserved.
///Users/xiangyunchuangxiang/Desktop/高仿花田小溪/高仿花田小溪/Config/PrefixHeader.pch

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

