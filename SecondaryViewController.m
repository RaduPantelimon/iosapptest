//
//  SecondaryViewController.m
//  ProiectBucur
//
//  Created by Radu Bucur on 17/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import "SecondaryViewController.h"
#import "ViewController.h"

@interface SecondaryViewController ()

@end

@implementation SecondaryViewController


@synthesize delegate;


-(void)viewWillAppear:(BOOL)animated
{
    if(self.isFavorite == true)
    {
        UIImage * image = [UIImage imageNamed:@"Selected"];
        [self.favoriteButton setImage:image forState:UIControlStateNormal];
    }
    NSLog(@"View launched");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)FavoriteClick:(id)sender {
    
    [[self delegate] changeFavorite:self.selectedProduct.productId];
    if(self.isFavorite)
    {
        UIImage * image = [UIImage imageNamed:@"Deselected"];
        [self.favoriteButton setImage:image forState:UIControlStateNormal];
    }
    else{
        UIImage * image = [UIImage imageNamed:@"Selected"];
        [self.favoriteButton setImage:image forState:UIControlStateNormal];
    }
    self.isFavorite = !self.isFavorite;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
