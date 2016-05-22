//
//  DetailTableViewController.swift
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/21/16.
//  Copyright © 2016 Open Source Hacking. All rights reserved.
//

import UIKit
import FontAwesomeKit

class DetailTableViewController: UITableViewController, DetailCollectionTableViewCellDelegate {

	var headerImageView = UIImageView(frame: CGRectMake(0, 0, SWidth, SWidth/2))
	
	var facalitiesArray = NSMutableArray()
	var sponsersArray = NSMutableArray()
	var guestsArray = NSMutableArray()
	var prizesArray = NSMutableArray()
	var linksArray = NSMutableArray()
	
	var expandedSections: [Int] = [1, 1, 1, 1, 1, 1, 1, 1, 1]
	
    override func viewDidLoad() {
        super.viewDidLoad()

		// Header image
		headerImageView.image = UIImage(named: "me gusta")
		headerImageView.contentMode = .ScaleAspectFit
		self.tableView.tableHeaderView = headerImageView
		
		let footerView = UIView(frame: CGRectMake(0, 0, SWidth, 44))
//		footerView.backgroundColor = UIColor(red: 45/255, green: 102/255, blue: 13/255, alpha: 1)
		self.tableView.tableFooterView = footerView
		
		// Floating 'Apply' button
		let applyButtonView = UIView(frame: CGRectMake(0, SHeight - 44, SWidth, 44))
		applyButtonView.backgroundColor = UIColor.whiteColor()
		applyButtonView.layer.shadowPath = UIBezierPath(rect: CGRectMake(0, 0, SWidth, 1)).CGPath
		applyButtonView.layer.shadowOffset = CGSizeZero
		applyButtonView.layer.shadowOpacity = 1.0
		let applyButton = UIButton(frame: CGRectMake(0, 0, SWidth, 44))
		applyButton.setTitle("APPLY", forState: .Normal)
		applyButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
		applyButton.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
		applyButton.addTarget(self, action: #selector(DetailTableViewController.applyAction(_:)), forControlEvents: .TouchUpInside)
		applyButtonView.addSubview(applyButton)
		self.navigationController?.view.addSubview(applyButtonView)
		
		// Nav title
		self.navigationItem.title = "U of T Hackathon"
		
		facalitiesArray = NSMutableArray(array: ["Travel reimbruishment", "Bus route supported", "Free pizzas twice a day"])
		
		sponsersArray = NSMutableArray(array: CollectionDataSource.dataSourceFromJSONStructure(
			[
				["title": "Bruce", "imageName": "batman.jpg"],
				["title": "Clark", "imageName": "superman.jpg"],
				["title": "Diana", "imageName": "wonder.jpg"],
				["title": " Hal ", "imageName": "lantern.jpg"]
			]
		))

		guestsArray = NSMutableArray(array: CollectionDataSource.dataSourceFromJSONStructure(
			[
				["title": "Diana", "imageName": "wonder.jpg"],
				["title": "Bruce", "imageName": "batman.jpg"],
				["title": "Clark", "imageName": "superman.jpg"]
			]
		))
		
		prizesArray = NSMutableArray(array: CollectionDataSource.dataSourceFromJSONStructure(
			[
				["title": "Diana 1", "imageName": "wonder.jpg"],
				["title": "Hal 1", "imageName": "lantern.jpg"],
				["title": "Diana 2", "imageName": "wonder.jpg"],
				["title": "Hal 2", "imageName": "lantern.jpg"],
				["title": "Diana 3", "imageName": "wonder.jpg"],
				["title": "Hal 3", "imageName": "lantern.jpg"],
				["title": "Diana 4", "imageName": "wonder.jpg"],
				["title": "Hal 4", "imageName": "lantern.jpg"]
			]
		))
		
		linksArray = NSMutableArray(array:
			[
				["title": "facebook/uofthon", "url": "https://facebook.com/uofthon", "icon": "fa-facebook"],
				["title": "twitter/uofthon", "url": "https://twitter.com/uofthon", "icon": "fa-twitter"],
				["title": "GitHub/uofthon", "url": "https://github.com/uofthon", "icon": "fa-github"],
				["title": "wolfbeacon.com/uofthon", "url": "https://wolfbeacon.com/uofthon", "icon": "fa-rss"]
			]
		)
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Sections be like:
		// 0 - Header section, main information
		// 1 - Sponsers
		// 2 - Guest Speakers?
		// 3 - Prizes
		// 4 - Hardware?
		// 5 - Travel?
		// 6 - Photos
		// 7 - Misc
		// 8 - Apply?
        return 8
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
			case 0: return (1 + facalitiesArray.count) * expandedSections[section]
			case 1: return 1 * expandedSections[section]
			case 2: return 1 * expandedSections[section]
			case 3: return 1 * expandedSections[section]
			case 4: return 1 * expandedSections[section]
			case 5: return 1 * expandedSections[section]
			case 6: return 1 * expandedSections[section]
			case 7: return linksArray.count * expandedSections[section]
			case 8: return 1 * expandedSections[section]
			default: return 0
		}
	}
	
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		// Header section
		if (indexPath.section == 0) {
			if (indexPath.row == 0) {
				let cell = tableView.dequeueReusableCellWithIdentifier("headerCell", forIndexPath: indexPath) as! DetailHeaderTableViewCell
				cell.titleLabel.text = "U of T"
				cell.subtitleLabel.text = "hackathon"
				cell.locationButton.setTitle("University of Toronto, St. George Campus", forState: .Normal)
				cell.locationButton.addTarget(self, action: #selector(DetailTableViewController.didPressLocationButton(_:)), forControlEvents: .TouchUpInside)
				cell.favButton.addTarget(self, action: #selector(DetailTableViewController.favoriteAction(_:)), forControlEvents: .TouchUpInside)
				cell.fromDate = NSDate(timeIntervalSinceNow: 86400 * 2)
				cell.toDate = NSDate(timeIntervalSinceNow: 86400 * 3.6)
				cell.bottomSeparator = false
				cell.topSeparator = false
				cell.descriptionLabel.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
				return cell
			}
			else {
				let cell = tableView.dequeueReusableCellWithIdentifier("facilitiesCell", forIndexPath: indexPath) as! DetailFacilitiesTableViewCell
				cell.titleLabel.text = "\(facalitiesArray[indexPath.row - 1])"
				return cell
			}
		}
		
		// Sponsers
		else if (indexPath.section == 1) {
			let cell = tableView.dequeueReusableCellWithIdentifier("collectionCell", forIndexPath: indexPath) as! DetailCollectionTableViewCell
			cell.dataSource = sponsersArray
			cell.tag = indexPath.section
			cell.delegate = self
			cell.showsLabel = true
			cell.bottomSeparator = false
			cell.topSeparator = false
			return cell
		}
		
		// Guest Speakers
		else if (indexPath.section == 2) {
			let cell = tableView.dequeueReusableCellWithIdentifier("collectionCell", forIndexPath: indexPath) as! DetailCollectionTableViewCell
			cell.dataSource = guestsArray
			cell.tag = indexPath.section
			cell.delegate = self
			cell.showsLabel = true
			cell.bottomSeparator = false
			cell.topSeparator = false
			return cell
		}
		
		// Prizes
		else if (indexPath.section == 3) {
			let cell = tableView.dequeueReusableCellWithIdentifier("collectionCell", forIndexPath: indexPath) as! DetailCollectionTableViewCell
			cell.dataSource = prizesArray
			cell.tag = indexPath.section
			cell.delegate = self
			cell.showsLabel = false
			cell.bottomSeparator = false
			cell.topSeparator = false
			return cell
		}
		
		// Hardware?
		else if (indexPath.section == 4) {
			let cell = tableView.dequeueReusableCellWithIdentifier("textDetailsCell", forIndexPath: indexPath) as! BaseTableViewCell
			cell.textLabel?.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
			cell.bottomSeparator = false
			cell.topSeparator = false
			return cell
		}
		
		// Travel?
		else if (indexPath.section == 5) {
			let cell = tableView.dequeueReusableCellWithIdentifier("textDetailsCell", forIndexPath: indexPath) as! BaseTableViewCell
			cell.textLabel?.text = "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
			cell.bottomSeparator = false
			cell.topSeparator = false
			return cell
		}
		
		// Photos
		else if (indexPath.section == 6) {
			let cell = tableView.dequeueReusableCellWithIdentifier("photosCell", forIndexPath: indexPath) as! DetailCollectionTableViewCell
			cell.dataSource = prizesArray
			cell.delegate = self
			cell.tag = indexPath.section
			cell.itemSize = CGRectInset(cell.bounds, 2, 0).size
			cell.showsLabel = false
			cell.bottomSeparator = false
			cell.topSeparator = false
			return cell
		}
		
		else if (indexPath.section == 7) {
			let cell = tableView.dequeueReusableCellWithIdentifier("miscCell", forIndexPath: indexPath) as! BaseTableViewCell
			let dict = linksArray.objectAtIndex(indexPath.row) as! NSDictionary
			cell.textLabel?.text = dict.objectForKey("title") as? String
//			let ficon = FAKFontAwesome(code: "\\uf193", size: 16)
//			cell.imageView?.image = ficon.imageWithSize(CGSizeMake(44, 44))
			return cell
		}
		
		else if (indexPath.section == 8) {
			let cell = tableView.dequeueReusableCellWithIdentifier("applyCell", forIndexPath: indexPath) as! BaseTableViewCell
			cell.topSeparator = false
			cell.bottomSeparator = false
			return cell
		}
		
		let cell = UITableViewCell(style: .Default, reuseIdentifier: "defaultCell")
        return cell
		
    }
	
	// MARK: - Table view delegate
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		switch indexPath.section {
			case 0:
				if (indexPath.row == 0) { return 180 }
				else { return 24 }
			case 1, 2:
				return SWidth/4 * 8/5
			case 3:
				return SWidth/2 * 8/5 - 12
			case 4, 5:
				return 120
			case 6:
				return 240
			default:
				return 44
		}
	}
	
