//
//  DetailHeaderTableViewCell.swift
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/21/16.
//  Copyright © 2016 Open Source Hacking. All rights reserved.
//

import UIKit

class DetailHeaderTableViewCell: BaseTableViewCell {
	
	@IBOutlet weak var logoImageView: UIImageView!
	
	@IBOutlet weak var titleLabel: UILabel!
	
	@IBOutlet weak var locationButton: UIButton!
	
	@IBOutlet weak var timeSlotButton: UIButton!
	
	@IBOutlet weak var applyButton: UIButton!
	
	override func awakeFromNib() {
		locationButton.titleLabel?.lineBreakMode = .ByWordWrapping
		locationButton.titleLabel?.numberOfLines = 0
		locationButton.titleLabel?.textAlignment = .Left
		locationButton.contentHorizontalAlignment = .Left
		locationButton.contentVerticalAlignment = .Top
		locationButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
		
		timeSlotButton.titleLabel?.lineBreakMode = .ByWordWrapping
		timeSlotButton.titleLabel?.textAlignment = .Left
		
		applyButton.layer.borderWidth = 1.0
		applyButton.layer.borderColor = applyButton.tintColor.CGColor
		applyButton.layer.cornerRadius = 4.0
		applyButton.setTitle("APPLY", forState: .Normal)
		
		logoImageView.layer.cornerRadius = 20.0
		logoImageView.layer.backgroundColor = UIColor.flatWhiteColor().CGColor
		logoImageView.layer.masksToBounds = true
	}
	
	func setLocationText(locationText: String) -> Void {
		locationButton.setTitle(locationText, forState: .Normal)
	}
	
	var fromDate: NSDate = NSDate() {
		didSet {
			updateTimeButtonTitle()
		}
	}
	var toDate: NSDate = NSDate() {
		didSet {
			updateTimeButtonTitle()
		}
	}
	
	func updateTimeButtonTitle() -> Void {
		textLabel?.textAlignment
		let formatter = NSDateFormatter()
		formatter.dateFormat = "EEE, MMM dd, hh:mm a"
		timeSlotButton.setTitle("\(formatter.stringFromDate(fromDate)) - \(formatter.stringFromDate(toDate)) ❯", forState: .Normal)
	}

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
