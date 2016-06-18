//
//  DetailTableViewController.swift
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/21/16.
//  Copyright © 2016 Open Source Hacking. All rights reserved.
//

import UIKit
import FontAwesomeKit

class DetailTableViewController: UITableViewController {

	var headerImageView = UIImageView(frame: CGRectMake(0, 0, SWidth, SWidth/2))
	
	var facalitiesArray = NSMutableArray()
	var sponsersArray: [[String:String]] = []
	var guestsArray: [[String:String]] = []
	var prizesArray: [[String:String]] = []
	var othersArray: [[String:String]] = []
	var linksArray: [[String:String]] = []
	var photosArray: [[String:String]] = []
	
	var hackathonText: String = "A hackathon (also known as a hack day, hackfest or codefest) is an event in which computer programmers and others involved in software development, including graphic designers, interface designers and project managers, collaborate intensively on software projects. Occasionally, there is a hardware component as well. Hackathons typically last between a day and a week.\n\nSome hackathons are intended simply for educational or social purposes, although in many cases the goal is to create usable software. Hackathons tend to have a specific focus, which can include the programming language used, the operating system, an application, an API, or the subject and the demographic group of the programmers. In other cases, there is no restriction on the type of software being created."
	
	var hardwareText: String = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
	var travelText: String = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let footerView = UIView(frame: CGRectMake(0, 0, SWidth, 44))
		self.tableView.tableFooterView = footerView
		
		self.navigationItem.title = "Details"
		
		facalitiesArray = NSMutableArray(array: ["Travel reimbruishment", "Bus route supported"])
		
		sponsersArray =
			[
				["title": "Legatum Center for Development & Entrepreneurship", "imageName": "sponser1.jpg"],
				["title": "Lemelson-MIT Program", "imageName": "sponser2.png"],
				["title": "Department of C & E", "imageName": "sponser3.png"],
				["title": "Department of Mechanical Engg", "imageName": "sponser4.jpg"]
			]

		guestsArray =
			[
				["title": "Maurice Moss", "imageName": "moss.jpg"],
				["title": "Bertram Gilfoyle", "imageName": "gilfoyle.jpg"],
				["title": "Harvey Specter", "imageName": "harvey.jpg"],
				["title": "The Doctor", "imageName": "doctor.jpg"],
			]
		
		prizesArray =
			[
				["title": "Prize 1A",	"imageName": "prize1.jpg"],
				["title": "Prize 1B",	"imageName": "prize2.jpg"],
				["title": "Prize 2A",	"imageName": "prize3.jpg"],
				["title": "Prize 2B",	"imageName": "prize4.jpg"],
				["title": "Prize 3A",	"imageName": "prize5.jpg"],
				["title": "Prize 3B",	"imageName": "prize6.jpg"],
				["title": "Prize 4A",	"imageName": "prize7.jpg"],
				["title": "Prize 4B",	"imageName": "prize8.jpg"]
			]
		
		othersArray =
			[
				["title": "Hardware", "text": hardwareText],
				["title": "Travel Reimbursement", "text": travelText]
			]
		
		linksArray =
			[
				["title": "facebook/uofthon", "url": "https://facebook.com/uofthon", "icon": "fa-facebook"],
				["title": "twitter/uofthon", "url": "https://twitter.com/uofthon", "icon": "fa-twitter"],
				["title": "GitHub/uofthon", "url": "https://github.com/uofthon", "icon": "fa-github"],
				["title": "wolfbeacon.com/uofthon", "url": "https://wolfbeacon.com/uofthon", "icon": "fa-rss"]
			]
		
		photosArray =
			[
				["title": "", "imageName": "mitcampus.jpg"],
				["title": "", "imageName": "hackathon1.jpg"],
				["title": "", "imageName": "hackathon2.jpg"],
				["title": "", "imageName": "mitcampus.jpg"],
			]
		