	override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		if (indexPath.section == 7 || indexPath.section == 8) {
			return true
		}
		return false
	}
	
	override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if (section == 1 || section == 2 || section == 7) {
			return 40
		}
		else if (section == 3 || section == 4 || section == 5) {
			return 60
		}
		return 0
	}
	
	override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if (section == 1 || section == 2 || section == 7) {
			let headerView = UIView(frame: CGRectMake(0, 0, SWidth, 40))
			headerView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
			let titleLabel = UILabel(frame: CGRectMake(40, 10, SWidth - 60, 30))
//			titleLabel.font = UIFont(name: "", size: 18)
			if (section == 1) { titleLabel.text = "Sponsors" }
			else if (section == 2) { titleLabel.text = "Guest Speakers" }
			else {
				titleLabel.text = "Miscellaneous"
				headerView.backgroundColor = UIColor.whiteColor()
			}
			headerView.addSubview(titleLabel)
			return headerView
		}
		else if (section == 3 || section == 4 || section == 5) {
			let headerView = UIView(frame: CGRectMake(0, 0, SWidth, 60))
//			headerView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
			let titleLabel = UILabel(frame: CGRectMake(20, 20, SWidth - 80, 40))
//			titleLabel.font = UIFont(name: "", size: 18)
			if (section == 3) { titleLabel.text = "Prizes" }
			else if (section == 4) { titleLabel.text = "HARDWARE" }
			else { titleLabel.text = "TRAVEL REIMBURSEMENT" }
			headerView.addSubview(titleLabel)
			let collapseButton = UIButton(frame: CGRectMake(SWidth - 60, 20, 40, 40))
			collapseButton.tag = section
			if (expandedSections[section] == 0) {
				collapseButton.setImage(UIImage(named: "Down"), forState: .Normal)
			}
			else {
				collapseButton.setImage(UIImage(named: "Up"), forState: .Normal)
			}
			collapseButton.addTarget(self, action: #selector(DetailTableViewController.collapseSection(_:)), forControlEvents: .TouchUpInside)
			headerView.addSubview(collapseButton)
			return headerView
		}
		return UIView(frame: CGRectZero)
	}
	
	override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 4
	}
	
	override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let footerView = UIView(frame: CGRectMake(0, 0, SWidth, 4))
		footerView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
 		return footerView
	}
	
	// MARK: - Targets
	
	func didPressLocationButton(sender: AnyObject) -> Void {
		// handle opening location
	}
	
	func collapseSection(sender: UIButton) -> Void {
		let section = sender.tag
		sender.transform = CGAffineTransformIdentity
		UIView.animateWithDuration(0.3, animations: { 
			sender.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
			}) { (done) in
				if (self.expandedSections[section] == 0) { self.expandedSections[section] = 1 }
				else { self.expandedSections[section] = 0 }
				self.tableView.reloadSections(NSIndexSet.init(index: section), withRowAnimation: .Automatic)
				dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * Int64(NSEC_PER_SEC)), dispatch_get_main_queue(), {
					sender.transform = CGAffineTransformIdentity
				})
		}
	}
	
	func favoriteAction(sender: UIButton) -> Void {
		print("Favorite pressed")
		
	}
	
	// MARK: - DetailCollectionTableViewCellDelegate
	
	func detailCollectionTableViewCellSelectedItemAtIndex(cell: DetailCollectionTableViewCell, index: Int, tag: Int) {
		if (tag == 1) {
			// Sponsers click
			print("Sponser selected \(index)")
		}
		else if (tag == 2) {
			// Guests click
			print("Guests selected \(index)")
		}
		else if (tag == 3) {
			// Prizes click
			print("Prizes selected \(index)")
		}
		else if (tag == 6) {
			// Photos click
			print("Photos selected \(index)")
		}
	}
	
    // MARK: - Navigation

	@IBAction func doneAction(sender: AnyObject) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	@IBAction func applyAction(sender: AnyObject) {
		// Apply here
		print("Apply!")
	}

}
