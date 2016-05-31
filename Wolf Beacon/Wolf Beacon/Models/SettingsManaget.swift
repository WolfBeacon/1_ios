//
//  SettingsManaget.swift
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/31/16.
//  Copyright © 2016 Open Source Hacking. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import ChameleonFramework
import IQKeyboardManagerSwift

var globalBackColor: UIColor = UIColor(hexString: "2D660D")
var globalTintColor: UIColor = UIColor(hexString: "E6E6E6")

func updateGlobalTheme () -> Void {
	
	UINavigationBar.appearance().backgroundColor = globalBackColor
	UINavigationBar.appearance().tintColor = globalTintColor
	UINavigationBar.appearance().barTintColor = globalBackColor
	
	UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "AlNile", size: 18)!, NSForegroundColorAttributeName: globalTintColor]
	
	UITabBar.appearance().backgroundColor = globalBackColor
	UITabBar.appearance().tintColor = globalTintColor
	UITabBar.appearance().barTintColor = globalBackColor
	
	UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AlNile", size: 13)!, NSForegroundColorAttributeName: globalTintColor], forState: .Selected)
	UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AlNile", size: 13)!, NSForegroundColorAttributeName: UIColor.lightGrayColor()], forState: .Normal)
	
	UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AlNile", size: 16)!, NSForegroundColorAttributeName: globalTintColor], forState: .Normal)
	
	UITableView.appearance().backgroundColor = globalBackColor
	UITableView.appearance().tintColor = globalTintColor
	
	UICollectionView.appearance().backgroundColor = globalBackColor
	UICollectionView.appearance().tintColor = globalTintColor
	
	UIButton.appearance().tintColor = globalTintColor
	
	UISwitch.appearance().tintColor = globalTintColor
	UISwitch.appearance().onTintColor = globalTintColor
	
	UISearchBar.appearance().backgroundColor = globalBackColor
	UISearchBar.appearance().tintColor = globalTintColor
	UISearchBar.appearance().barTintColor = globalBackColor
	
	SVProgressHUD.setFont(UIFont(name: "AlNile", size: 16))
	SVProgressHUD.setBackgroundColor(globalBackColor)
	SVProgressHUD.setForegroundColor(globalTintColor)
}