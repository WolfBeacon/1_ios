//
//  DetailInformationTableViewCell.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 10/26/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import "DetailInformationTableViewCell.h"

@implementation DetailInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	
	self.showMoreButton.hidden = YES;
}

- (void)setDetailText:(NSString *)detailText {
	_detailText = detailText;
	self.detailTextLabel.text = detailText;
}

- (void)setExpanded:(BOOL)expanded {
	_expanded = expanded;
	self.showMoreButton.hidden = expanded;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)estimatedHeightForText:(NSString *)text {
	CGRect rect = [text boundingRectWithSize:CGSizeMake(SWidth - 16, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: globalFont12} context:nil];
	return rect.size.height;
	return 0.f;
}

@end
