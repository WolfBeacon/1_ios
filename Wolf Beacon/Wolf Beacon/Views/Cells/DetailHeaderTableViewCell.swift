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
	
	@IBOutlet weak var remainingProgressView: UIProgressView!
	
	@IBOutlet weak var remainingLabel: UILabel!
	
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
		let rtime = NSDate().timeIntervalSinceDate(toDate)
		if (rtime > 0) {
			remainingProgressView.progress = 0
			remainingLabel.text = "This event has ended"
		}
		else {
			let ttime = toDate.timeIntervalSinceDate(fromDate)
			let dtime = ttime + rtime
			let time : hmstime = hmstime(sec: Int(-rtime))
			remainingLabel.text = "\(time.hour) hours, \(time.min) minutes till the event ends"
			remainingProgressView.progress = Float(dtime/ttime);
		}
	}
	
	struct hmstime {
		var hour: Int
		var min: Int
		var sec: Int
		init (sec: Int) {
			self.sec = sec
			self.min = sec / 60
			self.hour = self.min / 60
			self.min = self.min - self.hour * 60
			self.sec = self.sec - self.min * 60 - self.hour * 3600
		}
	}

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
