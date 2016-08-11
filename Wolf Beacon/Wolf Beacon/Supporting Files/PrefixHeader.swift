//
//  PrefixHeader.swift
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/19/16.
//  Copyright © 2016 Open Source Hacking. All rights reserved.
//

import Foundation
import UIKit

let SWidth = UIScreen.mainScreen().bounds.size.width
let SHeight = UIScreen.mainScreen().bounds.size.height

extension NSDate {
	class func getDateFromMillis(millis: Int) -> NSDate {
		return NSDate(timeIntervalSince1970: NSTimeInterval(1000))
	}
}