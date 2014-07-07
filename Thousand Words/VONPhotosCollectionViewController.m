//
//  VONPhotosCollectionViewController.m
//  Thousand Words
//
//  Created by Duri Abdurahman Duri on 7/5/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import "VONPhotosCollectionViewController.h"
#import "VONPhotoCollectionViewCell.h"
#import "Photo.h"
#import "VONPictureDataTransformer.h"
#import "VONCoreDataHelper.h"
#import "VONPhotoDetailViewController.h"

@interface VONPhotosCollectionViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation VONPhotosCollectionViewController

-(NSMutableArray *)photos
{
    if (!_photos) _photos = [[NSMutableArray alloc] init];
    return _photos;
}

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSSet *unordereredPhotos = self.album.photos;
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    NSArray *sortedPhotos = [unordereredPhotos sortedArrayUsingDescriptors:@[dateDescriptor]];
    self.photos = [sortedPhotos mutableCopy];
    
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraButtonPressed:(UIBarButtonItem *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentViewController:picker animated:YES completion:nil];
}



#pragma mark - CollectionView DataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Photo Cell";
    
    VONPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Photo *photo = [self.photos objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = photo.image;
    
    return cell;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photos count];
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if(!image) image = info[UIImagePickerControllerOriginalImage];
    
    [self.photos addObject:[self photoFromImage:image]];
    
    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Helper Methods

-(Photo *) photoFromImage:(UIImage *)image
{
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:[VONCoreDataHelper managedObjectContext]];
    
    photo.image = image;
    photo.date = [NSDate date];
    photo.albumBook = self.album;
    
    
    NSError *error = nil;
    if (![[photo managedObjectContext] save:&error]) {
        NSLog(@"%@", error);
    }
    
    
    return photo;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Detail Segue"]) {
        if ([segue.destinationViewController isKindOfClass:[VONPhotoDetailViewController class]]) {
            VONPhotoDetailViewController *detailPhotoVC = segue.destinationViewController;
            NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
            detailPhotoVC.photo = [self.photos objectAtIndex:indexPath.row];
        }
    }
}

    


@end
