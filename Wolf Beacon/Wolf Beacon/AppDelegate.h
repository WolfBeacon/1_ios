//
//  AppDelegate.h
//  Wolf Beacon
//
//  Created by Avikant Saini on 10/26/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Lock/Lock.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, strong) A0Lock *lock;

- (void)saveContext;

+ (A0Lock *)sharedLock;

+ (NSPersistentContainer *)sharedPersistentContainer;
+ (NSManagedObjectContext *)sharedManagedObjectContext;

@end

