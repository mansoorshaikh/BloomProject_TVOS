//
//  SearchViewController.h
//  TVOSProject
//
//  Created by arvind on 1/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SearchViewController : UIViewController< UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IBOutlet UITableView *SearchTableView;
@property(nonatomic,retain) NSMutableArray *searchArray;
@property(nonatomic,retain)IBOutlet UISearchBar *SearchBar;
@property(nonatomic,retain) UIView *overlayView;
@property(nonatomic,readwrite) BOOL isMenuVisible;
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,retain)IBOutlet UIButton *navigationmenuBtn,*navigationSearchBtn;
@property(nonatomic,retain) UIImageView *bloomimg;
@property(nonatomic,retain)IBOutlet UITextField *SearchText;
@property(nonatomic,retain)UILabel * searchLblinfo;
@property(nonatomic,retain) IBOutlet UIScrollView *mainscrollview;



@end