		tableView.registerNib(UINib(nibName: "DetailHeaderTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "headerCell")
		tableView.registerNib(UINib(nibName: "DetailFacilitiesTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "facilitiesCell")
		
		tableView.registerNib(UINib(nibName: "DetailInformationTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "informationCell")
		
		tableView.registerNib(UINib(nibName: "DetailCollectionTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "photosCell")
		tableView.registerNib(UINib(nibName: "DetailCollectionTableViewCell2", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "sponsersCell")
		
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 8
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
			case 0: return 1 + facalitiesArray.count
			case 1...5: return 1
			case 6: return othersArray.count
			case 7: return linksArray.count
			case 8: return 1
			default: return 0
		}
	}
	
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		// Header section
		if (indexPath.section == 0) {
			if (indexPath.row == 0) {
				let cell = tableView.dequeueReusableCellWithIdentifier("headerCell", forIndexPath: indexPath) as! DetailHeaderTableViewCell
				cell.fromDate = NSDate().dateByAddingTimeInterval(-18000)
				cell.toDate = NSDate().dateByAddingTimeInterval(54000)
				cell.setLocationText("Department of Civil and Environmental Engineering, Massachusetts Institute of Technology ❯")
				cell.logoImageView.image = UIImage(named: "logo1.png")!
				return cell
			}
			else {
				let cell = tableView.dequeueReusableCellWithIdentifier("facilitiesCell", forIndexPath: indexPath)
				cell.textLabel?.text = facalitiesArray[indexPath.row - 1] as? String
				if (indexPath.row == 1) { cell.imageView?.image = UIImage(named: "travel") }
				else { cell.imageView?.image = UIImage(named: "money") }
				return cell
			}
		}
			
		// Event Information
		else if (indexPath.section == 1) {
			let cell = tableView.dequeueReusableCellWithIdentifier("informationCell", forIndexPath: indexPath) as! DetailInformationTableViewCell
			cell.titleLabel.text = "Event Information"
			cell.detailText = hackathonText
			return cell
		}
		
		// Maps, Sponsers, Prizes, and Guest Speakers
		else if (indexPath.section >= 2 && indexPath.section <= 5) {
			let cell = tableView.dequeueReusableCellWithIdentifier("photosCell", forIndexPath: indexPath) as! DetailCollectionTableViewCell
			if (indexPath.section == 2) { cell.titleLabel.text = "Indoor Maps" }
			else if (indexPath.section == 3) { cell.titleLabel.text = "Sponsers" }
			else if (indexPath.section == 4) { cell.titleLabel.text = "Prizes" }
			else if (indexPath.section == 5) { cell.titleLabel.text = "Guest Speakers" }
			return cell
		}
		
		// Other stuff
		else if (indexPath.section == 6) {
			let cell = tableView.dequeueReusableCellWithIdentifier("informationCell", forIndexPath: indexPath) as! DetailInformationTableViewCell
			cell.titleLabel.text = othersArray[indexPath.row]["title"]
			cell.detailText = othersArray[indexPath.row]["text"]
			return cell
		}
		
		else if (indexPath.section == 7) {
			let cell = tableView.dequeueReusableCellWithIdentifier("miscCell", forIndexPath: indexPath)
			cell.textLabel?.text = linksArray[indexPath.row]["title"]
			
			return cell
		}
		
		else if (indexPath.section == 8) {

		}
		
		let cell = UITableViewCell(style: .Default, reuseIdentifier: "defaultCell")
        return cell
		
    }

	override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
		guard let tableViewCell = cell as? DetailCollectionTableViewCell else { return }
		tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
	}
	
	// MARK: - Table view delegate
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		switch indexPath.section {
			case 0:
				if (indexPath.row == 0) { return 144 }
				else { return 26 }
			case 1:
				return DetailInformationTableViewCell.estimatedHeightForText(hackathonText)
			case 2:
				return (SWidth - 100) * 1.7778 + 46
			case 3:
				return (SWidth/3 - 10) * 1.4 + 46
			case 4:
				return (SWidth/3 - 10) * 3 + 12
			case 5:
				return (SWidth/2.5 - 10) * 1.5 + 46
			case 6:
				return DetailInformationTableViewCell.estimatedHeightForText(othersArray[indexPath.row]["text"]!)
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
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	
	override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//		if (section >= 2 && section <= 7) { return 40 }
		if (section == 7) { return 40 }
		return 0
	}
	
	override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if (section == 7) {
			let headerView = UIView(frame: CGRectMake(0, 0, SWidth, 40))
			let label = UILabel(frame: CGRectMake(12, 8, SWidth - 24, 24))
			label.font = globalFont16
			label.text = "Miscellaneous"
			headerView.addSubview(label)
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
	
	func favoriteAction(sender: AnyObject) -> Void {
		print("Favorite pressed")
		
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

extension DetailTableViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	// MARK: - Collection view datasource
	
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if (collectionView.tag == 2) { return 3 } // Maps
		else if (collectionView.tag == 3) { return sponsersArray.count } // Sponsers
		else if (collectionView.tag == 4) { return prizesArray.count } // Sponsers
		else if (collectionView.tag == 5) { return guestsArray.count } // Sponsers
		return 4
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		if (collectionView.tag == 2) {
			let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! DetailCollectionViewCell
	//		let dsitem = dataSource.objectAtIndex(indexPath.row) as! CollectionDataSource
			cell.titleLabel?.hidden = true
			cell.imageView?.image = UIImage(named: "map\(indexPath.row).jpg")
			cell.imageView?.clipsToBounds = true
			return cell
		}
		else if (collectionView.tag >= 3 && collectionView.tag <= 5) {
			let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! DetailCollectionViewCell
			var dsitem: [String: String] = [:]
			if (collectionView.tag == 3) { dsitem = sponsersArray[indexPath.row] }
			else if (collectionView.tag == 4) { dsitem = prizesArray[indexPath.row] }
			else if (collectionView.tag == 5) { dsitem = guestsArray[indexPath.row] }
			cell.titleLabel?.hidden = false
			cell.titleLabel?.text = dsitem["title"]
			cell.imageView?.image = UIImage(named: dsitem["imageName"]!)
			cell.imageView?.clipsToBounds = true
			return cell
		}
		else {
			let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! DetailCollectionViewCell
//			let dsitem = sponsersArray[indexPath.row]
//			cell.titleLabel?.hidden = false
//			cell.titleLabel?.text = dsitem["title"]
//			cell.imageView?.image = UIImage(named: dsitem["imageName"]!)
//			cell.imageView?.clipsToBounds = true
			cell.backgroundColor = UIColor.blueColor()
			return cell
		}
	}
	
	// MARK: - Collection view delegate
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		if (collectionView.tag == 2) {
			
		}
		else if (collectionView.tag == 3) {
			
		}
	}
	
	// MARK: - Collection view delegate flow layout
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		if (collectionView.tag == 2) { return CGSizeMake(SWidth - 100, (SWidth - 100) * 1.7778) }
		else if (collectionView.tag == 3) { return CGSizeMake(SWidth/3 - 10, (SWidth/3 - 30) * 1.4) }
		else if (collectionView.tag == 4) { return CGSizeMake(SWidth/3 - 10, (SWidth/3 - 30) * 1.5) }
		else if (collectionView.tag == 5) { return CGSizeMake(SWidth/2.5 - 10, (SWidth/2.5 - 30) * 1.5) }
		return CGSizeMake(SWidth/3 - 10, (SWidth/3 - 30) * 1.4)
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
		if (collectionView.tag == 2) { return 30 }
		return 10
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
		return 8
	}
	
}
