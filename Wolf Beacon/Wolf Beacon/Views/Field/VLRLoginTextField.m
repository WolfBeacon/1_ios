//
//  VLRLoginTextField.m
//  Digital Dhobi
//
//  Created by Avikant Saini on 12/9/16.
//  Copyright © 2016 darkarmy. All rights reserved.
//

#import "VLRLoginTextField.h"

@implementation VLRLoginTextField

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
    // Drawing code
	
	if (self.drawsLine) {
		UIBezierPath *beizerPath = [UIBezierPath bezierPath];
		[beizerPath moveToPoint:CGPointMake(0, self.bounds.size.height - 0.5)];
		[beizerPath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height - 0.5)];
		[beizerPath setLineWidth:0.5];
		[beizerPath setLineCapStyle:kCGLineCapRound];
		[beizerPath setLineJoinStyle:kCGLineJoinRound];
		[self.placeholderColor setStroke];
		[beizerPath stroke];
	}
	
}

@end
