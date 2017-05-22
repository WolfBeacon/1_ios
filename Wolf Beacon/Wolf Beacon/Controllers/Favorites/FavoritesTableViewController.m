//
//  FavoritesTableViewController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 11/10/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "DetailTableViewController.h"

#import "EventTableViewCell.h"

@interface FavoritesTableViewController ()

@property (nonatomic) NSMutableArray *allEvents;

@end

@implementation FavoritesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.allEvents = [@[
						@{
							@"title"		: @"U of T Hackathon",
							@"subtitle"		: @"University of Toronto St. George Campus",
							@"image"		: @"hackathonbg.jpg",
							@"detail"		: @"4 years. More than 250 hackathons. More than 72 cities around the globe. We’ve seen it all. And from all of these events, we’ve noticed one thing: Anyone. Can. Code."
							},
						@{
							@"title"		: @"MIT Hackathon",
							@"subtitle"		: @"Massachusetts Institute of Technology",
							@"image"		: @"hackathonbg.jpg",
							@"detail"		: @"Let’s face it, prizes just make hackathons more fun. That’s why each year, we team up with our sponsors to bring you an awesome set of prizes."
							},
						@{
							@"title"		: @"Glasgow Hackathon",
							@"subtitle"		: @"University of Glasgow",
							@"image"		: @"hackathonbg.jpg",
							@"detail"		: @"Software Hackers and Hardware Makers, It's time to heat things Up!"
							},
						@{
							@"title"		: @"Braunschweig Hackathon",
							@"subtitle"		: @"Braunschweig University of Technology",
							@"image"		: @"hackathonbg.jpg",
							@"detail"		: @"For 2016, we’re excited for even bigger and better things! We’ll be hosting a Friday night kickoff to hear from our speaker panel, brainstorm possible tech solutions, pitch ideas, form teams, and figure out a game plan for your team. On Saturday, you’ll have 12 hours to build your prototype, receive feedback from mentors, present to our judges, and celebrate the 2016 winner!"
							}
						] mutableCopy];
	
	
	[self.tableView registerNib:[UINib nibWithNibName:@"EventTableViewCell" bundle:nil] forCellReuseIdentifier:@"eventCell"];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.allEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell" forIndexPath:indexPath];
	NSDictionary *dict = [self.allEvents objectAtIndex:indexPath.row];
	cell.titleLabel.text = dict[@"title"];
	cell.subtitleLabel.text = dict[@"subtitle"];
	cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"logo%li", indexPath.row]];
	cell.detailLabel.text = dict[@"detail"];
	return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == self.allEvents.count) {
		return 60.f;
	}
	return 100.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 4.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 4.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	UINavigationController *navC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailTableVCNav"];
	navC.transitioningDelegate = self;
	self.transistion.style = KWTransitionStyleUp;
	[self.navigationController presentViewController:navC animated:YES completion:nil];
}

@end
