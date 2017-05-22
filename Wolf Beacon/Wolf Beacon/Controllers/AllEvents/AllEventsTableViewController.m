//
//  AllEventsTableViewController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 11/10/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import "AllEventsTableViewController.h"
#import "DetailTableViewController.h"

#import "EventTableViewCell.h"

@interface AllEventsTableViewController () <UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic) NSArray *allEvents;
@property (nonatomic) NSMutableArray *filteredEvents;

@property (nonatomic) UISearchController *searchController;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSFetchRequest *fetchRequest;

@property (nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation AllEventsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.allEvents = [NSMutableArray new];
	
	self.managedObjectContext = [AppDelegate sharedManagedObjectContext];
	self.fetchRequest = [Hackathon fetchRequest];
	
	NSError *error;
	self.allEvents = [self.managedObjectContext executeFetchRequest:self.fetchRequest error:&error];
	self.filteredEvents = [self.allEvents mutableCopy];
	
	[self.filteredEvents sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:NO]]];
	
	if (error == nil) {
		
	}
	
	self.dateFormatter = [NSDateFormatter new];
	[self.dateFormatter setDateFormat:@"MMM dd, hh:mm a"];

	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadHackathons:)];
	self.navigationItem.rightBarButtonItem = refreshButton;
	
	UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithTitle:@"Sort" style:UIBarButtonItemStyleDone target:self action:@selector(sortAction:)];
	self.navigationItem.leftBarButtonItem = sortButton;
	
	[self.tableView registerNib:[UINib nibWithNibName:@"EventTableViewCell" bundle:nil] forCellReuseIdentifier:@"eventCell"];
	
	self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
	self.searchController.searchResultsUpdater = self;
	self.searchController.searchBar.delegate = self;
	self.searchController.dimsBackgroundDuringPresentation = NO;

	
	self.tableView.tableHeaderView = self.searchController.searchBar;
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadHackathons:(id)sender {
	// Ping request.
	
	SVHUD_SHOW;
	
	NSMutableDictionary *params = [NSMutableDictionary new];
	[params setObject:@"2017-01-01" forKey:@"start-date"];
	[params setObject:@"2017-02-28" forKey:@"end-date"];
	[params setObject:@"distance" forKey:@"sort-by"];
	[params setObject:@"40.7127837" forKey:@"latitude"];
	[params setObject:@"74.00594130000002" forKey:@"longitude"];
	
	NSMutableURLRequest *request = [[RequestsManager sharedInstance] requestWithMethod:@"GET" forRoute:@"hackathon/list" paramaters:params];
	
	AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
		
		NSLog(@"%@ %@", response, responseObject);
		
		self.allEvents = [CoreDataHelper getHackathonsFromJSONData:responseObject storeIntoManagedObjectContext:self.managedObjectContext];
		self.filteredEvents = [self.allEvents mutableCopy];
		
		[self.filteredEvents sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:NO]]];
		
		NSError *error2;
		[self.managedObjectContext save:&error2];
		
		[self.tableView reloadData];
		
		SVHUD_HIDE;
		
	}];
	[task resume];
}

- (void)sortAction:(id)sender {
	
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sort" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	UIAlertAction *dateSort = [UIAlertAction actionWithTitle:@"Start Date" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[self.filteredEvents sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:NO]]];
		[self.tableView reloadData];
	}];
	[alertController addAction:dateSort];
	UIAlertAction *nameSort = [UIAlertAction actionWithTitle:@"Name" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[self.filteredEvents sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
		[self.tableView reloadData];
	}];
	[alertController addAction:nameSort];
	UIAlertAction *locationSort = [UIAlertAction actionWithTitle:@"Location" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[self.filteredEvents sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"location" ascending:YES]]];
		[self.tableView reloadData];
	}];
	[alertController addAction:locationSort];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
	[alertController addAction:cancelAction];
	[self presentViewController:alertController animated:YES completion:nil];
	
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.filteredEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row < self.filteredEvents.count) {
		EventTableViewCell *cell = (EventTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"eventCell" forIndexPath:indexPath];
		Hackathon *hacx = [self.filteredEvents objectAtIndex:indexPath.row];
		cell.titleLabel.text = hacx.name;
		cell.subtitleLabel.text = [NSString stringWithFormat:@"%@ %@", hacx.host, hacx.location];
		[cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:hacx.imageLink]];
		cell.detailLabel.text = [NSString stringWithFormat:@"%i %@ - %@", hacx.year, [self.dateFormatter stringFromDate:hacx.startDate], [self.dateFormatter stringFromDate:hacx.endDate]];
		return cell;
	} else {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eorCell" forIndexPath:indexPath];
		cell.textLabel.text = @"END OF RESULTS.\nLOAD MORE.";
		return cell;
	}
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
	DetailTableViewController *detailVC = navC.viewControllers.firstObject;
	detailVC.hackathon = [self.filteredEvents objectAtIndex:indexPath.row];
	[self.navigationController presentViewController:navC animated:YES completion:nil];
}

#pragma mark - Search controller delegate

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
	self.filteredEvents = [self.allEvents mutableCopy];
	if (searchController.searchBar.text.length > 0) {
		NSString *searchText = searchController.searchBar.text;
		[self.filteredEvents filterUsingPredicate:[NSPredicate predicateWithFormat:@"name contains[cd] %@ OR host contains[cd] %@ OR location contains[cd] %@", searchText, searchText, searchText]];
	} else {
		
	}
	[self.tableView reloadData];
}

@end
