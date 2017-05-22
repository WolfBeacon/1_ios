//
//  BaseTableViewCell.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 10/26/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	
	self.topSeparator = NO;
	self.topOffset = 20.f;
	
	self.bottomSeparator = NO;
	self.bottomOffset = 20.f;
	
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	CGRect bounds = self.bounds;
	CGSize size = bounds.size;
	
	if (self.topSeparator) {
		UIBezierPath *beizerPath = [UIBezierPath new];
		[beizerPath moveToPoint:(CGPointMake(self.topOffset, 0))];
		[beizerPath addLineToPoint:(CGPointMake(size.width, 0))];
		beizerPath.lineWidth = 0.5;
		[UIColor.lightGrayColor setStroke];
		[beizerPath stroke];
	}
	
	if (self.bottomOffset) {
		UIBezierPath *beizerPath = [UIBezierPath new];
		[beizerPath moveToPoint:(CGPointMake(self.topOffset, size.height - 0.5))];
		[beizerPath addLineToPoint:(CGPointMake(size.width, size.height - 0.5))];
		beizerPath.lineWidth = 0.5;
		[UIColor.lightGrayColor setStroke];
		[beizerPath stroke];
	}
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
