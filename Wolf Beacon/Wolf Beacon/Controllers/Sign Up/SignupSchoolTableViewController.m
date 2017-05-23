//
//  SignupSchoolTableViewController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 1/25/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import <IQDropDownTextField/IQDropDownTextField.h>

#import "SignupSchoolTableViewController.h"
#import "SignupTechnicalTableViewController.h"

#import "VLRLoginTextField.h"

@interface SignupSchoolTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet IQDropDownTextField *levelOfStudyField;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *majorField;
@property (weak, nonatomic) IBOutlet UITextField *schoolLastAttendedField;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *graduationDateField;


@end

@implementation SignupSchoolTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.levelOfStudyField.dropDownMode = IQDropDownModeTextPicker;
	self.levelOfStudyField.itemList = @[@"High school", @"Undergraduate", @"Graduate", @"Others"];
	self.levelOfStudyField.selectedItem = self.levelOfStudyField.itemList[0];
	
	// Major list picking or something
	self.majorField.dropDownMode = IQDropDownModeTextPicker;
	self.majorField.itemList = @[@"Computer Science", @"Electrical and Electronics", @"Information Techonlogy", @"Others"];
	self.majorField.selectedItem = self.majorField.itemList[0];
	
	self.graduationDateField.dropDownMode = IQDropDownModeDatePicker;
	self.graduationDateField.datePickerMode = UIDatePickerModeDate;
	self.graduationDateField.minimumDate = [NSDate dateWithTimeIntervalSince1970:86400 * 366 * 10];
	
	UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextAction:)];
	self.navigationItem.rightBarButtonItem = nextButton;
	
	self.title = @"School Details";

	
}

- (void)nextAction:(id)sender {
#ifndef SKIP_FIELD_CHECKS
	if (self.levelOfStudyField.selectedItem.length < 2) {
		SHOW_ALERT(@"Enter level of study to continue.");
		return;
	}
#endif
	SignupTechnicalTableViewController *sttvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignupTechnicalVC"];
	[self.navigationController pushViewController:sttvc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == self.levelOfStudyField) {
		[self.majorField becomeFirstResponder];
	} else if (textField == self.majorField) {
		[self.schoolLastAttendedField becomeFirstResponder];
	} else if (textField == self.schoolLastAttendedField) {
		[self.graduationDateField becomeFirstResponder];
	}
	return YES;
}


#pragma mark - Table view delegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
	return (indexPath.section == 2);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 2) {
		// present school picker
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
