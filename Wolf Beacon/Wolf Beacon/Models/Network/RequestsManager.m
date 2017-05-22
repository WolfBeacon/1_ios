//
//  RequestsManager.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 1/24/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import "RequestsManager.h"

@interface RequestsManager ()

@property (nonatomic, strong) NSString *authToken;
@property (nonatomic, strong) NSString *clientID;

@property (nonatomic, strong) AFHTTPRequestSerializer *serializer;

@end

@implementation RequestsManager

- (void)setClientID:(NSString *)clientID {
	self.clientID = clientID;
}

- (void)setToken:(NSString *)token {
	self.authToken = token;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method forRoute:(NSString *)route paramaters:(NSDictionary *)parameters {
	NSString *URLString = [NSString stringWithFormat:@"http://api.wolfbeacon.com/v1/%@", route];
	NSMutableURLRequest *request = [self.serializer requestWithMethod:method URLString:URLString parameters:parameters error:nil];
	[request setValue:[NSString stringWithFormat:@"Bearer %@", self.authToken] forHTTPHeaderField:@"Authorization"];
	return request;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		self.serializer = [AFHTTPRequestSerializer serializer];
	}
	return self;
}

+ (RequestsManager *)sharedInstance {
	static RequestsManager *manager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		manager = [[RequestsManager alloc] init];
	});
	return manager;
}

@end
