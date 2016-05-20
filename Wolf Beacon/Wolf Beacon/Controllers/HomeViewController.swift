//
//  HomeViewController.swift
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/19/16.
//  Copyright © 2016 Open Source Hacking. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchControllerDelegate {
	
	@IBOutlet var searchBar: UISearchBar!
	
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var pageControl: UIPageControl!
	
	@IBOutlet weak var tableView: UITableView!
	
	@IBOutlet weak var filterControl: UISegmentedControl!
	
	@IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
	
	var featuredEvents: NSMutableArray = []
	var allEvents: NSMutableArray = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		allEvents = [
			[
				"title"		: "Cylon-a-thon",
				"subtitle"	: "Battlestar Galactica",
				"image"		: "bsg.jpg"
			],
			[
				"title"		: "Gravity Falls' Weird-a-thon",
				"subtitle"	: "Mystery Shack",
				"image"		: "falls.jpg"
			],
			[
				"title"		: "Minions' Steal-a-thon",
				"subtitle"	: "Gru's Top Secret Lair",
				"image"		: "minions.jpg"
			]
		]
		
		featuredEvents = NSMutableArray(array: allEvents)
		
		pageControl.hidden = featuredEvents.count > 12
		pageControl.numberOfPages = min(12, featuredEvents.count)
		
		setupNavigationItems()
		setupSegmentedControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	// MARK: - Utility
	
	func setupNavigationItems() -> Void {
		self.navigationItem.titleView = self.searchBar
	}
	
	func setupSegmentedControl() -> Void {
		let height = self.filterControl.bounds.size.height
		let separatorImage = blankImageWithSize(CGSizeMake(4.0, height))
		let selectedImage = underlinedImageWithSize(CGSizeMake(height, height), tintColor: filterControl.tintColor, thickness: 2.0, fill: 0.8)
		
		filterControl.setDividerImage(separatorImage, forLeftSegmentState: .Normal, rightSegmentState: .Normal, barMetrics: .Default)
		filterControl.setDividerImage(separatorImage, forLeftSegmentState: .Selected, rightSegmentState: .Normal, barMetrics: .Default)
		filterControl.setDividerImage(separatorImage, forLeftSegmentState: .Normal, rightSegmentState: .Selected, barMetrics: .Default)
		filterControl.setBackgroundImage(separatorImage, forState: .Normal, barMetrics: .Default)
		filterControl.setBackgroundImage(selectedImage, forState: .Selected, barMetrics: .Default)
		
		let bgView = self.filterControl.superview as UIView!
		bgView.layer.shadowPath = UIBezierPath(rect :CGRectMake(0, bgView.bounds.size.height - 1, bgView.bounds.size.width, 1)).CGPath
		bgView.layer.masksToBounds = false;
		bgView.layer.shadowOffset = CGSizeMake(0, 0);
		bgView.layer.shadowRadius = 2.0;
		bgView.layer.shadowOpacity = 1.0;
	}
	
	// MARK: - Table view data source
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return allEvents.count + 1
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if (indexPath.row < allEvents.count) {
			let cell: EventTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! EventTableViewCell
			let dict = allEvents[indexPath.row] as! NSDictionary
			cell.titleLabel.text = dict.objectForKey("title") as? String
			cell.subtitleLabel.text = dict.objectForKey("subtitle") as? String
			cell.iconImageView.image = UIImage(named: "me gusta.png")
			return cell
		}
		else {
			let cell = tableView.dequeueReusableCellWithIdentifier("eorCell", forIndexPath: indexPath)
			cell.textLabel?.text = "END OF RESULTS.\nLOAD MORE."
			return cell
		}
	}
	
	// MARK: - Table view delegate

	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		if (indexPath.row == allEvents.count) {
			return 60
		}
		return 100
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if (indexPath.row == allEvents.count) {
			// Fetch and append more results
		}
		// Select from all events (filtered)
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	
	// MARK: - Collection view data source
	
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return featuredEvents.count
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! FeaturedCollectionViewCell
		let dict = featuredEvents[indexPath.row] as! NSDictionary
		cell.imageView.image = UIImage(named: (dict.objectForKey("image") as! String))
		cell.titleLabel.text = dict.objectForKey("title") as? String
		cell.subtitleLabel.text = dict.objectForKey("subtitle") as? String
		return cell
	}
	
	// MARK: - Collection view delegate
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		// Select from featured events
	}
	
	func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
		pageControl.currentPage = indexPath.row
	}
	
	// MARK: - Collection view delegate flow layout
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return collectionView.frame.size
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
		return 0
	}
	
	// MARK: - Search bar delegate
	
	func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
		// Filter
	}
	
	func searchBarCancelButtonClicked(searchBar: UISearchBar) {
		self.view.layoutIfNeeded()
		UIView.animateWithDuration(0.3) {
			self.collectionViewHeightConstraint.constant = 244
			self.view.layoutIfNeeded()
		}
		searchBar.showsCancelButton = false
		searchBar.text = ""
		self.searchBarTextDidEndEditing(searchBar)
	}
	
	func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
		searchBar.showsCancelButton = true
		self.view.layoutIfNeeded()
		UIView.animateWithDuration(0.3) { 
			self.collectionViewHeightConstraint.constant = 64
			self.view.layoutIfNeeded()
		}
		return true
	}
	
	func searchBarTextDidEndEditing(searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
	
	// MARK: - Scroll view delegate
	
	func scrollViewWillBeginDragging(scrollView: UIScrollView) {
		self.view.endEditing(true)
		searchBar.resignFirstResponder()
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
