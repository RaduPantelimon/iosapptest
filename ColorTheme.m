//
//  ColorTheme.m
//  ProiectBucur
//
//  Created by Radu Bucur on 19/04/2017.
//  Copyright © 2017 Radu Bucur. All rights reserved.
//

#import "UIKit/UiKit.h"
#import "ColorTheme.h"

@implementation ColorTheme


@synthesize backgroundColorhex;
@synthesize tabbarColorhex;
@synthesize  navbarColorhex;
@synthesize textColorhex;

-(id)initWithProps:(NSString *)_navbarColorhex
       tabbarColor:(NSString *)_tabbarColorhex
backgroundColorhex:(NSString *) _backgroundColorhex
      textColorhex: (NSString *) _textColorhex{
 
    if (self = [super init]) {
        
        self.backgroundColorhex = _backgroundColorhex;
        self.tabbarColorhex = _tabbarColorhex;
        self.textColorhex = _textColorhex;
        self.navbarColorhex = _navbarColorhex;
    }
    return self;

}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        
        self.backgroundColorhex = [decoder decodeObjectForKey:@"backgroundColorhex"];
        self.tabbarColorhex = [decoder decodeObjectForKey:@"tabbarColorhex"];
        self.textColorhex = [decoder decodeObjectForKey:@"textColorhex"];
        self.navbarColorhex = [decoder decodeObjectForKey:@"navbarColorhex"] ;
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:backgroundColorhex forKey:@"backgroundColorhex"];
    [encoder encodeObject:tabbarColorhex forKey:@"tabbarColorhex"];
    [encoder encodeObject:textColorhex forKey:@"textColorhex"];
    [encoder encodeObject:navbarColorhex forKey:@"navbarColorhex"];
    
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


-(void)setTheme : (UIView *) mainView
  navigationBar : (UINavigationItem *) navbar
         tabBar : (UIView *) tabBar{
    
    UIColor * backgroundColor = [self colorWithHexString:self.backgroundColorhex];
    mainView.backgroundColor = backgroundColor;
    
    UIColor * tabBarColor = [self colorWithHexString:self.tabbarColorhex];
    tabBar.backgroundColor = tabBarColor;
    
    UIColor * navBarColor = [self colorWithHexString:self.navbarColorhex];
    navbar.titleView.backgroundColor = navBarColor;
    
}

-(void)setThemeDetails : (UIView *) mainView
  navigationBar : (UIView *) navbar
         tabBar : (UIView *) tabBar{
    
    UIColor * backgroundColor = [self colorWithHexString:self.backgroundColorhex];
    mainView.backgroundColor = backgroundColor;
    
    UIColor * tabBarColor = [self colorWithHexString:self.tabbarColorhex];
    tabBar.backgroundColor = tabBarColor;
    
    UIColor * navBarColor = [self colorWithHexString:self.navbarColorhex];
    navbar.backgroundColor = navBarColor;
    
}

@end
