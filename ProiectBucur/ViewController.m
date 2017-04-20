//
//  ViewController.m
//  ProiectBucur
//
//  Created by Radu Bucur on 17/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "AFNetworking.h"
#import "Product.h"
#import "CustomCell.h"
#import "SecondaryViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //initializing login button
    /*FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    
    // setting the facebook button position
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGPoint origin = CGPointMake(screenWidth/2, screenHeight - 100);
    
    // Optional: Place the button in the center of your view.
    loginButton.center = origin;
    [self.view addSubview:loginButton];*/
    self.productArray = [[NSMutableArray alloc] init];
    self.displayArray = [[NSMutableArray alloc] init];
    if ([FBSDKAccessToken currentAccessToken]) {
        
        
        // User is logged in, do work such as go to next view controller.
        [self getProducts];
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
        
        
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self unarchiveProfile];
    
    if(self.tableInitialized == true)
    {
        //setting pictures
        for(int i=0; i< self.displayArray.count;i++)
        {
            NSIndexPath * indexpath = [NSIndexPath indexPathForRow:i inSection:0];
            CustomCell * customCell = [self.table cellForRowAtIndexPath:indexpath];
            
            Product * currentProduct = self.displayArray[i];
            
            int prdID = [currentProduct productId];
            int foundAt = [self findFavorite: prdID ];
            
            if(foundAt != -1)
            {
                UIImage * image = [UIImage imageNamed:@"Selected"];
                [customCell.customFavoritesButton setImage:image forState:UIControlStateNormal];
            }else{
                UIImage * image = [UIImage imageNamed:@"Deselected"];
                [customCell.customFavoritesButton setImage:image forState:UIControlStateNormal];
            }
            
        }
        
        
        
    }
    
    if(self.profile.theme != nil)
    {
        [self.profile.theme setTheme:self.view navigationBar:self.navBar tabBar:self.tabBar];
        
        self.table.backgroundView = nil;
        
        UIColor * bckgCol = [self.profile.theme colorWithHexString:self.profile.theme.tabbarColorhex ];
        self.table.backgroundColor =bckgCol;

    }
    [self.table reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getProducts
{
    // 1
    NSString *string = @"https://api.myjson.com/bins/13jnev";
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        
        NSArray * productsArray = (NSArray*)responseObject;
        
        
        
        for (int i = 0; i < productsArray.count; i++) {
            Product * product =[[Product alloc] initWithProps:productsArray[i]];
            //getting image
            NSURL *imgURL = [[NSURL alloc]initWithString:product.imageUrl];
            NSData *data = [NSData dataWithContentsOfURL:imgURL];
            product.image = data;
            
            [self.productArray addObject: product];
        }
        
        self.tableInitialized = true;
        [self.displayArray addObjectsFromArray:self.productArray];
        [self.table reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
    }];
    
    // 5
    [operation start];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.displayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * cellId = @"cell";
    CustomCell * customCell = [tableView dequeueReusableCellWithIdentifier: cellId];
    
    Product * currentProduct = [self.displayArray objectAtIndex:indexPath.row];
    customCell.customCode.text = currentProduct.productCode;
    customCell.customName.text = currentProduct.productName;
    customCell.customPrice.text = [NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%.02f", currentProduct.price],@" $"];
    
    //adding pictures to the cell
    if(currentProduct.image != nil)
    {
        customCell.customPicture.image = [UIImage imageWithData: currentProduct.image];
    }
    else{
        
        NSURL *imgURL = [[NSURL alloc]initWithString:currentProduct.imageUrl];
        NSData *data = [NSData dataWithContentsOfURL:imgURL];
        currentProduct.image = data;
        customCell.customPicture.image = [UIImage imageWithData: data];

    }

    if(self.profile.theme != nil)
    {
        [self.profile.theme setTheme:self.view navigationBar:self.navBar tabBar:self.tabBar];
        
        UIColor * bckgCol = [self.profile.theme colorWithHexString:self.profile.theme.tabbarColorhex ];
        customCell.backgroundColor =bckgCol;
    }
    
    customCell.customPicture.layer.cornerRadius = customCell.customPicture.frame.size.width/2;
    customCell.customPicture.layer.borderWidth = 3.0f;
    customCell.customPicture.layer.borderColor = [UIColor blueColor].CGColor;
    customCell.customPicture.clipsToBounds = YES;
    
    customCell.customDetailsButton.tag = indexPath.row;
    
    [customCell.customDetailsButton addTarget:self action:@selector(GoToSecondary:) forControlEvents:UIControlEventTouchUpInside];
    [customCell.customFavoritesButton addTarget:self action:@selector(SetFavorites:) forControlEvents:UIControlEventTouchUpInside];
    
    //finding if the current cell is favorited or not
    bool foundItem = false;
    
    for(int i=0;i<self.profile.favorites.count;i++)
    {
        if([self.profile.favorites[i] productId] == [currentProduct productId])
        {
            foundItem = true;
        }
    }
    
    if(foundItem)
    {
        UIImage * image = [UIImage imageNamed:@"Selected"];
        [customCell.customFavoritesButton setImage:image forState:UIControlStateNormal];
    }
    else{
        UIImage * image = [UIImage imageNamed:@"Deselected"];
        [customCell.customFavoritesButton setImage:image forState:UIControlStateNormal];

    }
    
    /*[customCell.customDetailsButton addTarget:currentProduct action:@selector(GoToSecondary:) forControlEvents:UIControlEventTouchUpInside];*/
    return customCell;
    
}


- (IBAction)GoToSecondary:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView: self.table];
    NSIndexPath * indexpath = [self.table indexPathForRowAtPoint:buttonPosition];

    
    self.ItemSelected = (int) indexpath.row;
    [self performSegueWithIdentifier:@"details" sender:@"detailsButton"];
}

