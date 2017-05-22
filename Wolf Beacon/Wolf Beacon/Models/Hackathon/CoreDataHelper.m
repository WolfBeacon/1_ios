//
//  CoreDataHelper.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 2/22/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper

+ (Hackathon *)createNewHackathonWithDict:(NSDictionary *)dict inEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
	
	Hackathon *hackathon = [NSEntityDescription insertNewObjectForEntityForName:@"Hackathon" inManagedObjectContext:context];
	
	if (dict != nil) {
		
		@try {
			
			NSDateFormatter *dateFormatter = [NSDateFormatter new];
			[dateFormatter setDateFormat:@"yyyy-mm-dd"];
			
			NSDateFormatter *lastUpdateFormatter = [NSDateFormatter new];
			[lastUpdateFormatter setDateFormat:@"yyyy-mm-dd'T'hh:MM:ss.AAAzzzz"];
			
			hackathon.identifier = [[dict objectForKey:@"id"] intValue];
			
			hackathon.name = [dict objectForKey:@"title"];
			
			hackathon.cost = [dict objectForKey:@"cost"];
			
			hackathon.endDate = [dateFormatter dateFromString:[dict objectForKey:@"endDate"]];
			hackathon.startDate = [dateFormatter dateFromString:[dict objectForKey:@"startDate"]];
			
			hackathon.year = [[dict objectForKey:@"year"] integerValue];
			
			hackathon.highSchoolers = [[dict objectForKey:@"highSchoolers"] boolValue];
			
			hackathon.prize = [[dict objectForKey:@"prize"] boolValue];
			
			hackathon.lastUpdatedDate = [lastUpdateFormatter dateFromString:[dict objectForKey:@"lastUpdatedDate"]];
			
			hackathon.latitude = [[dict objectForKey:@"latitude"] doubleValue];
			hackathon.longitude = [[dict objectForKey:@"longitude"] doubleValue];
			hackathon.location = [dict objectForKey:@"location"];
			
			hackathon.length = [[dict objectForKey:@"length"] integerValue];
			
			hackathon.travel = [[dict objectForKey:@"travel"] boolValue];
			
			hackathon.size = [dict objectForKey:@"size"];
			
			hackathon.host = [dict objectForKey:@"host"];
			
			hackathon.eventLink = [dict objectForKey:@"eventLink"];
			hackathon.facebookLink = [dict objectForKey:@"facebookLink"];
			hackathon.googlePlusLink = [dict objectForKey:@"googlePlusLink"];
			hackathon.twitterLink = [dict objectForKey:@"twitterLink"];
			hackathon.imageLink = [dict objectForKey:@"imageLink"];
			
			
			
		} @catch (NSException *exception) {
			NSLog(@"Exception: %@", exception.reason);
		}
		
	}
	
	return hackathon;
	
}


+ (NSMutableArray<Hackathon *> *)getHackathonsFromJSONData:(id)data storeIntoManagedObjectContext:(NSManagedObjectContext *)context {
	
	NSMutableArray <Hackathon *> *hackathons = [NSMutableArray new];
	
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hackathon"];
	NSError *error;
	NSArray *fetchedHackathons = [context executeFetchRequest:request error:&error];
	if (error) {
		NSLog(@"Error in fetching: %@", error.localizedDescription);
	}
	
	for (NSDictionary *dict in data) {
		
		NSString *identifier;
		
		@try {
			identifier = [dict objectForKey:@"id"];
		} @catch (NSException *exception) {
			NSLog(@"Exception: %@", exception.description);
			continue;
			
		}
		Hackathon *hackathon = [[fetchedHackathons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"identifier == %@", identifier]] firstObject];
		
		if (hackathon != nil ) {
			// Update existing
			
			NSLog(@"Updating existsing %@", identifier);
			
			@try {
				
				NSDateFormatter *dateFormatter = [NSDateFormatter new];
				[dateFormatter setDateFormat:@"yyyy-mm-dd"];
				
				NSDateFormatter *lastUpdateFormatter = [NSDateFormatter new];
				[lastUpdateFormatter setDateFormat:@"yyyy-mm-dd'T'hh:MM:ss.AAAzzzz"];
				
				hackathon.name = [dict objectForKey:@"title"];
				
				hackathon.cost = [dict objectForKey:@"cost"];
				
				hackathon.endDate = [dateFormatter dateFromString:[dict objectForKey:@"endDate"]];
				hackathon.startDate = [dateFormatter dateFromString:[dict objectForKey:@"startDate"]];
				
				hackathon.year = [[dict objectForKey:@"year"] integerValue];
				
				hackathon.highSchoolers = [[dict objectForKey:@"highSchoolers"] boolValue];
				
				hackathon.prize = [[dict objectForKey:@"prize"] boolValue];
				
				hackathon.lastUpdatedDate = [lastUpdateFormatter dateFromString:[dict objectForKey:@"lastUpdatedDate"]];
				
				hackathon.latitude = [[dict objectForKey:@"latitude"] doubleValue];
				hackathon.longitude = [[dict objectForKey:@"longitude"] doubleValue];
				hackathon.location = [dict objectForKey:@"location"];
				
				hackathon.length = [[dict objectForKey:@"length"] integerValue];
				
				hackathon.travel = [[dict objectForKey:@"travel"] boolValue];
				
				hackathon.size = [dict objectForKey:@"size"];
				
				hackathon.host = [dict objectForKey:@"host"];
				
				hackathon.eventLink = [dict objectForKey:@"eventLink"];
				hackathon.facebookLink = [dict objectForKey:@"facebookLink"];
				hackathon.googlePlusLink = [dict objectForKey:@"googlePlusLink"];
				hackathon.twitterLink = [dict objectForKey:@"twitterLink"];
				hackathon.imageLink = [dict objectForKey:@"imageLink"];
				
			}
			@catch (NSException *exception) {
				NSLog(@"Exception: %@", exception.description);
			}
			
		} else {
			// Insert
			
			NSLog(@"Updating existsing %@", identifier);
			
			[CoreDataHelper createNewHackathonWithDict:dict inEntity:[NSEntityDescription entityForName:@"Hackathon" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
			
		}
		
	}
	
	hackathons = [[context executeFetchRequest:request error:&error] mutableCopy];
	if (error) {
		NSLog(@"Error in fetching: %@", error.localizedDescription);
	}
	
	return hackathons;
	
}


@end
