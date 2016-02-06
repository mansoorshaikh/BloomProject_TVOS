//
//  EpisodeViewController.h
//  TVOSProject
//
//  Created by arvind on 1/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface EpisodeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UITableView *episodeTableView;
@property(nonatomic,retain) NSMutableArray *episodeArray;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UILabel *nameLbl;
@property(nonatomic,retain) UIView *overlayView;
@property(nonatomic,readwrite) BOOL isMenuVisible;
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,retain)IBOutlet UIButton *navigationmenuBtn,*navigationSearchBtn;
@property(nonatomic,retain) UIImageView *bloomimg;
@property(nonatomic,retain) IBOutlet UIScrollView *mainscrollview;
@property(nonatomic,readwrite) int yheight;

@end
