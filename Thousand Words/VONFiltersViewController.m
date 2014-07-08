//
//  VONFiltersViewController.m
//  Thousand Words
//
//  Created by Duri Abdurahman Duri on 7/7/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import "VONFiltersViewController.h"
#import "VONPhotoCollectionViewCell.h"
#import "Photo.h"


@interface VONFiltersViewController ()

@property (strong, nonatomic) NSMutableArray *filters;
@property (strong, nonatomic) CIContext *context;
@end

@implementation VONFiltersViewController

-(NSMutableArray *)filters
{
    if (!_filters) {
        _filters = [[NSMutableArray alloc] init];
    }
    return _filters;
}

-(CIContext *)context
{
    if (!_context)  _context = [CIContext contextWithOptions:nil];
    return _context;
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
    
    self.filters = [[[self class] photoFilters] mutableCopy];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Photo Cell";
    
    VONPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    
    //Implement Multithreading
    dispatch_queue_t filterQueue = dispatch_queue_create("filter queue", NULL);
    
    dispatch_async(filterQueue, ^{
        UIImage *filterImage = [self filteredImageFromImage:self.photo.image andFilter:self.filters[indexPath.row]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = filterImage;
        });
    });
    
    
    
    //    cell.imageView.image = [self filteredImageFromImage:self.photo.image andFilter:self.filters[indexPath.row]];
    
    return cell;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.filters count];
}



#pragma mark - Helper
+ (NSArray *)photoFilters;
{
    CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: nil];
    CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputRadiusKey, @1, nil];
    CIFilter *colorClamp = [CIFilter filterWithName:@"CIColorClamp" keysAndValues:@"inputMaxComponents", [CIVector vectorWithX:0.9 Y:0.9 Z:0.9 W:0.9], @"inputMinComponents", [CIVector vectorWithX:0.2 Y:0.2 Z:0.2 W:0.2], nil];
    
    CIFilter *instant = [CIFilter filterWithName:@"CIPhotoEffectInstant" keysAndValues: nil];
    CIFilter *noir = [CIFilter filterWithName:@"CIPhotoEffectNoir" keysAndValues: nil];
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignetteEffect" keysAndValues: nil];
    CIFilter *colorControl = [CIFilter filterWithName:@"CIColorControls" keysAndValues: kCIInputSaturationKey, @0.5, nil];
    
    CIFilter *transfer = [CIFilter filterWithName:@"CIPhotoEffectTransfer" keysAndValues: nil];
    CIFilter *unsharpen = [CIFilter filterWithName:@"CIUnsharpMask" keysAndValues: nil];
    CIFilter *monochrome = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues: nil];
    
    NSArray *allFilters = @[sepia, blur, colorClamp, instant, noir, vignette, colorControl, transfer, unsharpen, monochrome];
    
    return allFilters;
    
}

-(UIImage *)filteredImageFromImage:(UIImage *)image andFilter:(CIFilter *)filter
{
    CIImage *unfilteredImage = [[CIImage alloc] initWithCGImage:image.CGImage];
    
    [filter setValue:unfilteredImage forKey:kCIInputImageKey];
    
    CIImage *filteredImage = [filter outputImage];
    CGRect extent = [filteredImage extent];
    CGImageRef cgImage = [self.context createCGImage:filteredImage fromRect:extent];
    UIImage *finalImage = [UIImage imageWithCGImage:cgImage];
    
    return finalImage;
}



#pragma mark - CollectionView Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    VONPhotoCollectionViewCell *selectedCell = (VONPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    self.photo.image = selectedCell.imageView.image;
    
    if (self.photo.image) {
        
        
        
        NSError *error = nil;
        
        if (![[self.photo managedObjectContext] save:&error]) {
            NSLog(@"%@", error);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
