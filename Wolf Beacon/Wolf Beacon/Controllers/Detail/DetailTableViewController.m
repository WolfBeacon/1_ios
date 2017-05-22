//
//  DetailTableViewController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 11/10/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import "DetailTableViewController.h"
#import "SignupPersonalTableViewController.h"

#import "DetailHeaderTableViewCell.h"
#import "DetailInformationTableViewCell.h"
#import "DetailCollectionTableViewCell.h"
#import "DetailCollectionViewCell.h"

@interface DetailTableViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic) NSMutableArray *facalitiesArray;
@property (nonatomic) NSMutableArray *sponsersArray;
@property (nonatomic) NSMutableArray *guestsArray;
@property (nonatomic) NSMutableArray *prizesArray;
@property (nonatomic) NSMutableArray *othersArray;
@property (nonatomic) NSMutableArray *linksArray;
@property (nonatomic) NSMutableArray *photosArray;

@property (nonatomic) NSString *hackathonText;
@property (nonatomic) NSString *hardwareText;
@property (nonatomic) NSString *travelText;

@end

@implementation DetailTableViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];

	UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
	self.tableView.tableFooterView = footerView;
	
	self.navigationItem.title = @"Details";
	
	self.hackathonText = @"A hackathon (also known as a hack day, hackfest or codefest) is an event in which computer programmers and others involved in software development, including graphic designers, interface designers and project managers, collaborate intensively on software projects. Occasionally, there is a hardware component as well. Hackathons typically last between a day and a week.\n\nSome hackathons are intended simply for educational or social purposes, although in many cases the goal is to create usable software. Hackathons tend to have a specific focus, which can include the programming language used, the operating system, an application, an API, or the subject and the demographic group of the programmers. In other cases, there is no restriction on the type of software being created.";
	
	self.hardwareText = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
	
	self.travelText = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
	
	
	self.facalitiesArray = [NSMutableArray arrayWithObjects:@"Travel reimbruishment", @"Bus route supported", nil];
	
	self.sponsersArray = [NSMutableArray arrayWithArray:@[
		@{@"title": @"Legatum Center for Development & Entrepreneurship", @"imageName": @"sponser1.jpg"},
		@{@"title": @"Lemelson-MIT Program", @"imageName": @"sponser2.png"},
		@{@"title": @"Department of C & E", @"imageName": @"sponser3.png"},
		@{@"title": @"Department of Mechanical Engg", @"imageName": @"sponser4.jpg"}
		]
						  ];
	
	self.guestsArray = [NSMutableArray arrayWithArray:@[
														@{@"title": @"Maurice Moss",@"imageName": @"moss.jpg"},
														@{@"title": @"Bertram Gilfoyle",@"imageName": @"gilfoyle.jpg"},
														@{@"title": @"Harvey Specter",@"imageName": @"harvey.jpg"},
														@{@"title": @"The Doctor",@"imageName": @"doctor.jpg"}
														]];
	
	self.prizesArray = [NSMutableArray arrayWithArray:@[
														@{@"title": @"Prize 1A", @"imageName": @"prize1.jpg"},
														@{@"title": @"Prize 1B", @"imageName": @"prize2.jpg"},
														@{@"title": @"Prize 2A", @"imageName": @"prize3.jpg"},
														@{@"title": @"Prize 2B", @"imageName": @"prize4.jpg"},
														@{@"title": @"Prize 3A", @"imageName": @"prize5.jpg"},
														@{@"title": @"Prize 3B", @"imageName": @"prize6.jpg"},
														@{@"title": @"Prize 4A", @"imageName": @"prize7.jpg"},
														@{@"title": @"Prize 4B", @"imageName": @"prize8.jpg"}
														]];
	
	self.othersArray = [NSMutableArray arrayWithArray:@[
														@{@"title": @"Hardware", @"text": self.hardwareText},
														@{@"title": @"Travel Reimbursement", @"text": self.travelText}
														]];
	
	self.linksArray = [NSMutableArray arrayWithArray:@[
													   @{@"title": @"facebook/uofthon", @"url": @"https://facebook.com/uofthon", @"icon": @"fa-facebook"},
													   @{@"title": @"twitter/uofthon", @"url": @"https://twitter.com/uofthon", @"icon": @"fa-twitter"},
													   @{@"title": @"GitHub/uofthon", @"url": @"https://github.com/uofthon", @"icon": @"fa-github"},
													   @{@"title": @"wolfbeacon.com/uofthon", @"url": @"https://wolfbeacon.com/uofthon", @"icon": @"fa-rss"}
													   ]];
	
	self.photosArray = [NSMutableArray arrayWithArray:@[
														@{@"title": @"", @"imageName": @"mitcampus.jpg"},
														@{@"title": @"", @"imageName": @"hackathon1.jpg"},
														@{@"title": @"", @"imageName": @"hackathon2.jpg"},
														@{@"title": @"", @"imageName": @"mitcampus.jpg"}
														]];
	
	[self.tableView registerNib:[UINib nibWithNibName:@"DetailHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"headerCell"];
	[self.tableView registerNib:[UINib nibWithNibName:@"DetailFacilitiesTableViewCell" bundle:nil] forCellReuseIdentifier:@"facilitiesCell"];
	[self.tableView registerNib:[UINib nibWithNibName:@"DetailInformationTableViewCell" bundle:nil] forCellReuseIdentifier:@"informationCell"];
	[self.tableView registerNib:[UINib nibWithNibName:@"DetailCollectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"photosCell"];
	[self.tableView registerNib:[UINib nibWithNibName:@"DetailCollectionTableViewCell2" bundle:nil] forCellReuseIdentifier:@"sponsersCell"];
	
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case 0: return 1 + self.facalitiesArray.count;
		case 6: return self.othersArray.count;
		case 7: return self.linksArray.count;
		case 8: return 1;
		default: return 1;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Header section
	if (indexPath.section == 0) {
		if (indexPath.row == 0) {
			DetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell" forIndexPath:indexPath];
//			cell.fromDate = [[NSDate date] dateByAddingTimeInterval:-18000];
//			cell.toDate = [[NSDate date] dateByAddingTimeInterval:54000];
//			[cell setLocationText:@"Department of Civil and Environmental Engineering, Massachusetts Institute of Technology ❯"];
//			cell.logoImageView.image = [UIImage imageNamed:@"logo1.png"];
			cell.hackathon = self.hackathon;
			[cell.applyButton addTarget:self action:@selector(applyAction:) forControlEvents:UIControlEventTouchUpInside];
			return cell;
		}
		else {
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"facilitiesCell" forIndexPath: indexPath];
			cell.textLabel.text = self.facalitiesArray[indexPath.row - 1];
			cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", (indexPath.row == 1) ? @"travel": @"money"]];
			return cell;
		}
	}
	
	// Event Information
	else if (indexPath.section == 1) {
		DetailInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"informationCell" forIndexPath:indexPath];
		cell.titleLabel.text = @"Event Information";
		cell.detailText = self.hackathonText;
		return cell;
	}
	
	// Maps, Sponsers, Prizes, and Guest Speakers
	else if (indexPath.section >= 2 && indexPath.section <= 5) {
		DetailCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photosCell" forIndexPath:indexPath];
		if (indexPath.section == 2) { cell.titleLabel.text = @"Indoor Maps"; }
		else if (indexPath.section == 3) { cell.titleLabel.text = @"Sponsers"; }
		else if (indexPath.section == 4) { cell.titleLabel.text = @"Prizes"; }
		else if (indexPath.section == 5) { cell.titleLabel.text = @"Guest Speakers"; }
		return cell;
	}
	
	// Other stuff
	else if (indexPath.section == 6) {
		DetailInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"informationCell" forIndexPath:indexPath];
		cell.titleLabel.text = [[self.othersArray objectAtIndex:indexPath.row] objectForKey:@"title"];
		cell.detailText = [[self.othersArray objectAtIndex:indexPath.row] objectForKey:@"text"];
		return cell;
	}
	
	else if (indexPath.section == 7) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"miscCell" forIndexPath: indexPath];
		cell.textLabel.text = [[self.linksArray objectAtIndex:indexPath.row] objectForKey:@"title"];
		return cell;
	}
	
	else if (indexPath.section == 8) {
		
	}
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell" forIndexPath:indexPath];
	return cell;

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([cell isKindOfClass:[DetailCollectionTableViewCell class]]) {
		DetailCollectionTableViewCell *dcell = (DetailCollectionTableViewCell *)cell;
		[dcell setCollectionViewDataSourceDelegate:self forRow:indexPath.section];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.section) {
		case 0:
			if (indexPath.row == 0) return 172;
			else return 26;
		case 1:
			return [DetailInformationTableViewCell estimatedHeightForText:self.hackathonText];
		case 2:
			return (SWidth - 100) * 1.7778 + 46;
		case 3:
			return (SWidth/3 - 10) * 1.4 + 46;
		case 4:
			return (SWidth/3 - 10) * 3 + 12;
		case 5:
			return (SWidth/2.5 - 10) * 1.5 + 46;
		case 6:
			return [DetailInformationTableViewCell estimatedHeightForText:self.hackathonText];
		default:
			return 44;
	}
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 7 || indexPath.section == 8) {
		return YES;
	}
	return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (section == 7) return 40;
	return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if (section == 7) {
		UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWidth, 40)];
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 8, SWidth - 24, 24)];
		label.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
		label.text = @"Miscellaneous";
		[headerView addSubview:label];
		return headerView;
	}
	return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 4.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWidth, 4)];
	footerView.backgroundColor = UIColorFromRGBWithAlpha(0xececec, 1);
	return footerView;
}

