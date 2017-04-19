//
//  ProfileController.m
//  ProiectBucur
//
//  Created by Radu Bucur on 19/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import "ProfileController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Product.h"
#import "ColorTheme.h"

@interface ProfileController ()

@end

@implementation ProfileController

-(void)viewWillAppear:(BOOL)animated
{
    
    [self initialization];
    //adding the userName to the page
    if ([FBSDKAccessToken currentAccessToken]) {
        if(self.profile.Username != nil)
        {
             self.NameLabel.text = self.profile.Username;
        }
        else{
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,name,picture.width(100).height(100)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    NSString *nameOfLoginUser = [result valueForKey:@"name"];
                    
                    self.NameLabel.text = nameOfLoginUser;
                    self.profile.Username = nameOfLoginUser;
                    /*NSString *imageStringOfLoginUser = [[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
                     
                     NSURL *url = [[NSURL alloc] initWithURL: imageStringOfLoginUser];
                     [self.imageView setImageWithURL:url placeholderImage: nil];*/
                }
            }];
        }

    }
}

-(IBAction) TakePhoto:(id)sender{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera unavailable" message:@"The camera is not currently available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
    }

    
}

-(IBAction) ChooseExisting:(id)sender{
    picker2 = [[UIImagePickerController alloc] init];
    picker2.delegate = self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker2 animated:YES completion:NULL];
   
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //saving the image
    self.profile.image = UIImagePNGRepresentation(image);
    //archiving the new profile and displaying it
    NSData *archivedProfile = [NSKeyedArchiver archivedDataWithRootObject:self.profile];
    [[NSUserDefaults standardUserDefaults] setObject:archivedProfile forKey:self.userToken];
    
    [self.ProfilePicture setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];

}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // User is logged in, do work such as go to next view controller.
    //initializing login button
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    
    // setting the facebook button position
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGPoint origin = CGPointMake(screenWidth/2, screenHeight - 100);
    
    // Optional: Place the button in the center of your view.
    loginButton.center = origin;
    [self.view addSubview:loginButton];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initialization{

    
    if ([FBSDKAccessToken currentAccessToken]) {
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
        
        if(self.profile.image != nil)
        {
            self.ProfilePicture.image = [UIImage imageWithData: self.profile.image];
        }
        if(self.profile.theme != nil)
        {
            [self.profile.theme setTheme:self.view navigationBar:self.NavigationBar tabBar:self.TabBar];
            
            if([self.profile.theme.backgroundColorhex  isEqual: @"FFFFFF"])
            {
                [self.ThemeSelector setSelectedSegmentIndex:0];
            }
            else{
                [self.ThemeSelector setSelectedSegmentIndex:1];
            }
            
        }
        

    }
}

- (IBAction)ChangeTheme:(id)sender {
    
    NSInteger selectedIndex = [self.ThemeSelector selectedSegmentIndex];
    if(selectedIndex == 0)
    {
         ColorTheme * newTheme = [[ColorTheme alloc] initWithProps:@"EEEEEE" tabbarColor: @"DDDDDD" backgroundColorhex:@"FFFFFF" textColorhex:@"222222"];
        
        self.profile.theme = newTheme;
    }
    else{
        ColorTheme * newTheme = [[ColorTheme alloc] initWithProps:@"222222" tabbarColor: @"555555" backgroundColorhex:@"AAAAAA" textColorhex:@"222222"];
        
        
        self.profile.theme = newTheme;
    }
    
    [self.profile.theme setTheme:self.view navigationBar:self.NavigationBar tabBar:self.TabBar];
    
    //archiving the new profile and displaying it
    NSData *archivedProfile = [NSKeyedArchiver archivedDataWithRootObject:self.profile];
    [[NSUserDefaults standardUserDefaults] setObject:archivedProfile forKey:self.userToken];
    
    
}


-(void) initializeTheme: (ColorTheme *)theme{
    
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
