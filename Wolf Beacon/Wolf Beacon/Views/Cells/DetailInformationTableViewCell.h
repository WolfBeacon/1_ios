//
//  DetailInformationTableViewCell.h
//  Wolf Beacon
//
//  Created by Avikant Saini on 10/26/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailInformationTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UILabel *detailLabel;
@property (nonatomic) NSString *detailText;

@property (nonatomic, weak) IBOutlet UIButton *showMoreButton;

@property (nonatomic) BOOL expanded;

+ (CGFloat)estimatedHeightForText:(NSString *)text;

@end
