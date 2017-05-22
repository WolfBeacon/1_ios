//
//  ProfileTableViewController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 11/17/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import <SimpleKeychain/SimpleKeychain.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "ProfileTableViewController.h"

#import "AppDelegate.h"

@interface ProfileTableViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *personNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailAddressLabel;


@end

@implementation ProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	A0SimpleKeychain *keychain = [A0SimpleKeychain keychainWithService:@"Auth0"];
	A0UserProfile *profile = [NSKeyedUnarchiver unarchiveObjectWithData:[keychain dataForKey:@"profile"]];
	self.personNameLabel.text = [NSString stringWithFormat:@"%@ %@", profile.name, (profile.nickname.length > 0) ? [NSString stringWithFormat:@"(%@)", profile.nickname] : @""];
	self.emailAddressLabel.text = profile.email;
	[self.profileImageView sd_setImageWithURL:profile.picture];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutAction:(id)sender {
	
}


#pragma mark - Table view delegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		[UIView animateWithDuration:0.3 animations:^{
			self.profileImageView.alpha = 0.7;
		}];
	}
	return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		[UIView animateWithDuration:0.3 animations:^{
			self.profileImageView.alpha = 1.0;
		}];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.section == 0) {
		// Profile clicked
	}
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
