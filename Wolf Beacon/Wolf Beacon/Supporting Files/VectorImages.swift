//
//  VectorImages.swift
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/19/16.
//  Copyright © 2016 Open Source Hacking. All rights reserved.
//

import Foundation
import UIKit

func blankImageWithSize(size: CGSize) -> UIImage {
	UIGraphicsBeginImageContext(size)
	let image = UIGraphicsGetImageFromCurrentImageContext()
	UIGraphicsEndImageContext()
	return image
}

func underlinedImageWithSize(size: CGSize, tintColor: UIColor!, thickness: CGFloat, fill: CGFloat) -> UIImage {
	UIGraphicsBeginImageContext(size)
	let lineWidth = (1.0 - fill) * size.width
	let offset = size.width - lineWidth
	let lineRect = CGRectMake(offset/2, size.height - thickness, size.width - offset/2, thickness)
	tintColor.setFill()
	let beizerPath = UIBezierPath(rect: lineRect)
	beizerPath.fill()
	let image = UIGraphicsGetImageFromCurrentImageContext()
	UIGraphicsEndImageContext()
	return image
}

func plainImage(color: UIColor, size: CGSize) -> UIImage {
	let imageRect = CGRectMake(0, 0, size.width, size.height)
	UIGraphicsBeginImageContext(imageRect.size)
	let beizerPath = UIBezierPath(roundedRect: imageRect, cornerRadius: 4)
	color.setFill()
	beizerPath.fill()
	let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
	UIGraphicsEndImageContext()
	return newImage
}

func hamburgerImageWithStatus(color: UIColor) -> UIImage {
	let imageRect = CGRectMake(0, 0, 30, 30)
	UIGraphicsBeginImageContext(imageRect.size)
	let rect1 = CGRectMake(0, 8, 20, 4)
	let rect2 = CGRectMake(0, 16, 30, 4)
	let rect3 = CGRectMake(0, 24, 30, 4)
	let rects: Array<CGRect> = [rect1, rect2, rect3]
	for rect: CGRect in rects {
		let beizerPath = UIBezierPath(roundedRect: rect, cornerRadius: 2)
		UIColor.whiteColor().setFill()
		beizerPath.fill()
	}
	let statusRect = CGRectMake(22, 4, 8, 8)
	let statusPath = UIBezierPath(roundedRect: statusRect, cornerRadius: 4)
	color.setFill()
	statusPath.fill()
	let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
	UIGraphicsEndImageContext()
	return newImage
}