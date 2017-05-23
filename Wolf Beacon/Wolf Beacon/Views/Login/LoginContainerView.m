//
//  LoginContainerView.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/23/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import "LoginContainerView.h"

@implementation LoginContainerView

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	UIBezierPath *beizerPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];
	[beizerPath setLineWidth:self.lineWidth];
	[self.outlineColor setStroke];
	[beizerPath stroke];
	
	if (self.drawsCenterLine) {
		UIBezierPath *centerPath = [UIBezierPath bezierPath];
		[centerPath moveToPoint:CGPointMake(rect.origin.x, rect.size.height/2.f)];
		[centerPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height/2.f)];
		[centerPath setLineWidth:self.lineWidth];
		[self.outlineColor setStroke];
		[centerPath stroke];
	}
}


@end
