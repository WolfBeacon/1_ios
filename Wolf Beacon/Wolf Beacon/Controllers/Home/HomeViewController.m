//
//  HomeViewController.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 11/10/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import <Lock/Lock.h>
#import <SimpleKeychain/SimpleKeychain.h>

#import "HomeViewController.h"

#import "EventTableViewCell.h"
#import "EventCollectionViewCell.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

// List of recommended events
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// Inifintely scrolling featured events
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSMutableArray *featuredEvents;
@property (nonatomic) NSMutableArray *allEvents;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSFetchRequest *fetchRequest;

@end

@implementation HomeViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    // Do any additional setup after loading the view.
	
	SVHUD_SHOW;
	
	// Login logic to be moved to another controller
	A0Lock *lock = [AppDelegate sharedLock];
	
	A0SimpleKeychain *keychain = [A0SimpleKeychain keychainWithService:@"Auth0"];
//	[keychain clearAll]; // When you want to log out.
	NSString *token = [keychain stringForKey:@"id_token"];
	if (token == nil) {
		SVHUD_HIDE;
		[self presentLoginController];
		
	} else {
		A0APIClient *client = [lock apiClient];
		[client fetchNewIdTokenWithIdToken:token parameters:nil success:^(A0Token *token) {
			// Store the new ID token in the Keychain
			[keychain setString:token.idToken forKey:@"id_token"];
			[[RequestsManager sharedInstance] setToken:token.idToken];
			
			SVHUD_HIDE;
//			[self loadHackathons];
			
			
		} failure:^(NSError *error) {
			SVHUD_HIDE;
			[keychain clearAll]; // Cleaning stored values since they are no longer valid
			// id_token is no longer valid, Ask the user to login again.
			[self presentLoginController];
		}];
	}
	
	self.managedObjectContext = [AppDelegate sharedManagedObjectContext];
	self.fetchRequest = [Hackathon fetchRequest];
	
	NSError *error;
	self.allEvents = [[self.managedObjectContext executeFetchRequest:self.fetchRequest error:&error] mutableCopy];
	
	if (error == nil) {
		
	}
	
	self.featuredEvents = [self.allEvents mutableCopy];
	
	[self.tableView registerNib:[UINib nibWithNibName:@"EventTableViewCell" bundle:nil] forCellReuseIdentifier:@"eventCell"];
	[self.collectionView registerNib:[UINib nibWithNibName:@"EventCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"featuredCell"];
	
	self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
	
	self.navigationController.navigationBar.translucent = NO;
	
}

- (void)loadHackathons {
	// Ping request.
	
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
		
		NSError *error2;
		[self.managedObjectContext save:&error2];
		
		[self.tableView reloadData];
		
		SVHUD_HIDE;
		
	}];
	[task resume];
}

- (void)presentLoginController {
	A0Lock *lock = [AppDelegate sharedLock];
	A0LockViewController *controller = [lock newLockViewController];
	controller.onAuthenticationBlock = ^(A0UserProfile *profile, A0Token *token) {
		
		NSLog(@"Authentication successful for user %@ %@ %@ %@ %@", profile.nickname, profile.name, profile.email, profile.userId, profile.picture);
		
		// Save to A0SimpleKeychain
		A0SimpleKeychain *keychain = [A0SimpleKeychain keychainWithService:@"Auth0"];
		[keychain setString:token.idToken forKey:@"id_token"];
		[keychain setString:token.refreshToken forKey:@"refresh_token"];
		[keychain setData:[NSKeyedArchiver archivedDataWithRootObject:profile] forKey:@"profile"];
		
		// And dismiss the ViewController
		[self dismissViewControllerAnimated:YES completion:nil];
	};
	[self presentViewController:controller animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
//	[self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.featuredEvents.count * 50 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.allEvents.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row < self.allEvents.count) {
		EventTableViewCell *cell = (EventTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"eventCell" forIndexPath:indexPath];
//		NSDictionary *dict = [self.allEvents objectAtIndex:indexPath.row];
		Hackathon *hacx = [self.allEvents objectAtIndex:indexPath.row];
		cell.titleLabel.text = hacx.name;
		cell.subtitleLabel.text = [NSString stringWithFormat:@"%@ %@", hacx.host, hacx.location];
		[cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:hacx.imageLink]];
		cell.detailLabel.text = [NSString stringWithFormat:@"%@ - %@", hacx.startDate, hacx.endDate];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == self.allEvents.count) {
		// Fetch more results...
		return;
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	UINavigationController *navC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailTableVCNav"];
//	DetailTableViewController *detailVC = [navC.viewControllers firstObject];
	[self.navigationController presentViewController:navC animated:YES completion:nil];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 20.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 49.f;
}


#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//	return self.featuredEvents.count * 100; // No one is gonna scroll 50 times I guess...
	return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	EventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"featuredCell" forIndexPath:indexPath];
	
	NSDictionary *dict = [self.allEvents objectAtIndex:(indexPath.row % self.featuredEvents.count)];
	cell.titleLabel.text = dict[@"title"];
	cell.locationLabel.text = dict[@"subtitle"];
	cell.backgroundImageView.image = [UIImage imageNamed:dict[@"image"]];
	cell.layoutted = NO;
	
	return cell;
	
}


#pragma mark - Collection view delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	CGSize csize = self.collectionView.bounds.size;
	return CGSizeMake(csize.width - 8, csize.height - 8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
	return 8.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	return 8.f;
}

//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//	if (!((EventCollectionViewCell *)cell).layoutted) {
//		((EventCollectionViewCell *)cell).layoutted = YES;
//		[self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//	}
//}

//#pragma mark - Scroll view delegate
//
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//	if (scrollView == self.collectionView) {
//		NSArray <NSIndexPath *> *indexPaths = [self.collectionView indexPathsForVisibleItems];
//		NSIndexPath *indexPath;
//		if (indexPaths.count <= 1) {
//			indexPath = [indexPaths firstObject];
//		} else {
//			if (velocity.x < 0) {
//				indexPath = [indexPaths firstObject];
//			} else {
//				indexPath = [indexPaths lastObject];
//			}
//		}
//		[self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//	}
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
