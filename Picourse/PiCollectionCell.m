//
//  PiCollectionCell.m
//  Picourse
//
//  Created by Bloodshed on 13-10-10.
//  Copyright (c) 2013年 BILLY HO. All rights reserved.
//

#import "PiCollectionCell.h"


@implementation PiCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"PiCollectionCell" owner:self options:nil];
        
        if(arrayOfViews.count < 1)
        {
            return nil;
        }
        if(![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
