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
//#import "TableViewController.h"
#import "AFNetworking.h"

#import "Product.h"

@interface ViewController ()
@property(strong) NSDictionary *weather;
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
    NSString *string = @"https://api.myjson.com/bins/hk39r";
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        //self.weather = (NSDictionary *)responseObject;
        //self.title = @"JSON Retrieved";
        
        NSArray * productsArray = (NSArray*)responseObject;
        
        //[self.tableView reloadData];
        
        self.productArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < productsArray.count; i++) {
            Product * product =[[Product alloc] initWithProps:productsArray[0]];
            [self.productArray addObject: product];
        }
        //we save the data
        
        
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


@end;
