//
//  EventCollectionViewCell.h
//  Wolf Beacon
//
//  Created by Avikant Saini on 1/23/17.
//  Copyright © 2017 Wolf Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (nonatomic) BOOL layoutted;

@end
