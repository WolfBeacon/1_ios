//
//  DetailCollectionTableViewCell.m
//  Wolf Beacon
//
//  Created by Avikant Saini on 10/26/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import "DetailCollectionTableViewCell.h"

@implementation DetailCollectionTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setCollectionViewDataSourceDelegate:(id)dss forRow:(NSInteger)row {
	[self.collectionView registerNib:[UINib nibWithNibName:@"DetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
	self.collectionView.dataSource = dss;
	self.collectionView.delegate = dss;
	self.collectionView.tag = row;
	self.collectionView.accessibilityLabel = [NSString stringWithFormat:@"%li", row];
	[self.collectionView reloadData];
}

@end
