//
//  ViewController.h
//  ProiectBucur
//
//  Created by Radu Bucur on 17/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"

@interface ViewController : UIViewController

-(void)getProducts;

@property NSMutableArray *productArray;
@property int ItemSelected;
@property UserProfile * profile;

@property NSString * userToken;

@end

