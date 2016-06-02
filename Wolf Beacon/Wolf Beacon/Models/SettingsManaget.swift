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

var globalBackColor: UIColor = UIColor(hexString: "FFFFFF")
var globalTintColor: UIColor = UIColor(hexString: "2D660D")

func updateGlobalTheme () -> Void {
	
	UINavigationBar.appearance().backgroundColor = globalTintColor
	UINavigationBar.appearance().tintColor = globalBackColor
	UINavigationBar.appearance().barTintColor = globalTintColor
	
	UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(17), NSForegroundColorAttributeName: globalBackColor]
	
	UITabBar.appearance().backgroundColor = globalBackColor
	UITabBar.appearance().tintColor = globalTintColor
	UITabBar.appearance().barTintColor = globalBackColor
	
	UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(13), NSForegroundColorAttributeName: globalTintColor], forState: .Selected)
	UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(13), NSForegroundColorAttributeName: UIColor.lightGrayColor()], forState: .Normal)
	
	UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(16), NSForegroundColorAttributeName: globalBackColor], forState: .Normal)
	
	UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).font = UIFont.systemFontOfSize(14)
	UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).textColor = UIColor.whiteColor()
	
	UITableView.appearance().backgroundColor = globalBackColor
	UITableView.appearance().tintColor = globalTintColor
	
	UICollectionView.appearance().backgroundColor = UIColor.clearColor()
	UICollectionView.appearance().tintColor = globalTintColor
	
	UIButton.appearance().tintColor = globalBackColor
	
	UISwitch.appearance().tintColor = globalTintColor
	UISwitch.appearance().onTintColor = globalTintColor
	
	UISearchBar.appearance().backgroundColor = globalTintColor
	UISearchBar.appearance().tintColor = globalBackColor
	UISearchBar.appearance().barTintColor = globalTintColor
	
	SVProgressHUD.setFont(UIFont(name: "AlNile", size: 16))
	SVProgressHUD.setBackgroundColor(globalBackColor)
	SVProgressHUD.setForegroundColor(globalTintColor)
}