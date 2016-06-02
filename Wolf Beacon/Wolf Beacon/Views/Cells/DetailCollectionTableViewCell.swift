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

// Cell class for the collection view
class DetailCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	/*
	override func awakeFromNib() {
		self.backgroundColor = UIColor.clearColor()
		self.layer.backgroundColor = UIColor.clearColor().CGColor
		self.layer.borderColor = UIColor.whiteColor().CGColor
		self.layer.borderWidth = 4.0
//		self.layer.shadowPath = UIBezierPath(rect: self.bounds).CGPath
//		self.layer.shadowColor = UIColor.blackColor().CGColor
//		self.layer.shadowOffset = CGSizeZero
//		self.layer.shadowOpacity = 1.0
//		self.layer.shadowRadius = 2.0
	}
	*/
}

// MARK: -
// Handling the cell touches in the cells
@objc protocol DetailCollectionTableViewCellDelegate {
	func detailCollectionTableViewCellSelectedItemAtIndex(cell: DetailCollectionTableViewCell, index: Int, tag: Int) -> Void
}

// MARK: -
class DetailCollectionTableViewCell: BaseTableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	var delegate: DetailCollectionTableViewCellDelegate?
	
	var dataSource: NSMutableArray = NSMutableArray() {
		didSet {
			self.collectionView.reloadData()
			self.pageControl?.numberOfPages = min(12, dataSource.count)
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
	
	var itemSize: CGSize = CGSizeMake(SWidth/4 - 8, (8*(SWidth/4 - 8))/5)
	var itemSpacing: CGFloat = 4.0
	
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
		cell.imageView.clipsToBounds = true
		return cell
	}
	
	// MARK: - Collection view delegate
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		if let delegate = self.delegate {
			delegate.detailCollectionTableViewCellSelectedItemAtIndex(self, index: indexPath.row, tag: tag)
		}
	}
	
	func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
		self.pageControl?.currentPage = indexPath.row
	}
	
	// MARK: - Collection view delegate flow layout
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return itemSize
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
		return itemSpacing
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
		return itemSpacing
	}
	
	/*
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect) {
	// Drawing code
	}
	*/
	
}
