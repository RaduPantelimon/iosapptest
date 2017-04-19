//
//  UserProfile.h
//  ProiectBucur
//
//  Created by Radu Bucur on 18/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "ColorTheme.h"

@interface UserProfile : NSObject <NSCoding>{
    NSMutableArray *favorites;
    NSString * Name;
    NSString * UserID;
    NSData * image;
    NSString * Username;
    ColorTheme * theme;
}

@property NSMutableArray *favorites;
@property NSString * Name;
@property NSString * UserID;
@property NSData * image;
@property NSString * Username;
@property ColorTheme * theme;

-(id)initWithProps:(NSString *)Name
            UserID:(NSString *)UserID;

@end
