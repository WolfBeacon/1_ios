//
//  SignupTechnicalTableViewController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/22/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import <IQDropDownTextField/IQDropDownTextField.h>
#import "VLRLoginTextField.h"

#import "SignupTechnicalTableViewController.h"
#import "SignupOptionalTableViewController.h"

@interface SignupTechnicalTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet VLRLoginTextField *githubField;
@property (weak, nonatomic) IBOutlet VLRLoginTextField *linkedinField;
@property (weak, nonatomic) IBOutlet VLRLoginTextField *websiteField;
@property (weak, nonatomic) IBOutlet VLRLoginTextField *devpostField;
@property (weak, nonatomic) IBOutlet VLRLoginTextField *otherField;

@property (weak, nonatomic) IBOutlet UITextField *reasonForAttendingField;
@property (weak, nonatomic) IBOutlet UITextField *technicalProficiencyField;
@property (weak, nonatomic) IBOutlet UITextField *technologyInterestedInField;

@end

@implementation SignupTechnicalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Technical details";
	
	UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextAction:)];
	self.navigationItem.rightBarButtonItem = nextButton;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
	return (indexPath.section > 0);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 1) {
		
	} else if (indexPath.section == 2) {
		
	} else if (indexPath.section == 3) {
		
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == self.githubField) {
		[self.linkedinField becomeFirstResponder];
	} else if (textField == self.linkedinField) {
		[self.websiteField becomeFirstResponder];
	} else if (textField == self.websiteField) {
		[self.devpostField becomeFirstResponder];
	} else if (textField == self.devpostField) {
		[self.otherField becomeFirstResponder];
	} 
	return YES;
}


#pragma mark - Navigation

- (void)nextAction:(id)sender {
#ifndef SKIP_FIELD_CHECKS
	NSArray <VLRLoginTextField *> *tfArray = @[self.githubField, self.linkedinField, self.websiteField, self.devpostField, self.otherField];
	BOOL atleastOneHasText = NO;
	for (VLRLoginTextField *tf in tfArray) {
		atleastOneHasText |= (tf.text.length > 2);
	}
	if (!atleastOneHasText) {
		SHOW_ALERT(@"Enter atleast one link to your profiles.");
		return;
	}
#endif
	SignupOptionalTableViewController *sotvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignupOptionalVC"];
	[self.navigationController pushViewController:sotvc animated:YES];
}

@end
