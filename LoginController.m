//
//  LoginController.m
//  ProiectBucur
//
//  Created by Radu Bucur on 20/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import "LoginController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface LoginController ()<FBSDKLoginButtonDelegate>

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    //initializing login button
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
   
    loginButton.delegate = self;
    
    // setting the facebook button position
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGPoint origin = CGPointMake(screenWidth/2, screenHeight - 100);
    
    // Optional: Place the button in the center of your view.
    loginButton.center = origin;
    [self.view addSubview:loginButton];
    if ([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"user logat");
    }
}



- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error{
    if ([FBSDKAccessToken currentAccessToken]) {
        
        //going to main section of the application
        [self performSegueWithIdentifier:@"toHome" sender:@"loginButton"];
        
    }
}
- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    if ([FBSDKAccessToken currentAccessToken]) {
        
        //going to main section of the application
        [self performSegueWithIdentifier:@"toHome" sender:@"loginButton"];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GoToApplication:(id)sender {
    if ([FBSDKAccessToken currentAccessToken]) {
        
        //going to main section of the application
        [self performSegueWithIdentifier:@"toHome" sender:@"loginButton"];
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unauthorized" message:@"You must first login in order to access the application" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
    }
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
