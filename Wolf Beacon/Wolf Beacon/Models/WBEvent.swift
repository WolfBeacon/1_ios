//
//  WBEvent.swift
//  Wolf Beacon
//
//  Created by Avikant Saini on 8/11/16.
//  Copyright © 2016 Open Source Hacking. All rights reserved.
//

import UIKit
import RealmSwift

class WBEventPrizes: Object {
	
	dynamic var name: String = ""
	dynamic var desc: String = ""
	dynamic var sponsor: String = ""
	
	func fillWithDict(dict: [String: AnyObject]) {
		if let value = dict["name"] as? String { name = value }
		if let value = dict["description"] as? String { desc = value }
		if let value = dict["sponsor"] as? String { sponsor = value }
	}
	
	class func getPrizesFromJSON(json: [[String: AnyObject]]) -> List<WBEventPrizes> {
		let prizes:List<WBEventPrizes> = List<WBEventPrizes>()
		for item in json {
			let prz = WBEventPrizes()
			prz.fillWithDict(item)
			prizes.append(prz)
		}
//		let realm = try! Realm()
//		for prz in prizes {
//			try! realm.write({
//				realm.add(prz)
//			})
//		}
		return prizes
	}
	
}

class WBEvent: Object {
	
	dynamic var id: Int = 0
	dynamic var name: String = ""
	
	dynamic var ownerId: Int = 0
	
	dynamic var locationName: String = ""
	dynamic var locationCity: String = ""
	dynamic var locationState: String = ""
	dynamic var locationCountry: String = ""
	dynamic var locationLatitude: Double = 0.0
	dynamic var locationLongitude: Double = 0.0
	
	dynamic var startDate: NSDate = NSDate()
	dynamic var endDate: NSDate = NSDate()
	
	dynamic var currentState: Int = 0
	
	var prizes: List<WBEventPrizes> = List<WBEventPrizes>()
	
	dynamic var reimbursements: Bool = false
	dynamic var busesoffered: Bool = false
	
	var buslocations: String = ""
	var sociallinks: String = ""
	var hardware: String = ""
	
	dynamic var maplink: String = ""
	dynamic var metadata: String = ""
	
	func fillWithDict(dict: [String: AnyObject]) {
		if let value = dict["id"] as? NSString { id = value.integerValue }
		if let value = dict["name"] as? String { name = value }
		if let value = dict["ownerid"] as? NSString { ownerId = value.integerValue }
		if let value = dict["location"] as? [String: AnyObject] { if let v2 = value["name"] as? String { locationName = v2 } }
		if let value = dict["location"] as? [String: AnyObject] { if let v2 = value["city"] as? String { locationCity = v2 } }
		if let value = dict["location"] as? [String: AnyObject] { if let v2 = value["state"] as? String { locationState = v2 } }
		if let value = dict["location"] as? [String: AnyObject] { if let v2 = value["country"] as? String { locationName = v2 } }
		if let value = dict["location"] as? [String: AnyObject] {
			if let v2 = value["coords"] as? [Double] {
				if let lat = v2.first { locationLatitude = lat }
				if let lon = v2.last { locationLongitude = lon }
			}
		}
		if let value = dict["startdate"] as? NSString { startDate = NSDate.getDateFromMillis(value.integerValue) }
		if let value = dict["enddate"] as? NSString { endDate = NSDate.getDateFromMillis(value.integerValue) }
		if let value = dict["currentstate"] as? NSString { id = value.integerValue }
		if let value = dict["prizes"] as? [[String: AnyObject]] {
			prizes = WBEventPrizes.getPrizesFromJSON(value)
		}
		if let value = dict["reimbursements"] as? NSString { reimbursements = value.boolValue }
		if let value = dict["busesoffered"] as? NSString { busesoffered = value.boolValue }
		if let value = dict["buslocations"] as? [String] {
			for str in value {
				buslocations.appendContentsOf("\(str)\n")
			}
		}
		if let value = dict["sociallinks"] as? [String] {
			for str in value {
				sociallinks.appendContentsOf("\(str)\n")
			}
		}
		if let value = dict["hardware"] as? [String] {
			for str in value {
				hardware.appendContentsOf("\(str)\n")
			}
		}
		if let value = dict["map"] as? String { maplink = value }
		if let value = dict["metadata"] as? String { metadata = value }
	}
	
	class func getEventsFromJSON(json: [[String: AnyObject]]) -> [WBEvent] {
		var events:[WBEvent] = []
		for item in json {
			let ent = WBEvent()
			ent.fillWithDict(item)
			events.append(ent)
		}
		return events
	}

}
