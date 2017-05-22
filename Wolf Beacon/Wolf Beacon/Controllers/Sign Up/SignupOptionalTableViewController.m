//
//  SignupOptionalTableViewController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/22/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import "SignupOptionalTableViewController.h"

@interface SignupOptionalTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *numberOfHackathonsField;
@property (weak, nonatomic) IBOutlet UITextView *motivationsField;
@property (weak, nonatomic) IBOutlet UITextField *sponsorsField;
@property (weak, nonatomic) IBOutlet UITextField *prizesField;


@end

@implementation SignupOptionalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Finish" style:UIBarButtonItemStyleDone target:self action:@selector(finishAction:)];
	self.navigationItem.rightBarButtonItem = nextButton;
	
	self.title = @"Previous Experience";
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
	return (indexPath.section > 1);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 2) {
		// Sponsers pickup
	} else if (indexPath.section == 3) {
		// Prizes pickup
	}
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == self.numberOfHackathonsField) {
		[self.motivationsField becomeFirstResponder];
	}
	return YES;
}

#pragma mark - Navigation

- (void)finishAction:(id)sender {
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	UITabBarController *tabBarVC = [storyboard instantiateInitialViewController];
	[self presentViewController:tabBarVC animated:YES completion:nil];
}

@end
