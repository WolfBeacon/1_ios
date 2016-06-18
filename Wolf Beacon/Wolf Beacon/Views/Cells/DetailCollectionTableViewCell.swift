//
//  DetailCollectionTableViewCell.swift
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/21/16.
//  Copyright © 2016 Open Source Hacking. All rights reserved.
//

import UIKit

// Data source helper class for the collection view
class CollectionDataSource: NSObject {
	var title: String = ""
	var imageName: String = ""
	
	init(title: String, imageName: String) {
		super.init()
		self.title = title
		self.imageName = imageName
	}
	
	init(dict: NSDictionary) {
		super.init()
		self.title = "\((dict.objectForKey("title") as? String)!)"
		self.imageName = "\((dict.objectForKey("imageName") as? String)!)"
	}
	
	class func dataSourceFromJSONStructure(jsonData: NSArray) -> NSMutableArray {
		let array = NSMutableArray()
		for data in jsonData {
			let dsitem = CollectionDataSource(dict: NSDictionary(dictionary: data as! [NSObject : AnyObject]))
			array.addObject(dsitem)
		}
		return array
	}
	
}

// MARK: -
class DetailCollectionTableViewCell: BaseTableViewCell {
	
	@IBOutlet weak var titleLabel: UILabel!
	
	@IBOutlet private weak var collectionView: UICollectionView!
	
	func setCollectionViewDataSourceDelegate <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>> (dataSourceDelegate: D, forRow row: Int) {
		collectionView.registerNib(UINib(nibName: "DetailCollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "collectionCell")
		collectionView.delegate = dataSourceDelegate
		collectionView.dataSource = dataSourceDelegate
		collectionView.tag = row
		collectionView.accessibilityLabel = "\(row)"
		collectionView.reloadData()
	}
	
}
