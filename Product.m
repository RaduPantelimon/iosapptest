//
//  Product.m
//  ProiectBucur
//
//  Created by Radu Bucur on 17/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import "Product.h"

@implementation Product

-(id)initWithProps:(NSDictionary *)productDictionary
{
    if( self = [super init] )
    {
        self.productId = [[productDictionary valueForKey:@"productId"] intValue];
        self.productName = (NSString *)[productDictionary valueForKey:@"productName"];
        self.productCode = (NSString *)[productDictionary valueForKey:@"productCode"];
        self.releaseDateString = (NSString *)[productDictionary valueForKey:@"releaseDate"];
        self.price =[ (NSString *)[productDictionary valueForKey:@"price"] doubleValue];
        self.starRating =[ (NSString *)[productDictionary valueForKey:@"starRating"] doubleValue];
        self.imageUrl = (NSString *)[productDictionary valueForKey:@"imageUrl"];
        self.productDescription = (NSString *)[productDictionary valueForKey:@"description"];
    }
    
    return self;
}

@end


/*
 @property int productId;
 @property NSString * productName;
 @property NSString * productCode;
 @property NSString * releaseDateString;
 @property NSDate * releaseDate;
 @property float price;
 @property float starRating;
 @property NSString * imageUrl;
 */
