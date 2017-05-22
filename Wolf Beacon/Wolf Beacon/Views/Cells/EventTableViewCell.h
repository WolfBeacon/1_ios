//
//  EventTableViewCell.h
//  Wolf Beacon
//
//  Created by Avikant Saini on 10/26/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;

@property (nonatomic, weak) IBOutlet UILabel *detailLabel;

@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;

@end