#pragma mark - Targets 

#pragma mark - Navigation

- (IBAction)doneAction:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)applyAction:(id)sender {
	// Apply here
	// Check if user details are present or not.
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Apply" bundle:nil];
	UINavigationController *navc = [storyboard instantiateInitialViewController];
//	SignupPersonalTableViewController *sptvc = [navc.viewControllers firstObject];
	[self presentViewController:navc animated:YES completion:nil];
}

#pragma mark - Collection view datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	if (collectionView.tag == 2) return 3; // Maps
	else if (collectionView.tag == 3) return self.sponsersArray.count;	// Sponsers
	else if (collectionView.tag == 4) return self.prizesArray.count;	// Sponsers
	else if (collectionView.tag == 5) return self.guestsArray.count;	// Sponsers
	return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
	
	if (collectionView.tag == 2) {
		cell.titleLabel.hidden = YES;
		cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"map%li.jpg", indexPath.row]];
		cell.imageView.clipsToBounds = YES;
		return cell;
	}
	
	else if (collectionView.tag >= 3 && collectionView.tag <= 5) {
		NSDictionary *dsitem = nil;
		if (collectionView.tag == 3) dsitem = self.sponsersArray[indexPath.row];
		else if (collectionView.tag == 4) dsitem = self.prizesArray[indexPath.row];
		else if (collectionView.tag == 5) dsitem = self.guestsArray[indexPath.row];
		cell.titleLabel.hidden = NO;
		cell.titleLabel.text = dsitem[@"title"];
		cell.imageView.image = [UIImage imageNamed:dsitem[@"imageName"]];
		cell.imageView.clipsToBounds = YES;
		return cell;
	}
	
	return cell;
	
}

#pragma mark - Collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	if (collectionView.tag == 2) {
		
	} else if (collectionView.tag == 3) {
		
	}
}

#pragma mark - Collection view delegate flow layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	if (collectionView.tag == 2) { return CGSizeMake(SWidth - 100, (SWidth - 100) * 1.7778); }
	else if (collectionView.tag == 3) { return CGSizeMake(SWidth/3 - 10, (SWidth/3 - 30) * 1.4); }
	else if (collectionView.tag == 4) { return CGSizeMake(SWidth/3 - 10, (SWidth/3 - 30) * 1.5); }
	else if (collectionView.tag == 5) { return CGSizeMake(SWidth/2.5 - 10, (SWidth/2.5 - 30) * 1.5); }
	return CGSizeMake(SWidth/3 - 10, (SWidth/3 - 30) * 1.4);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
	if (collectionView.tag == 2) { return 30.f; }
	return 10.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	return 8.f;
}

@end
