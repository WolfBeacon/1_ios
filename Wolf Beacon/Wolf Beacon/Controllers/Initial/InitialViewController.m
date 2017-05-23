//
//  InitialViewController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/23/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import <Lock/Lock.h>
#import <SimpleKeychain/SimpleKeychain.h>

#import "InitialViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	A0Lock *lock = [AppDelegate sharedLock];
	
	A0SimpleKeychain *keychain = [A0SimpleKeychain keychainWithService:@"Auth0"];
	//	[keychain clearAll]; // When you want to log out.
	NSString *token = [keychain stringForKey:@"id_token"];
	if (token == nil) {
		SVHUD_HIDE;
		// User is not logged in
		[self presentLoginController];
		
	} else {
		// User already logged in
		A0APIClient *client = [lock apiClient];
		[client fetchNewIdTokenWithIdToken:token parameters:nil success:^(A0Token *token) {
			SVHUD_HIDE;
			// Store the new ID token in the Keychain
			[keychain setString:token.idToken forKey:@"id_token"];
			[[RequestsManager sharedInstance] setToken:token.idToken];
			
			// Check for input details
			[self checkOtherUserDetails];
			
		} failure:^(NSError *error) {
			SVHUD_HIDE;
			// Cleaning stored values since they are no longer valid
			[keychain clearAll];
			// id_token is no longer valid, Ask the user to login again.
			[self presentLoginController];
		}];
	}
}

- (void)presentLoginController {
	A0Lock *lock = [AppDelegate sharedLock];
	A0LockViewController *controller = [lock newLockViewController];
	controller.onAuthenticationBlock = ^(A0UserProfile *profile, A0Token *token) {
		
		NSLog(@"Authentication successful for user %@ %@ %@ %@ %@", profile.nickname, profile.name, profile.email, profile.userId, profile.picture);
		
		// Save to A0SimpleKeychain
		A0SimpleKeychain *keychain = [A0SimpleKeychain keychainWithService:@"Auth0"];
		[keychain setString:token.idToken forKey:@"id_token"];
		[keychain setString:token.refreshToken forKey:@"refresh_token"];
		[keychain setData:[NSKeyedArchiver archivedDataWithRootObject:profile] forKey:@"profile"];
		
		// And dismiss the ViewController
		[self dismissViewControllerAnimated:YES completion:nil];
		
		// Check for more details here
		
	};
	[self presentViewController:controller animated:YES completion:nil];
}

- (void)checkOtherUserDetails {
	// Check for dev profiles if present, cause that's the last thing included
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Apply" bundle:nil];
	UINavigationController *navc = [storyboard instantiateInitialViewController];
	[self presentViewController:navc animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
