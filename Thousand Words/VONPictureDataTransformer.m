//
//  VONPictureDataTransformer.m
//  Thousand Words
//
//  Created by Duri Abdurahman Duri on 7/6/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import "VONPictureDataTransformer.h"

@implementation VONPictureDataTransformer



+(Class) transformedValueClass
{
    return [NSData class];
}

+(BOOL)allowsReverseTransformation
{
    return YES;
}


-(id)transformedValue:(id)value
{
    return UIImagePNGRepresentation(value);
}

-(id)reverseTransformedValue:(id)value
{
    UIImage *image = [UIImage imageWithData:value];
    return image;
}


@end
