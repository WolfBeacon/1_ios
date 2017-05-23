//
//  SignupPersonalTableViewController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 1/25/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import <IQDropDownTextField/IQDropDownTextField.h>

#import "SignupPersonalTableViewController.h"
#import "SignupPersonal2TableViewController.h"

#import "VLRLoginTextField.h"

@interface SignupPersonalTableViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet VLRLoginTextField *nameField;
@property (weak, nonatomic) IBOutlet VLRLoginTextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *profileImageView;

@property (weak, nonatomic) IBOutlet IQDropDownTextField *dateOfBirthField;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *genderField;
@property (weak, nonatomic) IBOutlet VLRLoginTextField *phoneNumberField;


@end

@implementation SignupPersonalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.dateOfBirthField.dropDownMode = IQDropDownModeDatePicker;
	self.dateOfBirthField.date = [NSDate dateWithTimeIntervalSinceNow: -86400 * 5653]; 
	self.dateOfBirthField.maximumDate = self.dateOfBirthField.date;
	
	self.genderField.dropDownMode = IQDropDownModeTextPicker;
	self.genderField.itemList = @[@"Male", @"Female", @"Others"];
	self.genderField.selectedItem = self.genderField.itemList[0];
	
	self.title = @"Sign Up";
	
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.nameField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextAction:(id)sender {
#ifndef SKIP_FIELD_CHECKS
	if (self.nameField.text.length < 2) {
		SHOW_ALERT(@"Enter your name to continue.");
		return;
	}
	// Email validator here
	if (self.emailField.text.length < 2) {
		SHOW_ALERT(@"Enter a valid email to continue.");
	}
	// Add phone number validator here.
	if (self.phoneNumberField.text.length < 8) {
		SHOW_ALERT(@"Enter your phone number to continue.");
		return;
	}
#endif
	SignupPersonal2TableViewController *sstvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignupPersonal2VC"];
	[self.navigationController pushViewController:sstvc animated:YES];
}

- (IBAction)cancelAction:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)profileImagePickerAction:(id)sender {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Select source" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
	[alertController addAction:cancelAction];
	UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[self cameraAction:nil];
	}];
	UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"Photo gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[self photoGalleryAction:nil];
	}];
	[alertController addAction:actionOne];
	[alertController addAction:actionTwo];
	[self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Image picker

- (void)photoGalleryAction:(id)sender {
	UIImagePickerController *pick = [[UIImagePickerController alloc] init];
	pick.delegate = self;
	pick.allowsEditing = YES;
	pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[self presentViewController:pick animated:YES completion:NULL];
}

- (void)cameraAction:(id)sender {
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		UIImagePickerController *pick = [[UIImagePickerController alloc] init];
		pick.delegate = self;
		pick.allowsEditing = YES;
		pick.sourceType = UIImagePickerControllerSourceTypeCamera;
		[self presentViewController:pick animated:YES completion:NULL];
	} else {
		SHOW_ALERT_2(@"Error", @"Camera not found!");
	}
}

- (void)imagePickerController:(UIImagePickerController *)pick didFinishPickingMediaWithInfo:(NSDictionary *)info {
	UIImage *image = info[UIImagePickerControllerEditedImage];
	[self.profileImageView setImage:image forState:UIControlStateNormal];
//	NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
	// Upload the image
	[self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view delegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == self.nameField) {
		[self.emailField becomeFirstResponder];
	} else if (textField == self.emailField) {
		[self.genderField becomeFirstResponder];
	} else if (textField == self.genderField) {
		[self.phoneNumberField becomeFirstResponder];
	} else if (textField == self.phoneNumberField) {
		[self.dateOfBirthField becomeFirstResponder];
	}
	return YES;
}

@end
