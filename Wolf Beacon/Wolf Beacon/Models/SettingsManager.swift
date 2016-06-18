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

var globalFont18: UIFont		= UIFont.systemFontOfSize(18, weight: UIFontWeightBold)
var globalFont20Light: UIFont	= UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
var globalFont20Thin: UIFont	= UIFont.systemFontOfSize(20, weight: UIFontWeightThin)
var globalFont16: UIFont		= UIFont.systemFontOfSize(16, weight: UIFontWeightRegular)
var globalFont16Light: UIFont	= UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
var globalFont14: UIFont		= UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
var globalFont14Light: UIFont	= UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
var globalFont12: UIFont		= UIFont.systemFontOfSize(12, weight: UIFontWeightRegular)
var globalFont10: UIFont		= UIFont.systemFontOfSize(10, weight: UIFontWeightRegular)

func updateGlobalTheme () -> Void {
	
	UINavigationBar.appearance().backgroundColor = globalTintColor
	UINavigationBar.appearance().tintColor = globalBackColor
	UINavigationBar.appearance().barTintColor = globalTintColor
	
	UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(17), NSForegroundColorAttributeName: globalBackColor]
	
	UITabBar.appearance().backgroundColor = globalBackColor
	UITabBar.appearance().tintColor = globalTintColor
	UITabBar.appearance().barTintColor = globalBackColor
	
	UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: globalFont12, NSForegroundColorAttributeName: globalTintColor], forState: .Selected)
	UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: globalFont12, NSForegroundColorAttributeName: UIColor.lightGrayColor()], forState: .Normal)
	
	UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: globalFont16, NSForegroundColorAttributeName: globalBackColor], forState: .Normal)
	
	UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).font = globalFont14
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
	
	SVProgressHUD.setFont(globalFont16Light)
	SVProgressHUD.setBackgroundColor(globalBackColor)
	SVProgressHUD.setForegroundColor(globalTintColor)
}