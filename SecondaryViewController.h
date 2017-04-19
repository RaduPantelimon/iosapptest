//
//  SecondaryViewController.h
//  ProiectBucur
//
//  Created by Radu Bucur on 17/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import "ViewController.h"
#import "Product.h"

//protocol to comunicate with the Details view
@protocol toDetailsProtocol <NSObject>

-(void) changeFavorite: (int) productId;

@end

@interface SecondaryViewController : UIViewController

@property(retain)id<toDetailsProtocol> delegate;


@property Product * selectedProduct;
@property bool isFavorite;

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@property (weak, nonatomic) IBOutlet UIImageView *ProductImage;


@property (weak, nonatomic) IBOutlet UILabel *productDescription;

@property (weak, nonatomic) IBOutlet UILabel *productTitle;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *productCode;

@property (strong, nonatomic) IBOutlet UIView *navBar;
@property (strong, nonatomic) IBOutlet UIView *tabBar;

@property NSString * userToken;

@end
