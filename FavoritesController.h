//
//  FavoritesController.h
//  ProiectBucur
//
//  Created by Radu Bucur on 18/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"
#import "SecondaryViewController.h"

@protocol toDetailsProtocol;

@interface FavoritesController : UIViewController <toDetailsProtocol>



-(void) prepareForTableReload;

@property NSMutableArray *productArray;
@property int ItemSelected;
@property UserProfile * profile;
@property bool tableInitialized;
@property NSString * userToken;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) IBOutlet UIView *tabBar;

@end
