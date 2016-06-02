//
//  DetailHeaderTableViewCell.swift
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/21/16.
//  Copyright © 2016 Open Source Hacking. All rights reserved.
//

import UIKit

class DetailHeaderTableViewCell: BaseTableViewCell {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subtitleLabel: UILabel!
	
	@IBOutlet weak var locationButton: UIButton!
	
	@IBOutlet weak var timeLabel: UILabel!
	
	@IBOutlet weak var descriptionLabel: UILabel!
	
	@IBOutlet weak var favButton: UIButton!
	
	var fromDate: NSDate = NSDate() {
		didSet {
			updateTimeLabel()
		}
	}
	var toDate: NSDate = NSDate() {
		didSet {
			updateTimeLabel()
		}
	}
	
	func updateTimeLabel() -> Void {
		let formatter = NSDateFormatter()
		formatter.dateFormat = "EEE, MMM dd, hh:mm a"
		timeLabel.text = "\(formatter.stringFromDate(fromDate)) - \(formatter.stringFromDate(toDate))"
	}

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
