//
//  PiBigCollectionCell.h
//  Picourse
//
//  Created by BILLY HO on 10/30/13.
//  Copyright (c) 2013 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PiBigCollectionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *photo;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *compangLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateNplaceLabel;

@end
