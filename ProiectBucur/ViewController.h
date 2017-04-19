//
//  ViewController.h
//  ProiectBucur
//
//  Created by Radu Bucur on 17/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"
#import "SecondaryViewController.h"

@protocol toDetailsProtocol;

@interface ViewController : UIViewController <toDetailsProtocol>

-(void)getProducts;
-(int) findFavorite: (int) productId;
-(void) unarchiveProfile;
@property NSMutableArray *productArray;
@property NSMutableArray *displayArray;
@property int ItemSelected;
@property UserProfile * profile;
@property bool tableInitialized;
@property NSString * userToken;

@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) IBOutlet UIView *tabBar;

@end

