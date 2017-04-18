//
//  FavoritesController.m
//  ProiectBucur
//
//  Created by Radu Bucur on 18/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import "FavoritesController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Product.h"
#import "FavoritesCell.h"
#import "SecondaryViewController.h"

@interface FavoritesController ()<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation FavoritesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([FBSDKAccessToken currentAccessToken]) {
        
        [self prepareForTableReload];
        
    }


}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self prepareForTableReload];
    if(self.tableInitialized == true)
    {
        
        [self.table reloadData];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table interface

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.profile.favorites.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * cellId = @"cell";
    FavoritesCell * favoritesCell = [tableView dequeueReusableCellWithIdentifier: cellId];
    
    Product * currentProduct = [self.profile.favorites objectAtIndex:indexPath.row];
    favoritesCell.customCode.text = currentProduct.productCode;
    favoritesCell.customName.text = currentProduct.productName;
    favoritesCell.customPrice.text = [NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%.02f", currentProduct.price],@" $"];
    
    //adding pictures to the cell
    //NSURL *imgURL = [[NSURL alloc]initWithString:currentProduct.imageUrl];
    //NSData *data = [NSData dataWithContentsOfURL:imgURL];
    //currentProduct.image = data;
    favoritesCell.customPicture.image = [UIImage imageWithData: currentProduct.image];
    
    favoritesCell.customPicture.layer.cornerRadius = favoritesCell.customPicture.frame.size.width/2;
    favoritesCell.customPicture.layer.borderWidth = 3.0f;
    favoritesCell.customPicture.layer.borderColor = [UIColor blueColor].CGColor;
    favoritesCell.customPicture.clipsToBounds = YES;
    
    favoritesCell.customDetailsButton.tag = indexPath.row;
    
    [favoritesCell.customDetailsButton addTarget:self action:@selector(GoToSecondary:) forControlEvents:UIControlEventTouchUpInside];
    /*[favoritesCell.customFavoritesButton addTarget:self action:@selector(SetFavorites:) forControlEvents:UIControlEventTouchUpInside];*/
    
    UIImage * image = [UIImage imageNamed:@"Selected"];
    [favoritesCell.customFavoritesButton setImage:image forState:UIControlStateNormal];
    
    /*[customCell.customDetailsButton addTarget:currentProduct action:@selector(GoToSecondary:) forControlEvents:UIControlEventTouchUpInside];*/
    return favoritesCell;
    
}


-(void) prepareForTableReload{
    // User is logged in, do work such as go to next view controller.
    NSLog(@"user logat");
    NSString * userid = [[FBSDKAccessToken currentAccessToken] userID];
    self.userToken = userid;
    
    
    NSUserDefaults * currentDefualts = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedUser = [currentDefualts objectForKey: userid];
    if(dataRepresentingSavedUser != nil)
    {
        self.profile = [NSKeyedUnarchiver unarchiveObjectWithData: dataRepresentingSavedUser];
    }
    else{
        self.profile = [[UserProfile alloc ] initWithProps:userid UserID:userid];
    }
    
    self.tableInitialized = true;
    self.productArray = [self.profile.favorites copy]; //[[NSMutableArray init] initWithArray:self.profile.favorites copyItems:YES ];
}

- (IBAction)GoToSecondary:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView: self.table];
    NSIndexPath * indexpath = [self.table indexPathForRowAtPoint:buttonPosition];
    
    
    self.ItemSelected = (int) indexpath.row;
    [self performSegueWithIdentifier:@"details" sender:@"detailsButton"];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    Product * selectedProduct = [self.profile.favorites objectAtIndex:self.ItemSelected];
    SecondaryViewController *destination=segue.destinationViewController;
    destination.selectedProduct = selectedProduct;
    destination.delegate = self;

    destination.isFavorite = true;
}


#pragma mark - Protocol Arguments

-(void) changeFavorite: (int) productId{
    
    int foundAt = -1;
    
    for(int i=0; i< self.profile.favorites.count;i++)
    {
        if([self.profile.favorites[i] productId] == productId)
        {
            foundAt = i;
        }
    }
    
    if(foundAt != -1)
    {
        [self.profile.favorites removeObjectAtIndex:foundAt];
        
    }
    else
    {
        Product * currentpj;
        for(int i=0; i< self.productArray.count;i++)
        {
            if([self.productArray[i] productId] == productId)
            {
                currentpj = self.productArray[i];
            }
        }
        if(currentpj != nil)
        {
            [self.profile.favorites addObject:currentpj];

        }
    }
    
    //archiving the new profile and displaying it
    NSData *archivedProfile = [NSKeyedArchiver archivedDataWithRootObject:self.profile];
    [[NSUserDefaults standardUserDefaults] setObject:archivedProfile forKey:self.userToken];
    
    NSLog(@"%d",productId);
}


@end
