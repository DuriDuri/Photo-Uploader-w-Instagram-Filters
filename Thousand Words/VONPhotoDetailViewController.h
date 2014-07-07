//
//  VONPhotoDetailViewController.h
//  Thousand Words
//
//  Created by Duri Abdurahman Duri on 7/7/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

@interface VONPhotoDetailViewController : UIViewController

@property (strong, nonatomic) Photo *photo;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;


- (IBAction)addFilterButtonPressed:(UIButton *)sender;

- (IBAction)deleteButtonPressed:(UIButton *)sender;

@end
