//
//  SplashScreenViewController.h
//  TVOSProject
//
//  Created by arvind on 1/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SplashScreenViewController : UIViewController
@property(nonatomic,retain) NSMutableArray *tagsArray;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UIImageView *splashImg;
@property (strong, nonatomic) UIWindow *window;

@end
