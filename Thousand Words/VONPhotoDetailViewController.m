//
//  VONPhotoDetailViewController.m
//  Thousand Words
//
//  Created by Duri Abdurahman Duri on 7/7/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import "VONPhotoDetailViewController.h"
#import "Photo.h"
#import "VONFiltersViewController.h"

@interface VONPhotoDetailViewController ()

@end

@implementation VONPhotoDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.imageView.image = self.photo.image;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Filter Segue"]) {
        if ([segue.destinationViewController isKindOfClass:[VONFiltersViewController class]]) {
            VONFiltersViewController *nextFilterVC = segue.destinationViewController;
            nextFilterVC.photo = self.photo;
        }
    }
}


- (IBAction)addFilterButtonPressed:(UIButton *)sender {
}

- (IBAction)deleteButtonPressed:(UIButton *)sender {
    [[self.photo managedObjectContext] deleteObject:self.photo];
    
    NSError *error = nil;
    [[self.photo managedObjectContext] save:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    
}
@end
