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
#import "LoginViewController.h"

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
	
	if (token != nil) {
		// There is a token stored
		SVHUD_HIDE;
		[lock.apiClient fetchUserProfileWithIdToken:[keychain stringForKey:@"id_token"]
											success:^(A0UserProfile * _Nonnull profile) {
											 // You have successfully retrieved the user's profile, you don't need to sign in again.
											 // Let your user continue to the next step
												NSLog(@"Logged in already.");
												[self checkOtherUserDetails];
											} failure:^(NSError * _Nonnull error) {
											 // Something went wrong, let the user know
												SHOW_ALERT_2(@"Error", error.localizedDescription);
										 }
		 ];
	} else {
		if ([keychain stringForKey:@"refresh_token"]) {
			[lock.apiClient fetchNewIdTokenWithRefreshToken:[keychain stringForKey:@"refresh_token"] parameters:nil
													success:^(A0Token * _Nonnull token) {
														[self saveCredentials:token];
														// Save the new credentials and use them instead.
													} failure:^(NSError * _Nonnull error) {
														[keychain clearAll]; // The saved token is invalid, delete them all from the keychain
														// Something went wrong, let the user know
														SHOW_ALERT_2(@"Expired", @"Your login has expired, you need to login again.");
														[self presentLoginController];
													}];
		} else {
			[self presentLoginController];
		}
	}
	
}

- (void)saveCredentials:(A0Token *)token {
	A0SimpleKeychain *keychain = [[A0SimpleKeychain alloc] initWithService:@"Auth0"];
	[keychain setString:token.idToken forKey:@"id_token"];
	[keychain setString:token.refreshToken forKey:@"refresh_token"];
}

- (void)presentLoginController {
	
	LoginViewController *lvc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
	[self presentViewController:lvc animated:YES completion:nil];
	
	/*
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
	 */
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
