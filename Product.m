//
//  Product.m
//  ProiectBucur
//
//  Created by Radu Bucur on 17/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import "Product.h"

@implementation Product



@synthesize productId;
@synthesize productName;
@synthesize productCode;
@synthesize productDescription;
@synthesize releaseDateString;
@synthesize  price;
@synthesize starRating;
@synthesize imageUrl;


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

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {

        
        self.productId = [decoder decodeIntForKey:@"productId"];
        self.productName = [decoder decodeObjectForKey:@"productName"];
        self.productCode = [decoder decodeObjectForKey:@"productCode"];
        self.releaseDateString = [decoder decodeObjectForKey:@"releaseDate"];
        self.price = [decoder decodeFloatForKey:@"price"];
        self.starRating =[decoder decodeFloatForKey:@"starRating"];
        self.imageUrl = [decoder decodeObjectForKey:@"imageUrl"];
        self.productDescription = [decoder decodeObjectForKey:@"description"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    /*[encoder encodeObject:title forKey:@"title"];
    [encoder encodeObject:author forKey:@"author"];
    [encoder encodeBool:published forKey:@"published"];*/
    
    [encoder encodeInt:productId forKey:@"productId"];
    [encoder encodeObject:productName forKey:@"productName"];
    [encoder encodeObject:productCode forKey:@"productCode"];
    [encoder encodeObject:releaseDateString forKey:@"releaseDate"];
    [encoder encodeObject:imageUrl forKey:@"imageUrl"];
    [encoder encodeObject:productName forKey:@"productName"];
    [encoder encodeObject:productName forKey:@"productName"];
    [encoder encodeFloat:price forKey:@"price"];
    [encoder encodeFloat:starRating forKey:@"starRating"];
    
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
