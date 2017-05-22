//
//  RequestsManager.h
//  Wolf Beacon
//
//  Created by Avikant Saini on 1/24/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestsManager : NSObject

- (void)setToken:(NSString *)token;
- (void)setClientID:(NSString *)clientID;

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method forRoute:(NSString *)route paramaters:(NSDictionary *)parameters;

+ (RequestsManager *)sharedInstance;

@end
