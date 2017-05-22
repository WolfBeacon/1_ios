//
//  BaseTableViewCell.h
//  Wolf Beacon
//
//  Created by Avikant Saini on 10/26/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic) IBInspectable BOOL topSeparator;
@property (nonatomic) IBInspectable CGFloat topOffset;

@property (nonatomic) IBInspectable BOOL bottomSeparator;
@property (nonatomic) IBInspectable CGFloat bottomOffset;

@end
