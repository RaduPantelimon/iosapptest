//
//  Product.h
//  ProiectBucur
//
//  Created by Radu Bucur on 17/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject


@property int productId;
@property NSString * productName;
@property NSString * productCode;
@property NSString * releaseDateString;
@property NSString * productDescription;
@property NSDate * releaseDate;
@property float price;
@property float starRating;
@property NSString * imageUrl;

-(id)initWithProps:(NSDictionary *)productDictionary;

@end
