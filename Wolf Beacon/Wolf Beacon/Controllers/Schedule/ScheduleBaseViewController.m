//
//  ScheduleBaseViewController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 12/24/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import "ScheduleBaseViewController.h"
#import "ScheduleTableViewController.h"

@interface ScheduleBaseViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic) UIPageViewController *pageViewController;

@property (nonatomic) NSMutableArray <ScheduleTableViewController *> *controllers;

@end

@implementation ScheduleBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
															  navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
																			options:nil];
	self.pageViewController.dataSource = self;
	self.pageViewController.delegate = self;
	
	[self addChildViewController:self.pageViewController];
	
	self.controllers = [NSMutableArray new];
	for (NSInteger i = 0; i < 4; ++i) {
		ScheduleTableViewController *stvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ScheduleTableVC"];
		stvc.day = i;
		[self.controllers addObject:stvc];
	}
	
}

- (void)viewDidAppear:(BOOL)animated {
	
	[super viewDidAppear:animated];
	
	[self.containerView addSubview:self.pageViewController.view];
	[self.pageViewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
//	NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.pageViewController.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
//	NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.pageViewController.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
//	NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.pageViewController.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
//	[self.view addConstraints:@[top, bottom, width]];

	[self.pageViewController didMoveToParentViewController:self];
	
	[self.pageViewController setViewControllers:@[self.controllers.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Page view controller data source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
	NSInteger index = [self.controllers indexOfObject:(ScheduleTableViewController *)viewController];
	if (index != 0) {
		return [self.controllers objectAtIndex:index - 1];
	}
	return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
	NSInteger index = [self.controllers indexOfObject:(ScheduleTableViewController *)viewController];
	if (index != self.controllers.count - 1) {
		return [self.controllers objectAtIndex:index + 1];
	}
	return nil;
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
