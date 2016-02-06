//
//  MyAccountViewController.h
//  TVOSProject
//
//  Created by arvind on 1/28/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MyAccountViewController : UIViewController
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UIView *firstView,*secondView,*thirdView;
@property(nonatomic,retain) IBOutlet UIButton *fristBtn,*secondBtn,*thirdBtn;
@property(nonatomic,retain) UIView *overlayView;
@property(nonatomic,readwrite) BOOL isMenuVisible;
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,retain)IBOutlet UIButton *navigationmenuBtn,*navigationSearchBtn,*continueBtn;
@property(nonatomic,retain) UIImageView *bloomimg;

@end
