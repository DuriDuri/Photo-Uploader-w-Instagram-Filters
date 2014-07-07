//
//  VONPhotoCollectionViewCell.m
//  Thousand Words
//
//  Created by Duri Abdurahman Duri on 7/6/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import "VONPhotoCollectionViewCell.h"

#define IMAGEVIEW_BORDER_LENGTH 5




@implementation VONPhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) [self setup];
    
    return self;
}


-(void)setup
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, IMAGEVIEW_BORDER_LENGTH, IMAGEVIEW_BORDER_LENGTH)];
    [self.contentView addSubview:self.imageView];
                                                                    
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
