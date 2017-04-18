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

@end
