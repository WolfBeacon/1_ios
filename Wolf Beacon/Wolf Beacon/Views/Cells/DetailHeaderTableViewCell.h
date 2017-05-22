//
//  DetailHeaderTableViewCell.h
//  Wolf Beacon
//
//  Created by Avikant Saini on 10/26/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface DetailHeaderTableViewCell : BaseTableViewCell

@property (nonatomic) Hackathon *hackathon;

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *locationButton;

@property (weak, nonatomic) IBOutlet UIButton *timeSlotButton;

@property (weak, nonatomic) IBOutlet UIButton *applyButton;

@property (weak, nonatomic) IBOutlet UIProgressView *remainingProgressView;

@property (weak, nonatomic) IBOutlet UILabel *remainingLabel;

@property (nonatomic) NSDate *toDate, *fromDate;

- (void)setLocationText:(NSString *)text;

- (void)updateTimeButtonTitle;

@end
