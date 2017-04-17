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

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //initializing login button
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    
    // setting the facebook button position
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGPoint origin = CGPointMake(screenWidth/2, screenHeight - 100);
    
    // Optional: Place the button in the center of your view.
    loginButton.center = origin;
    [self.view addSubview:loginButton];
    self.productArray = [[NSMutableArray alloc] init];
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        NSLog(@"user logat");
        [self getProducts];
    }
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
            [self.productArray addObject: product];
        }
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
    
    return self.productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * cellId = @"cell";
    CustomCell * customCell = [tableView dequeueReusableCellWithIdentifier: cellId];
    
    Product * currentProduct = [self.productArray objectAtIndex:indexPath.row];
    customCell.customCode.text = currentProduct.productCode;
    customCell.customName.text = currentProduct.productName;
    customCell.customPrice.text = [NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%.02f", currentProduct.price],@" $"];
    
    
    NSURL *imgURL = [[NSURL alloc]initWithString:currentProduct.imageUrl];
    NSData *data = [NSData dataWithContentsOfURL:imgURL];
    customCell.customPicture.image = [UIImage imageWithData: data];
    
    return customCell;
    
}


@end;


























