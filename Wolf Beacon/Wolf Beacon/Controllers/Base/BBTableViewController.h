//
//  BBTableViewController.h
//  Wolf Beacon
//
//  Created by Avikant Saini on 2/25/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KWTransition/KWTransition.h>

@interface BBTableViewController : UITableViewController <UIViewControllerTransitioningDelegate>

@property (nonatomic) KWTransition *transistion;

@end
