//
//  HomeViewController.swift
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/19/16.
//  Copyright © 2016 Open Source Hacking. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate {
	
	@IBOutlet var searchBar: UISearchBar!
	
	@IBOutlet weak var tableView: UITableView!
	
	var featuredEvents: NSMutableArray = []
	var allEvents: NSMutableArray = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		allEvents = [
			[
				"title"		: "U of T Hackathon",
				"subtitle"	: "University of Toronto St. George Campus",
				"image"		: "hackathonbg.jpg",
				"detail"	: "4 years. More than 250 hackathons. More than 72 cities around the globe. We’ve seen it all. And from all of these events, we’ve noticed one thing: Anyone. Can. Code."
			],
			[
				"title"		: "MIT Hackathon",
				"subtitle"	: "Massachusetts Institute of Technology",
				"image"		: "hackathonbg.jpg",
				"detail"	: "Let’s face it, prizes just make hackathons more fun. That’s why each year, we team up with our sponsors to bring you an awesome set of prizes."
			],
			[
				"title"		: "Glasgow Hackathon",
				"subtitle"	: "University of Glasgow",
				"image"		: "hackathonbg.jpg",
				"detail"	: "Software Hackers and Hardware Makers, It's time to heat things Up!"
			],
			[
				"title"		: "Braunschweig Hackathon",
				"subtitle"	: "Braunschweig University of Technology",
				"image"		: "hackathonbg.jpg",
				"detail"	: "For 2016, we’re excited for even bigger and better things! We’ll be hosting a Friday night kickoff to hear from our speaker panel, brainstorm possible tech solutions, pitch ideas, form teams, and figure out a game plan for your team. On Saturday, you’ll have 12 hours to build your prototype, receive feedback from mentors, present to our judges, and celebrate the 2016 winner!"
			]
		]
		
		tableView.registerNib(UINib.init(nibName: "EventTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "eventCell")
		
		featuredEvents = NSMutableArray(array: allEvents)
		
		setupNavigationItems()
		
		self.navigationController?.navigationBar.translucent = false
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	// MARK: - Utility
	
	func setupNavigationItems() -> Void {
		self.navigationItem.titleView = self.searchBar
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
			let cell: EventTableViewCell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventTableViewCell
			let dict = allEvents[indexPath.row] as! NSDictionary
			cell.titleLabel.text = dict.objectForKey("title") as? String
			cell.subtitleLabel.text = dict.objectForKey("subtitle") as? String
			cell.detailLabel.text = dict.objectForKey("detail") as? String
			cell.iconImageView.image = UIImage(named: "logo\(indexPath.row)")
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
		let navVC = self.storyboard?.instantiateViewControllerWithIdentifier("DetailTableVCNav") as! UINavigationController
//		let detailVC = navVC.viewControllers.first as! DetailTableViewController
		// Do stuff with detail
		self.navigationController?.presentViewController(navVC, animated: true, completion: nil)
	}
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return UIView()
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 20
	}
	
	func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return UIView()
	}
	
	func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 49
	}
	
	// MARK: - Search bar delegate
	
	func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
		// Filter
	}
	
	func searchBarCancelButtonClicked(searchBar: UISearchBar) {
		searchBar.showsCancelButton = false
		searchBar.text = ""
		self.searchBarTextDidEndEditing(searchBar)
	}
	
	func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
		searchBar.showsCancelButton = true
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
