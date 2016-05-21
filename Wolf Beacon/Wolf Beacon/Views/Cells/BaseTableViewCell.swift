//
//  BaseTableViewCell.swift
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/21/16.
//  Copyright © 2016 Open Source Hacking. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
	
	var topSeparator: Bool = false {
		didSet {
			self.setNeedsDisplay()
		}
	}
	
	var topOffset: CGFloat = 0.0 {
		didSet {
			self.setNeedsDisplay()
		}
	}
	
	var bottomSeparator: Bool = false {
		didSet {
			self.setNeedsDisplay()
		}
	}
	
	var bottomOffset: CGFloat = 0.0 {
		didSet {
			self.setNeedsDisplay()
		}
	}
	
	override func drawRect(rect: CGRect) {
		super.drawRect(rect)
		let bounds = self.bounds
		let size = bounds.size
		if (topSeparator) {
			let beizerPath = UIBezierPath()
			beizerPath.moveToPoint(CGPointMake(topOffset, 0))
			beizerPath.addLineToPoint(CGPointMake(size.width - topOffset, 0))
			beizerPath.lineWidth = 0.5
			UIColor.lightGrayColor().setStroke()
			beizerPath.stroke()
		}
		if (bottomSeparator) {
			let beizerPath = UIBezierPath()
			beizerPath.moveToPoint(CGPointMake(topOffset, size.height - 0.5))
			beizerPath.addLineToPoint(CGPointMake(size.width - topOffset, size.height - 0.5))
			beizerPath.lineWidth = 0.5
			UIColor.lightGrayColor().setStroke()
			beizerPath.stroke()
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