- (IBAction)SetFavorites:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView: self.table];
    NSIndexPath * indexpath = [self.table indexPathForRowAtPoint:buttonPosition];
    Product *currentProduct = [self.displayArray objectAtIndex:indexpath.row];
    int foundAt = -1;
    
    for(int i=0; i< self.profile.favorites.count;i++)
    {
        if([self.profile.favorites[i] productId] == [currentProduct productId])
        {
            foundAt = i;
        }
    }
    
    UIButton * buttonSender = (UIButton *)sender;
    if(foundAt != -1)
    {
        [self.profile.favorites removeObjectAtIndex:foundAt];
        UIImage * image = [UIImage imageNamed:@"Deselected"];
        [buttonSender setImage:image forState:UIControlStateNormal];
        
    }
    else
    {
        
        [self.profile.favorites addObject:currentProduct];
        UIImage * image = [UIImage imageNamed:@"Selected"];
        [buttonSender setImage:image forState:UIControlStateNormal];
        
    }
    
    //archiving the new profile and displaying it
    NSData *archivedProfile = [NSKeyedArchiver archivedDataWithRootObject:self.profile];
    [[NSUserDefaults standardUserDefaults] setObject:archivedProfile forKey:self.userToken];
    
    
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if([searchText length] == 0)
    {
        [self.displayArray removeAllObjects];
        [self.displayArray addObjectsFromArray:self.productArray];
        
    }
    else{
        [self.displayArray removeAllObjects];
        for(int i=0; i<self.productArray.count; i++)
        {
            Product *p = self.productArray[i];
            
            NSRange name = [p.productName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange code = [p.productCode rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(name.location != NSNotFound || code.location != NSNotFound)
            {
                [self.displayArray addObject:p];
            }
        }
        
    }
    [self.table reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    Product * selectedProduct = [self.displayArray objectAtIndex:self.ItemSelected];

    int foundAt = -1;
    
    for(int i=0; i< self.profile.favorites.count;i++)
    {
        if([self.profile.favorites[i] productId] == [selectedProduct productId])
        {
            foundAt = i;
        }
    }

    
    SecondaryViewController *destination=segue.destinationViewController;
    destination.selectedProduct = selectedProduct;
    destination.userToken = self.userToken;
    destination.delegate = self;
    
    if(foundAt != -1)
    {
        destination.isFavorite = true;
        
    }else{
        
        destination.isFavorite = false;
    }
    
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
        [self.profile.favorites addObject:currentpj];
    }

    //archiving the new profile and displaying it
    NSData *archivedProfile = [NSKeyedArchiver archivedDataWithRootObject:self.profile];
    [[NSUserDefaults standardUserDefaults] setObject:archivedProfile forKey:self.userToken];
    
    NSLog(@"%d",productId);
}





-(int) findFavorite: (int) productId{
    int foundAt = -1;
    
    for(int i=0; i< self.profile.favorites.count;i++)
    {
        if([self.profile.favorites[i] productId] == productId)
        {
            foundAt = i;
        }
    }
    return foundAt;
}

-(void) unarchiveProfile{
    
    NSUserDefaults * currentDefualts = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedUser = [currentDefualts objectForKey: self.userToken];
    if(dataRepresentingSavedUser != nil)
    {
        self.profile = [NSKeyedUnarchiver unarchiveObjectWithData: dataRepresentingSavedUser];
    }
    else{
        self.profile = [[UserProfile alloc ] initWithProps:self.userToken UserID:self.userToken];
    }

}



@end;


















