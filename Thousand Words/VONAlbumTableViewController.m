//
//  VONAlbumTableViewController.m
//  Thousand Words
//
//  Created by Duri Abdurahman Duri on 7/5/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import "VONAlbumTableViewController.h"
#import "Album.h"
#import "VONCoreDataHelper.h"
#import "VONPhotosCollectionViewController.h"

@interface VONAlbumTableViewController () <UIAlertViewDelegate>

@end

@implementation VONAlbumTableViewController

-(NSMutableArray *)albums{
    if(!_albums) _albums = [[NSMutableArray alloc] init];
    return _albums;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
    
//    id delegate = [[UIApplication sharedApplication] delegate];
//    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSError *error = nil;
    
    NSArray *fetchedAlbums = [[VONCoreDataHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    self.albums = [fetchedAlbums mutableCopy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -IB Actions
- (IBAction)createAlbumButtonPressed:(UIBarButtonItem *)sender {
    
    UIAlertView *createAlbum = [[UIAlertView alloc] initWithTitle:@"Create new album" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    
    [createAlbum setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [createAlbum show];
    
    
}




#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *albumName = [alertView textFieldAtIndex:0].text;
        
        Album *newAlbum = [self albumWithName:albumName];
        
        
        [self.albums addObject:newAlbum];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.albums count]-1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.albums count];
}



#pragma amrk -Helper Methods

-(Album *) albumWithName:(NSString *)name{
    
    NSManagedObjectContext *context = [VONCoreDataHelper managedObjectContext];
    
    Album *album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    album.name = name;
    album.date = [NSDate date];
    
    NSError *error = nil;
    if (![context save:&error])
    {
        //We have an error
    }
    
    return album;
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Album *album = [self.albums objectAtIndex:indexPath.row];
   
    cell.textLabel.text = album.name;
    
    return cell;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Album Chosen"]) {
        if ([segue.destinationViewController isKindOfClass:[VONPhotosCollectionViewController class]]) {
            NSIndexPath *path = [self.tableView indexPathForSelectedRow];
            
            VONPhotosCollectionViewController *targetVC = segue.destinationViewController;
            targetVC.album = [self.albums objectAtIndex:path.row];
        }
    }
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/





@end
