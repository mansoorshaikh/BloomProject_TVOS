//
//  PlayViewController.h
//  TVOSProject
//
//  Created by MWC on 1/6/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerItem.h>
#import <AVFoundation/AVAsset.h>
#import <MediaPlayer/MediaPlayer.h>
@import AVFoundation;
@import AVKit;

@interface PlayViewController : UIViewController
@property(nonatomic,retain)  AVPlayerViewController *playerViewController;
@property(nonatomic,retain) AppDelegate *appDelegate;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) AVPlayer *player;
@property(nonatomic,readwrite) float playseconds,stopSeconds;
@property(nonatomic,retain) NSString *durationTime;
@property(nonatomic,retain) IBOutlet UIView *landscapeView;

@end
