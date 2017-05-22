//
//  BBTableViewController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 2/25/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import "BBTableViewController.h"

@interface BBTableViewController ()

@end

@implementation BBTableViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	self.transistion = [KWTransition manager];
	self.transistion.style = KWTransitionStyleFadeBackOver;
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View controller animated transistioning

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
																   presentingController:(UIViewController *)presenting
																	   sourceController:(UIViewController *)source {
	self.transistion.action = KWTransitionStepPresent;
	return self.transistion;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
	self.transistion.action = KWTransitionStepDismiss;
	return self.transistion;
}

@end
