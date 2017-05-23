//
//  LoginContainerView.h
//  Wolf Beacon
//
//  Created by Avikant Saini on 5/23/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginContainerView : UIView

@property (nonatomic) IBInspectable UIColor *outlineColor;

@property (nonatomic) IBInspectable CGFloat lineWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;

@property (nonatomic) IBInspectable BOOL drawsCenterLine;

@end
