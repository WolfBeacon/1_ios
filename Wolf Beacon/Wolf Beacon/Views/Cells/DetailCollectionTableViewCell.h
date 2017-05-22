//
//  DetailCollectionTableViewCell.h
//  Wolf Beacon
//
//  Created by Avikant Saini on 10/26/16.
//  Copyright © 2016 Wolf Beacon. All rights reserved.
//

#import "BaseTableViewCell.h"

#import "DetailCollectionViewCell.h"

@interface DetailCollectionTableViewCell : BaseTableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

- (void)setCollectionViewDataSourceDelegate:(id)dss forRow:(NSInteger)row;

@end


