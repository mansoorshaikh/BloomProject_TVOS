//
//  DetailsViewController.h
//  TVOSProject
//
//  Created by arvind on 1/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface DetailsViewController : UIViewController
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) UILabel * userLblName,*episodesynopsisLbl,*descLbl,*episodeNameLbl,*episodeguideLbl;
@property(nonatomic,retain) UIButton *playBtn,*transperentBtn;
@property(nonatomic,retain) UIImageView *imgview;
@property(nonatomic,retain) UIView *overlayView;
@property(nonatomic,readwrite) BOOL isMenuVisible;
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,retain)IBOutlet UIButton *navigationmenuBtn,*navigationSearchBtn;
@property(nonatomic,retain) UIImageView *bloomimg;
@property(nonatomic,retain) IBOutlet UIScrollView *mainscrollview;
@end
