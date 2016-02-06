//
//  PlayViewController.m
//  TVOSProject
//
//  Created by MWC on 1/6/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "PlayViewController.h"
#import "Reachability.h"
#import <MediaPlayer/MPVolumeView.h>
@interface PlayViewController ()

@end

@implementation PlayViewController
@synthesize appDelegate,activityIndicator,player,playseconds,stopSeconds,durationTime,playerViewController;
- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [activityIndicator stopAnimating];
        appDelegate=[[UIApplication sharedApplication] delegate];
        appDelegate.shouldRotate=YES;
        UIButton * transperentButton= [UIButton buttonWithType:UIButtonTypeSystem];
        transperentButton.frame=CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-250);
        transperentButton.backgroundColor=[UIColor clearColor];
        [transperentButton addTarget:self action:@selector(showPlaybackControls) forControlEvents:UIControlEventPrimaryActionTriggered];
        [self.view addSubview:transperentButton];

        NSString *fullpath=[NSString stringWithFormat:@"http://content.jwplatform.com/videos/%@-1920.mp4",appDelegate.videoPathStr];
        NSURL *fileURL = [NSURL URLWithString:fullpath];
        
        playerViewController = [[AVPlayerViewController alloc] init];
        AVURLAsset *asset = [AVURLAsset assetWithURL: fileURL];
        AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
        player = [[AVPlayer alloc] initWithPlayerItem: item];
        [player setAllowsAirPlayVideo:YES];
        [playerViewController.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        playerViewController.showsPlaybackControls = YES;
        playerViewController.player = player;
        [self.view addSubview:playerViewController.view];
        [player seekToTime:CMTimeMakeWithSeconds([appDelegate.timeStr floatValue], 10)];
        [player play];
        // Do any additional setup after loading the view from its nib.
        UIImageView *titleLabel = [[UIImageView alloc] init];
        [titleLabel setFrame:CGRectMake(50, 5, 170, 33)];
        [titleLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Bloom Project_Logo-white.png"]]];    self.navigationItem.titleView = titleLabel;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        UIButton * doneButton= [UIButton buttonWithType:UIButtonTypeSystem];
        doneButton.frame=CGRectMake(self.view.bounds.size.width-170,50,171,40);
        [doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [doneButton.layer setBorderWidth:3.0];
        doneButton.layer.cornerRadius = 3; // this value vary as per your desire
        doneButton.clipsToBounds = YES;
        [doneButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
        [doneButton addTarget:self action:@selector(donePlaying) forControlEvents:UIControlEventPrimaryActionTriggered];
        //[self.view addSubview:doneButton];
    });
}

-(void)donePlaying{
    CMTime duration =player.currentItem.currentTime;
    stopSeconds = CMTimeGetSeconds(duration);
    NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
    if([prefsid stringForKey:@"user_id"]!=nil)
        [self VideoPostData];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)showPlaybackControls{
    playerViewController.showsPlaybackControls = YES;
    [player pause];
    [player play];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    //Do stuff here...
}


-(void)viewDidAppear:(BOOL)animated{
    CMTime duration =player.currentItem.asset.duration;
    playseconds = CMTimeGetSeconds(duration);
    NSLog(@"play duration: %.2f", playseconds);
}

-(void)viewWillAppear:(BOOL)animated
{
    
}
-(IBAction)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    CMTime duration =player.currentItem.currentTime;
    stopSeconds = CMTimeGetSeconds(duration);
    NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
    if([prefsid stringForKey:@"user_id"]!=nil)
        [self VideoPostData];
    
}
-(IBAction)menuScreenAction{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)VideoPostData{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
    
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        [activityIndicator stopAnimating];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"BloomProject"
                                                                       message:@"No internet connection available!!!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction]; // This is what I comment out
        [self presentViewController:alert animated:YES completion:nil];
        
        [activityIndicator stopAnimating];
        
    }else{
        
        NSString *urlString;
        urlString = [[NSString alloc]initWithFormat:@"http://app.bloomproject.com/api/v1/continue_watching.php?type=add&video_id=%@&&user_id=%@&time_paused=%f",appDelegate.videoPathStr,[prefsid objectForKey:@"user_id"],stopSeconds];
        
        NSLog(@"string url %@",urlString);
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                             
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
    }
}

- (void) threadStartAnimating:(id)data {
    [activityIndicator startAnimating];
    activityIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: activityIndicator];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
