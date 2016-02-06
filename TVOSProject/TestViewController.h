//
//  TestViewController.h
//  TVOSProject
//
//  Created by arvind on 1/3/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface TestViewController : UIViewController
@property(nonatomic,retain) IBOutlet UIScrollView *mainscrollview,*spotlightScrollview,*popularScrollView,*countiuneScrollview,*trendingNowScrollview,*featureScrollview,*shortScrollview,*seriesScrollview,*podcastsScrollview,*musicScrollview;
@property(nonatomic,retain) NSMutableArray *spotlightarray,*testimgArray1,*testimgarray2,*tagnamearray,*contiWatchArray,*popularArray,*TrabingnowArray,*featureArray,*shortArray,*seriesArray,*podcastsArray,*musicArray;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) UILabel *msgLbl,*spotlightLBls;
@property(nonatomic,retain)UIButton *SignOut;
@property(nonatomic,retain) UIView *overlayView;
@property(nonatomic,readwrite) BOOL isMenuVisible;
@property(nonatomic,retain)NSMutableArray *menuNameArray;
@property(nonatomic,retain) UIButton *menuNameButton;
@property(nonatomic,retain)IBOutlet UILabel *spotlightLBl,*ContinuewatchLbl,*PopularLbl,*TrendingLbl,*FeatureLbl,*ShortLbl,*SeriesLbl,*MusicLbl,*podcastsLbl;
@property(nonatomic,retain) UIImageView *bloomimg;
@property(nonatomic,retain)IBOutlet UIButton *navigationmenuBtn,*navigationSearchBtn,*transperentBtnspotlight,*transperentSpotlightBtn,*ContinuewatchBtn,*transperentSpotlightBtn2;
@property(nonatomic,readwrite) int yheight;
@property(nonatomic,retain) UISwipeGestureRecognizer *tapRecognizer;
@property (nonatomic, assign) CGFloat lastContentOffset;
@end
