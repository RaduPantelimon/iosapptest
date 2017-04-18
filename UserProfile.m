//
//  UserProfile.m
//  ProiectBucur
//
//  Created by Radu Bucur on 18/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile


@synthesize UserID;
@synthesize Name;
@synthesize favorites;


-(id)initWithProps:(NSString *)AName
            UserID:(NSString *)AUserID{
    
    if( self = [super init] )
    {
        self.UserID = AUserID;
        self.Name = AName;
        self.favorites = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        
        self.UserID = [decoder decodeObjectForKey:@"UserID"];
        self.Name = [decoder decodeObjectForKey:@"Name"];
        self.favorites = [[decoder decodeObjectForKey:@"favorites"] mutableCopy];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:UserID forKey:@"UserID"];
    [encoder encodeObject:Name forKey:@"Name"];
    [encoder encodeObject:favorites forKey:@"favorites"];
    
}


@end