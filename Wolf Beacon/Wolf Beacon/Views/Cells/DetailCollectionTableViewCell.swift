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
	
	class func dataSourceFromJSONStructure(jsonData: NSArray) -> NSArray {
		let array = NSMutableArray()
		for data in jsonData {
			let dsitem = CollectionDataSource(dict: data as! NSDictionary)
			array.addObject(dsitem)
		}
		return array
	}
	
}

// MARK: -
// Cell class for the collection view
class DetailCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
}

// MARK: -
// Handling the cell touches in the cells
@objc protocol DetailCollectionTableViewCellDelegate {
	func detailCollectionTableViewCellSelectedItemAtIndex(cell: DetailCollectionTableViewCell, index: Int) -> Void
}

// MARK: -
class DetailCollectionTableViewCell: BaseTableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
	
	var delegate: DetailCollectionTableViewCellDelegate?
	
	var dataSource: NSMutableArray = NSMutableArray() {
		didSet {
			self.collectionView.reloadData()
			self.pageControl.numberOfPages = min(12, dataSource.count)
			if (dataSource.count > 12) {
				self.pageControl.hidden = true
			}
		}
	}
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	@IBOutlet weak var pageControl: UIPageControl!
	
	var showsLabel: Bool = false {
		didSet {
			self.collectionView.reloadData()
		}
	}
	
	override func awakeFromNib() {
		self.collectionView.dataSource = self
		self.collectionView.delegate = self
	}
	
	// MARK: - Collection view datasource
	
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataSource.count
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! DetailCollectionViewCell
		let dsitem = dataSource.objectAtIndex(indexPath.row) as! CollectionDataSource
		cell.titleLabel.text = dsitem.title
		cell.titleLabel.hidden = !showsLabel
		cell.imageView.image = UIImage(named: dsitem.imageName)
		return cell
	}
	
	// MARK: - Collection view delegate
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		if let delegate = self.delegate {
			delegate.detailCollectionTableViewCellSelectedItemAtIndex(self, index: indexPath.row)
		}
	}
	
	func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
		self.pageControl.currentPage = indexPath.row
	}

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
