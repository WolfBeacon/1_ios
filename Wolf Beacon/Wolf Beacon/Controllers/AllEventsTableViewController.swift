//
//  AllEventsTableViewController.swift
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/31/16.
//  Copyright © 2016 Open Source Hacking. All rights reserved.
//

import UIKit
import SVProgressHUD

class AllEventsTableViewController: UITableViewController {

	var allEvents: [WBEvent] = []
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		SVProgressHUD.show()
		for i in 1...2 {
			let request = NSURLRequest(URL: NSURL(string: "http://osh-api.herokuapp.com/cms/get/\(i)")!)
			NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) in
				if error != nil {
					print("Error in parsing")
					return
				}
				if data != nil {
					do {
						let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
						if let dict = json as? [String: AnyObject] {
							let event = WBEvent()
							event.fillWithDict(dict)
							dispatch_async(dispatch_get_main_queue(), {
								self.allEvents.append(event)
								self.tableView.reloadData()
								SVProgressHUD.dismiss()
							})
						}
					} catch _ {
						
					}
				}
			}).resume()
		}
		
		tableView.registerNib(UINib.init(nibName: "EventTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "eventCell")
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return allEvents.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell: EventTableViewCell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventTableViewCell
		let event = allEvents[indexPath.row]
		cell.titleLabel.text = event.name
		cell.subtitleLabel.text = "\(event.locationName) | \(event.locationCity) | \(event.locationState), \(event.locationCountry)"
		cell.iconImageView.image = UIImage(named: "logo\(indexPath.row)")
		return cell
	}
	
	// MARK: - Table view delegate
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		if (indexPath.row == allEvents.count) {
			return 60
		}
		return 100
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if (indexPath.row == allEvents.count) {
			// Fetch and append more results
		}
		// Select from all events (filtered)
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}

}
