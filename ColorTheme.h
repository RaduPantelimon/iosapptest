//
//  ColorTheme.h
//  ProiectBucur
//
//  Created by Radu Bucur on 19/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UiKit.h"

@interface ColorTheme : NSObject<NSCoding>{

    NSString * navbarColorhex;
    NSString * tabbarColorhex;
    NSString * backgroundColorhex;
    NSString * textColorhex;
}
@property NSString * navbarColorhex;
@property NSString * tabbarColorhex;
@property NSString * backgroundColorhex;
@property NSString * textColorhex;

-(id)initWithProps:(NSString *)_navbarColorhex
            tabbarColor:(NSString *)_tabbarColorhex
backgroundColorhex:(NSString *) _backgroundColorhex
      textColorhex: (NSString *) _textColorhex;


-(UIColor*)colorWithHexString:(NSString*)hex;

-(void)setTheme : (UIView *) mainView
         navigationBar : (UINavigationItem *) navbar
         tabBar : (UIView *) tabBar;

-(void)setThemeDetails : (UIView *) mainView
  navigationBar : (UIView *) navbar
         tabBar : (UIView *) tabBar;
@end
