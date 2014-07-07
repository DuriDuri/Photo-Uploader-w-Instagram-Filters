//
//  VONPhotosCollectionViewController.h
//  Thousand Words
//
//  Created by Duri Abdurahman Duri on 7/5/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"
@interface VONPhotosCollectionViewController : UICollectionViewController 

@property (strong, nonatomic) Album *album;
@property (strong, nonatomic) NSMutableArray *photos;


- (IBAction)cameraButtonPressed:(UIBarButtonItem *)sender;

@end
