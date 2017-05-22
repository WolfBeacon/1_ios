//
//  DetailHeaderTableViewCell.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 10/26/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import "DetailHeaderTableViewCell.h"

@implementation DetailHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	
	self.locationButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	self.locationButton.titleLabel.numberOfLines = 0;
	self.locationButton.titleLabel.textAlignment = NSTextAlignmentLeft;
	self.locationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	self.locationButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	self.locationButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
	
	self.timeSlotButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	self.timeSlotButton.titleLabel.textAlignment = NSTextAlignmentLeft;
	
	self.applyButton.layer.borderWidth = 1.0;
	self.applyButton.layer.borderColor = self.applyButton.tintColor.CGColor;
	self.applyButton.layer.cornerRadius = 4.0;
	[self.applyButton setTitle:@"APPLY" forState:UIControlStateNormal];
	
	self.logoImageView.layer.cornerRadius = 20.0;
//	self.logoImageView.layer.backgroundColor = UIColor.flatWhiteColor().CGColor
	self.logoImageView.layer.masksToBounds = YES;
	
}

- (void)setHackathon:(Hackathon *)hackathon {
	_hackathon = hackathon;
	self.titleLabel.text = hackathon.name;
	self.fromDate = hackathon.startDate;
	self.toDate = hackathon.endDate;
	[self setLocationText:[NSString stringWithFormat:@"%@, %@ ❯", hackathon.host, hackathon.location]];
	[self.logoImageView sd_setImageWithURL:[NSURL URLWithString:hackathon.imageLink]];
	self.applyButton.hidden = ([hackathon.endDate compare:[NSDate date]] == NSOrderedAscending);
}

- (void)setLocationText:(NSString *)text {
	[self.locationButton setTitle:text forState:UIControlStateNormal];
}

- (void)setFromDate:(NSDate *)fromDate {
	_fromDate = fromDate;
	if (self.toDate != nil)
		[self updateTimeButtonTitle];
}

- (void)setToDate:(NSDate *)toDate {
	_toDate = toDate;
	if (self.fromDate != nil)
		[self updateTimeButtonTitle];
}

- (void)updateTimeButtonTitle {
	NSDateFormatter *formatter = [NSDateFormatter new];
	[formatter setDateFormat:@"EEE, MMM dd, hh:mm a"];
	[self.timeSlotButton setTitle:[NSString stringWithFormat:@"%@ - %@ ❯", [formatter stringFromDate:self.fromDate], [formatter stringFromDate:self.toDate]] forState:UIControlStateNormal];
	CGFloat rtime = [[NSDate date] timeIntervalSinceDate:self.toDate];
	if (rtime > 0) {
		self.remainingProgressView.progress = 0;
		self.remainingLabel.text = @"This event has ended";
	} else {
		CGFloat ttime = [self.fromDate timeIntervalSinceDate:self.toDate];
		CGFloat dtime = -ttime + rtime;
		self.remainingLabel.text = [self hmstime:fabs(rtime)];
		self.remainingProgressView.progress = dtime/fabs(ttime);
	}
}

- (NSString *)hmstime:(CGFloat)secs {
	NSInteger h, m, s;
	s = secs;
	h = s / 3600;
	s -= h * 3600;
	m = s / 60;
	return [NSString stringWithFormat:@"%@%li mimutes till the event ends.", (h > 0) ? [NSString stringWithFormat:@"%li hour%@, ", h, (h == 1)?@"":@"s"] : @"", m];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
