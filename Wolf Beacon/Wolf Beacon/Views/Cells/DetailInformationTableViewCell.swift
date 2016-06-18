//
//  DetailInformationTableViewCell.swift
//  Wolf Beacon
//
//  Created by Avikant Saini on 6/5/16.
//  Copyright © 2016 Open Source Hacking. All rights reserved.
//

import UIKit

class DetailInformationTableViewCell: UITableViewCell {
	
	@IBOutlet weak var titleLabel: UILabel!
	
	@IBOutlet private weak var detailLabel: UILabel!
	var detailText : String? {
		didSet {
			detailLabel.text = detailText
			/*
			if (expanded) {
				detailLabel.text = detailText
			}
			else {
				let string = NSMutableString(string: detailText!)
				var maxHeight = 1000
				let height = 140 - 50
				while maxHeight > height {
					maxHeight = Int(string.boundingRectWithSize(CGSizeMake(SWidth - 20, 1000), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: globalFont16], context: nil).size.height)
					
				}
//				if (detailText?.characters.count > )
			}
			*/
		}
	}
	
	@IBOutlet weak var showMoreButton: UIButton!
	
	var expanded: Bool = false {
		didSet {
			showMoreButton.hidden = expanded
			if (expanded) {
				
			}
			else {
				
			}
		}
	}

	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		showMoreButton.hidden = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	class func estimatedHeightForText(text: NSString) -> CGFloat {
		let rect = text.boundingRectWithSize(CGSizeMake(SWidth - 16, 1000), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: globalFont12], context: nil)
		return rect.size.height + 50
	}
 
}
