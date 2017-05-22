//
//  CoreDataHelper.h
//  Wolf Beacon
//
//  Created by Avikant Saini on 2/22/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hackathon+CoreDataClass.h"

@interface CoreDataHelper : NSObject

+ (Hackathon *)createNewHackathonWithDict:(NSDictionary *)dict inEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSMutableArray <Hackathon *> *)getHackathonsFromJSONData:(id)data storeIntoManagedObjectContext:(NSManagedObjectContext *)context;

@end
