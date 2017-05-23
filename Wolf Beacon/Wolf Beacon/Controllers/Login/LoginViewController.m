//
//  LoginViewController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/23/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

@import Auth0;
@import SimpleKeychain;

#import "VLRLoginTextField.h"

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (nonatomic) A0AuthenticationAPI *authApi;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	 // Do any additional setup after loading the view.
	
	self.authApi = [[A0AuthenticationAPI alloc] init];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveCredentials:(A0Token *)token {
	A0SimpleKeychain *keychain = [[A0SimpleKeychain alloc] initWithService:@"Auth0"];
	[keychain setString:token.idToken forKey:@"id_token"];
	[keychain setString:token.refreshToken forKey:@"refresh_token"];
}

- (void)handleLoginWithCredentials:(A0Credentials *)creds {
	[self.authApi userInfoWithToken:creds.accessToken callback:^(NSError * _Nullable error, A0Profile * _Nullable profile) {
		if (error) {
			SHOW_ALERT_2(@"Error", error.localizedDescription);
 		} else {
			A0Token *token = [[A0Token alloc] initWithAccessToken:creds.accessToken idToken:creds.idToken tokenType:creds.tokenType refreshToken:creds.refreshToken];
			[self saveCredentials:token];
		}
	}];

}

- (IBAction)loginAction:(id)sender {
	[self.authApi loginWithUsernameOrEmail:self.emailField.text
							 password:self.passwordField.text
						   connection:@"Username-Password-Authentication"
								scope:@"openid"
						   parameters:@{}
							 callback:^(NSError * _Nullable error, A0Credentials * _Nullable creds) {
								 if (error) {
									 // Something went wrong, let the user know
									 SHOW_ALERT_2(@"Error", error.localizedDescription);
								 } else {
									 // Logged in successfully, you may continue
									 // Use the A0Credentials instance to access the user profile information
									 [self handleLoginWithCredentials:creds];
								 }
							 }];
}

#pragma mark - Social auth

- (IBAction)githubLoginAction:(id)sender {
	[self performSocialLoginWithProvider:@"github"];
}

- (IBAction)facebookLoginAction:(id)sender {
	[self performSocialLoginWithProvider:@"facebook"];
}

- (IBAction)googleLoginAction:(id)sender {
	[self performSocialLoginWithProvider:@"google"];
}

- (void)performSocialLoginWithProvider:(NSString *)provider {
	A0WebAuth *webAuth = [[A0WebAuth alloc] init];
	[webAuth setConnection:provider];
	[webAuth setScope:@"openid"];
	[webAuth start:^(NSError * _Nullable error, A0Credentials * _Nullable credentials) {
		if (error) {
			// Handle Error
			SHOW_ALERT_2(@"Error", error.localizedDescription);
		} else {
			// You've got your credentials
			[self handleLoginWithCredentials:credentials];
		}
	}];
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
