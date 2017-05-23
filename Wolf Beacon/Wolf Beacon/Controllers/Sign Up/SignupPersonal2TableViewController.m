//
//  SignupPersonal2TableViewController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/22/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import <IQDropDownTextField/IQDropDownTextField.h>

#import "SignupPersonal2TableViewController.h"
#import "SignupSchoolTableViewController.h"

#import "VLRLoginTextField.h"

@interface SignupPersonal2TableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet IQDropDownTextField *preferredCityField;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *tShirtSizeField;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *dietRestrictionsField;
@property (weak, nonatomic) IBOutlet VLRLoginTextField *specialNeedsField;

@property (nonatomic) NSMutableArray <NSString *> *cityList;

@end

@implementation SignupPersonal2TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.cityList = [NSMutableArray new];
	[self loadCityList];

	self.dietRestrictionsField.dropDownMode = IQDropDownModeTextPicker;
	self.dietRestrictionsField.itemList = @[@"None", @"Lactose Intolerant", @"Diabetic", @"Vegan", @"Alien"];
	self.dietRestrictionsField.selectedItem = self.dietRestrictionsField.itemList[0];
	
	self.tShirtSizeField.dropDownMode = IQDropDownModeTextPicker;
	self.tShirtSizeField.itemList = @[
									  @"XS (32\", 83cm)",
									  @"S (35\", 89cm)",
									  @"M (38\", 98cm)",
									  @"L (42\", 107cm)",
									  @"XL (44\", 112cm)",
									  @"XXL (47\", 120cm)",
									  
									  ];
	self.tShirtSizeField.selectedItem = self.dietRestrictionsField.itemList[0];
	
	UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextAction:)];
	self.navigationItem.rightBarButtonItem = nextButton;
	
}

- (void)loadCityList {
	self.cityList = [NSMutableArray arrayWithObjects:@"Los Santos", @"Liberty City", @"Gotham City", @"Metropolis", @"Hill Valley", @"Emerald City", @"Zion", nil];
	self.preferredCityField.itemList = self.cityList;
//	self.preferredCityField.selectedItem = self.cityList[0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == self.preferredCityField) {
		[self.tShirtSizeField becomeFirstResponder];
	} else if (textField == self.tShirtSizeField) {
		[self.dietRestrictionsField becomeFirstResponder];
	}
	return YES;
}

#pragma mark - Navigation

- (void)nextAction:(id)sender {
#ifndef SKIP_FIELD_CHECKS
	if (self.preferredCityField.selectedItem == nil) {
		SHOW_ALERT(@"Enter a preferred city to continue.");
		return;
	}
	if (self.tShirtSizeField.selectedItem == nil) {
		SHOW_ALERT(@"Please select your t-shirt size to continue.");
		return;
	}
	if (self.dietRestrictionsField.selectedItem == nil) {
		SHOW_ALERT(@"Please pick your dietary restrictions (None if applicable).");
		return;
	}
#endif
	SignupSchoolTableViewController *sstvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignupSchoolVC"];
	[self.navigationController pushViewController:sstvc animated:YES];
}

@end
