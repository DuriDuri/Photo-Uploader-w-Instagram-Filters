//
//  VONCoreDataHelper.m
//  Thousand Words
//
//  Created by Duri Abdurahman Duri on 7/5/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import "VONCoreDataHelper.h"

@implementation VONCoreDataHelper

+(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

@end
