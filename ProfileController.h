//
//  ProfileController.h
//  ProiectBucur
//
//  Created by Radu Bucur on 19/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import "ViewController.h"
#import "UserProfile.h"

@interface ProfileController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
    
}

-(void) initialization;

@property UserProfile * profile;
@property NSString * userToken;


@property (weak, nonatomic) IBOutlet UIImageView *ProfilePicture;

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;


-(IBAction)TakePhoto:(id)sender;
-(IBAction)ChooseExisting:(id)sender;


@end
