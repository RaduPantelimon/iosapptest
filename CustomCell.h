//
//  CustomCell.h
//  ProiectBucur
//
//  Created by Radu Bucur on 17/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *customPrice;

@property (weak, nonatomic) IBOutlet UILabel *customName;

@property (weak, nonatomic) IBOutlet UILabel *customCode;


@property (weak, nonatomic) IBOutlet UIImageView *customPicture;
@property (weak, nonatomic) IBOutlet UIButton *customDetailsButton;


@end
