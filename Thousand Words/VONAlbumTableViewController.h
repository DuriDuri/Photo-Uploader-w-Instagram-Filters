//
//  VONAlbumTableViewController.h
//  Thousand Words
//
//  Created by Duri Abdurahman Duri on 7/5/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VONAlbumTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *albums;

- (IBAction)createAlbumButtonPressed:(UIBarButtonItem *)sender;

@end
