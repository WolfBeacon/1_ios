//
//  SettingsTableViewController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 11/15/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *eventWorkshopsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *mainEventsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *announcementsSwitch;


@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchToggled:(UISwitch *)sender {
	
	if (sender == self.eventWorkshopsSwitch) {
		
	} else if (sender == self.mainEventsSwitch) {
		
	} else if (sender == self.announcementsSwitch) {
		
	}
	
}


@end
