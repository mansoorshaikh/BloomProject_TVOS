//
//  TestViewController.m
//  TVOSProject
//
//  Created by arvind on 1/3/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "TestViewController.h"
#import "FeatureViewController.h"
#import "TagCategoryDataVO.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "SeriesViewController.h"
#import "SearchViewController.h"
#import "ShortsViewController.h"
#import "NewViewController.h"
#import "SeriesViewController.h"
#import "MusicViewController.h"
#import "RegisterViewController.h"
#import "PodcastsViewController.h"
#import "SettingViewController.h"
#import "SignInViewController.h"
#import "PlayViewController.h"
#import "SeriesVO.h"
#import "EpisodeViewController.h"
#import "DetailsViewController.h"
#import "Reachability.h"
#import "MyAccountViewController.h"
@interface TestViewController ()

@end

@implementation TestViewController{
}
@synthesize mainscrollview,spotlightScrollview,spotlightarray,testimgArray1,testimgarray2,tagnamearray,contiWatchArray,popularArray,TrabingnowArray,featureArray,shortArray,activityIndicator,popularScrollView,countiuneScrollview,trendingNowScrollview,featureScrollview,appDelegate,seriesArray,podcastsArray,musicArray,shortScrollview,seriesScrollview,podcastsScrollview,musicScrollview,msgLbl,SignOut,overlayView,isMenuVisible,menuNameArray,menuNameButton,spotlightLBl,ContinuewatchLbl,PopularLbl,TrendingLbl,FeatureLbl,ShortLbl,SeriesLbl,MusicLbl,podcastsLbl,bloomimg,navigationmenuBtn,navigationSearchBtn,yheight,tapRecognizer,transperentBtnspotlight,spotlightLBls,transperentSpotlightBtn,ContinuewatchBtn,transperentSpotlightBtn2,lastContentOffset;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate=[[UIApplication sharedApplication] delegate];
       self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden=YES;
    CGRect screenRectwidth = [[UIScreen mainScreen] bounds];
    bloomimg = [[UIImageView alloc] init];
    [bloomimg setFrame:CGRectMake(screenRectwidth.size.width/2-70,18, 170, 33)];
    [bloomimg setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Bloom Project_Logo-white.png"]]];
    navigationmenuBtn= [UIButton buttonWithType:UIButtonTypeSystem];
    navigationmenuBtn.frame=CGRectMake(110,18,30,30);

    navigationSearchBtn= [UIButton buttonWithType:UIButtonTypeSystem];
    navigationSearchBtn.frame=CGRectMake(screenRectwidth.size.width-140,18,30,30);

    bloomimg.alpha = 0.95;
    [self.view addSubview:bloomimg];
    
    [navigationmenuBtn addTarget:self action:@selector(menuScreenAction)forControlEvents:UIControlEventPrimaryActionTriggered];
    [navigationmenuBtn setBackgroundImage: [UIImage imageNamed:@"revealicon.png"] forState:UIControlStateNormal];
    [navigationmenuBtn setBackgroundImage: [UIImage imageNamed:@"revealicon_black.png"] forState:UIControlStateFocused];
    [self.view addSubview:navigationmenuBtn];

    [navigationSearchBtn addTarget:self action:@selector(SearchAction)forControlEvents:UIControlEventPrimaryActionTriggered];
    [navigationSearchBtn setBackgroundImage: [UIImage imageNamed:@"searchicon.png"] forState:UIControlStateNormal];
    [navigationSearchBtn setBackgroundImage: [UIImage imageNamed:@"search_black.png"] forState:UIControlStateFocused];
    
    [self.view addSubview:navigationSearchBtn];
    
    tagnamearray=[[NSMutableArray alloc]initWithObjects:@"Spotlight",@"Popular",@"Trending Now",@"Feature Doc",@"Short Doc",@"Series",@"Podcast",@"Music", nil];
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    NSLog(@"stage 1");
        self.navigationController.navigationBarHidden=YES;
        NSLog(@"stage 2");
        [self DisplayallView];
        NSLog(@"stage 3");
    [activityIndicator stopAnimating];
    
    tapRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:tapRecognizer];
    
    UIFocusGuide *focusGuide = [[UIFocusGuide alloc]init];
    focusGuide.preferredFocusedView = [self preferredFocusedView];
    [self.view addLayoutGuide:focusGuide];
    
    [self overlayDisplay];

    
    // Do any additional setup after loading the view from its nib.
}
-(void)overlayDisplay{
    NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
    if([prefsid stringForKey:@"user_id"]!=nil){
        menuNameArray=[[NSMutableArray alloc]initWithObjects:@"Welcome",@"Feature Documentaries",@"Short Documentaries",@"Series",@"Podcasts",@"Music",@"My Account",@"Settings", nil];
    }else{
        menuNameArray=[[NSMutableArray alloc]initWithObjects:@"Welcome",@"Feature Documentaries",@"Short Documentaries",@"Series",@"Podcasts",@"Music",@"Sign In",@"Register",@"Settings", nil];
    }
    overlayView = [[UIView alloc] initWithFrame:CGRectMake(0,70, self.view.bounds.size.width, self.view.bounds.size.height)];
    overlayView.backgroundColor = [UIColor blackColor];
    overlayView.alpha = 0.95;
    int yValue=50;
    int arraycount=[menuNameArray count];

    for (int count=0; count<[menuNameArray count]; count++) {
        menuNameButton=[UIButton buttonWithType:UIButtonTypeSystem];
        menuNameButton.frame = CGRectMake(17, yValue,self.view.bounds.size.width-50, 70);
        [menuNameButton setTitle:[menuNameArray objectAtIndex:count] forState:UIControlStateNormal];
        if (arraycount==8) {
            if (count==6) {
                menuNameButton.tag=count+100;
            }else if (count==7){
                menuNameButton.tag=count+1;
            }else{
                menuNameButton.tag=count;
            }
        }else{
            menuNameButton.tag=count;
        }        if (count==8) {
            menuNameButton.titleLabel.font= [UIFont fontWithName:@"HelveticaNeue-Light" size:45.0f];
        }else{
            menuNameButton.titleLabel.font= [UIFont fontWithName:@"HelveticaNeue-Light" size:60.0f];
        }
        [menuNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuNameButton setTitleColor:[UIColor blackColor] forState:UIControlStateFocused];
        
        [menuNameButton setBackgroundImage:[UIImage imageNamed:@"Default-Landscape@2x.png"] forState:UIControlStateNormal];
        
        [menuNameButton setBackgroundImage:[UIImage imageNamed:@"Defaultbackground.png"] forState:UIControlStateFocused];
        [menuNameButton addTarget:self action:@selector(menuButtonAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
        menuNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [overlayView addSubview:menuNameButton];
        
        yValue=yValue+90;
    }
    [self.view addSubview:overlayView];
    
    overlayView.hidden=true;
    isMenuVisible=false;

}
- (UIView *)preferredFocusedView
{

        return self.transperentSpotlightBtn.preferredFocusedView;
}

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator
{
    [super didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    
    if (transperentSpotlightBtn2 == context.nextFocusedView) {
        
        [coordinator addCoordinatedAnimations:^{
            // focusing animations
            
        } completion:^{
            // completion
        }];
    } else if (self == context.previouslyFocusedView) {
        [coordinator addCoordinatedAnimations:^{
            // unfocusing animations
        } completion:^{
            // completion
        }];
    }
}


- (void)handleTap:(UISwipeGestureRecognizer *)tapRecognizers
{
        NSLog(@"It works");
    //NSLog(@"touchpoint %f,%f,%@",[tapRecognizers locationInView: mainscrollview].x,[tapRecognizers locationInView: mainscrollview].y,tapRecognizers.view);
}

-(IBAction)SearchAction{
    SearchViewController *search;
    search=[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    [self.navigationController pushViewController:search animated:YES];
}

-(void)menuButtonAction:(UIButton *)button{
    int tags=button.tag;
    if (tags==0) {
        if(!isMenuVisible)
        {
            overlayView.hidden=false;
            isMenuVisible=true;
        }else{
            overlayView.hidden=true;
            isMenuVisible=false;
        }
    }else if (tags==1){
        FeatureViewController * feature;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            feature = [[FeatureViewController alloc] initWithNibName:@"FeatureViewController~ipad" bundle:nil];
        }else{
            feature = [[FeatureViewController alloc] initWithNibName:@"FeatureViewController" bundle:nil];
        }
        [self.navigationController pushViewController:feature animated:YES];
    }else if (tags==2){
        ShortsViewController * shorts;
        shorts = [[ShortsViewController alloc] initWithNibName:@"ShortsViewController" bundle:nil];
        [self.navigationController pushViewController:shorts animated:YES];
    }else if (tags==3){
        SeriesViewController * Series;
            Series = [[SeriesViewController alloc] initWithNibName:@"SeriesViewController" bundle:nil];
        [self.navigationController pushViewController:Series animated:YES];
    }else if (tags==4){
        PodcastsViewController * podcasts;
            podcasts = [[PodcastsViewController alloc] initWithNibName:@"PodcastsViewController" bundle:nil];
        [self.navigationController pushViewController:podcasts animated:YES];
    }else if (tags==5){
        MusicViewController * music;
            music = [[MusicViewController alloc] initWithNibName:@"MusicViewController" bundle:nil];
        [self.navigationController pushViewController:music animated:YES];
    }else if (tags==6){
        SignInViewController * signin;
        signin = [[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
        [self.navigationController pushViewController:signin animated:YES];
    }else if (tags==7){
        RegisterViewController * registers;
        registers = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
        [self.navigationController pushViewController:registers animated:YES];
    }else if (tags==8){
        SettingViewController * setting;
        setting = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
        [self.navigationController pushViewController:setting animated:YES];
    }else if (tags==106){
        MyAccountViewController * myaccount;
            myaccount = [[MyAccountViewController alloc] initWithNibName:@"MyAccountViewController" bundle:nil];
        [self.navigationController pushViewController:myaccount animated:NO];
    }
}

-(IBAction)menuScreenAction{
    if(!isMenuVisible)
    {
        overlayView.hidden=false;
        isMenuVisible=true;
    }else{
        overlayView.hidden=true;
        isMenuVisible=false;
    }
}
- (void) threadStartAnimating:(id)data {
    [activityIndicator removeFromSuperview];
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicator.center=self.view.center;
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];}
-(IBAction)testaction:(id)sender{
    NSLog(@"button clicked");
}
-(void)viewDidAppear:(BOOL)animated{
    dispatch_async(dispatch_get_main_queue(), ^{

    NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
    if([prefsid stringForKey:@"user_id"]!=nil){
        [self continueWatchingData];

    int imageXValues=2;
    int imageXValwidth=self.mainscrollview.bounds.size.width/3;
    int imageXValwidths=self.view.bounds.size.width/2;
    countiuneScrollview.contentSize= CGSizeMake(self.view.bounds.size.width,150);
        [ContinuewatchBtn setTitle:@"Continue Watching" forState:UIControlStateNormal];
        ContinuewatchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [ContinuewatchBtn setBackgroundColor:[UIColor clearColor]];
        ContinuewatchBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25];

    for (int count=0; count<[contiWatchArray count]; count++) {
        SeriesVO *slvos=[contiWatchArray objectAtIndex:count];
        NSString *url=[[NSString alloc]init];
        
        url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.video_id];
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,imageXValwidth-30,self.countiuneScrollview.bounds.size.height-10)];
        UIButton *transperentBtn= [UIButton buttonWithType:UIButtonTypeSystem];
        transperentBtn.frame=CGRectMake(imageXValues,0, imageXValwidth-30, self.countiuneScrollview.bounds.size.height);
        
        imgview.clipsToBounds = YES;
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator startAnimating];
        [indicator setCenter:imgview.center];
        [self.countiuneScrollview addSubview:indicator];
        imgview.contentMode = UIViewContentModeScaleAspectFill;
        [imgview removeFromSuperview];
        [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
            
            [indicator stopAnimating];
        }];
        imgview.backgroundColor=[UIColor clearColor];
        [imgview setAdjustsImageWhenAncestorFocused:YES];
        [transperentBtn setNeedsFocusUpdate];
        [transperentBtn updateFocusIfNeeded];

        imageXValues=imageXValues+imageXValwidth+30;
        //[scrollviewImages addObject:imgview];
        transperentBtn.backgroundColor=[UIColor clearColor];
        [transperentBtn setTintColor:[UIColor clearColor]];
        transperentBtn.tag=count+100;
        [transperentBtn addTarget:self action:@selector(ContinueWatAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
        [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateFocused];
        [self.countiuneScrollview addSubview:transperentBtn];
        [self.mainscrollview addSubview:countiuneScrollview];
        [self.mainscrollview bringSubviewToFront:countiuneScrollview];
            }
        [self.mainscrollview addSubview:ContinuewatchBtn];

        }
    });

}
-(void)continueWatchingData{
    contiWatchArray=[[NSMutableArray alloc]init];
    //    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
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
        //  [activityIndicator stopAnimating];
        
    }else{
        
        NSString *urlString;
        urlString = [[NSString alloc]initWithFormat:@"http://app.bloomproject.com/api/v1/continue_watching.php?type=list&user_id=%@",[prefsid objectForKey:@"user_id"]];
        NSLog(@"string url %@",urlString);
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                             
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        NSError *error;
        
        NSArray *userDict=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
        
        for (int count=0; count<[userDict count]; count++) {
            NSDictionary *activityDatas=[userDict objectAtIndex:count];
            SeriesVO *csvo=[[SeriesVO alloc] init];
            
            csvo.user_id=[[NSString alloc] init];
            csvo.video_id=[[NSString alloc] init];
            csvo.time_paused=[[NSString alloc] init];
            if ([activityDatas objectForKey:@"user_id"] != [NSNull null])
                csvo.user_id=[activityDatas objectForKey:@"user_id"];
            csvo.video_id=[activityDatas objectForKey:@"video_id"];
            csvo.time_paused=[activityDatas objectForKey:@"time_paused"];
            [contiWatchArray addObject:csvo];
        }
        //   [activityIndicator stopAnimating];
    }
}

-(void)DisplayallView{
    
        for (UIView *v in mainscrollview.subviews) {
            [v removeFromSuperview];
        }
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    [self.popularScrollView delegate];
    [self.spotlightScrollview delegate];
    [self.trendingNowScrollview delegate];
    [self.countiuneScrollview delegate];
    
    [self.featureScrollview delegate];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat yheights = screenRect.size.width/3;
    CGFloat yheightsspotlight = (self.mainscrollview.bounds.size.width*60)/100;
    CGFloat finalHeght=(yheights/16)*9;
    CGFloat finalHeghtspotlight=(yheightsspotlight/16)*9;
    CGFloat yheightscont = screenRect.size.width/2;
    CGFloat finalHeghtconts=yheightscont/4*3;
    [spotlightScrollview removeFromSuperview];
    spotlightScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 35,self.mainscrollview.bounds.size.width, finalHeghtspotlight)];

    yheight=finalHeghtspotlight+90;
    NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
    if([prefsid stringForKey:@"user_id"]!=nil){
        [self continueWatchingData];
        if (contiWatchArray.count==0) {
            
        }else{
            ContinuewatchBtn= [UIButton buttonWithType:UIButtonTypeSystem];
            ContinuewatchBtn.frame=CGRectMake(15,yheight-35,400,40);
            countiuneScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight+10, self.view.bounds.size.width,finalHeght)];
            [self.mainscrollview addSubview:ContinuewatchBtn];

            yheight=yheight+finalHeght+80;
        }
    }
    [popularScrollView removeFromSuperview];
    [trendingNowScrollview removeFromSuperview];
    [featureScrollview removeFromSuperview];
    [shortScrollview removeFromSuperview];
    [seriesScrollview removeFromSuperview];
    [podcastsScrollview removeFromSuperview];
    [musicScrollview removeFromSuperview];
    [PopularLbl removeFromSuperview];
    [TrendingLbl removeFromSuperview];
    [FeatureLbl removeFromSuperview];
    [ShortLbl removeFromSuperview];
    [SeriesLbl removeFromSuperview];
    [podcastsLbl removeFromSuperview];
    [MusicLbl removeFromSuperview];
    

    popularScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight, self.view.bounds.size.width, finalHeght)];
    popularScrollView.contentSize= CGSizeMake(self.mainscrollview.bounds.size.width,finalHeght+20);
    yheight=yheight+finalHeght+70;
    trendingNowScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight, self.view.bounds.size.width, finalHeght)];

    yheight=yheight+finalHeght+70;
    featureScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight, self.view.bounds.size.width, finalHeght)];

    yheight=yheight+finalHeght+70;
    shortScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight, self.view.bounds.size.width, finalHeght)];

    yheight=yheight+finalHeght+60;
    seriesScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight, self.view.bounds.size.width, finalHeght)];

    yheight=yheight+finalHeght+70;
    podcastsScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight, self.view.bounds.size.width, finalHeght)];
    yheight=yheight+finalHeght+70;
    musicScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, yheight, self.view.bounds.size.width, finalHeght)];
    yheight=yheight+finalHeght+70;
    SignOut= [UIButton buttonWithType:UIButtonTypeSystem];
    SignOut.frame=CGRectMake(18,yheight,250,30);
    yheight=yheight+70;
    msgLbl=[[UILabel alloc] initWithFrame:CGRectMake(18,yheight,250,100)];
    mainscrollview.contentSize = CGSizeMake(width-140,yheight+350);
    mainscrollview.scrollEnabled=YES;
    
    int imageXValwidth=self.mainscrollview.bounds.size.width/3;
    
    
    int imageXValue=10;
    int maincounter=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        maincounter++;
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"Spotlight"]){
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            spotlightLBls=[[UILabel alloc]initWithFrame:CGRectMake(imageXValue+25,finalHeghtspotlight-70,imageXValwidth-50,40)];
            [spotlightLBls setBackgroundColor:[UIColor clearColor]];
            [spotlightLBls setFont:[UIFont systemFontOfSize: 35]];
            spotlightLBls.text=slvos.title;
            spotlightLBls.textColor=[UIColor whiteColor];

            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(imageXValue,10,yheightsspotlight,finalHeghtspotlight-30)];
            imgview.clipsToBounds = YES;
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview setAdjustsImageWhenAncestorFocused:YES];
            if (count==0) {
                transperentSpotlightBtn= [UIButton buttonWithType:UIButtonTypeSystem];
                transperentSpotlightBtn.frame=CGRectMake(imageXValue,10, yheightsspotlight,self.spotlightScrollview.bounds.size.height-30);

                UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                [indicator startAnimating];
                [indicator setCenter:imgview.center];
                [self.spotlightScrollview addSubview:indicator];
                
                [imgview removeFromSuperview];
                
                [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [transperentSpotlightBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
                    
                    [indicator stopAnimating];
                }];
                
                [self.transperentSpotlightBtn setNeedsFocusUpdate];
                 [self.transperentSpotlightBtn updateFocusIfNeeded];
                //[imgview setImage:[UIImage imageNamed:@"parallaxStack.lsr"]];
               // transperentSpotlightBtn.imageView.clipsToBounds = NO;
                imgview.backgroundColor=[UIColor clearColor];
                transperentSpotlightBtn.backgroundColor=[UIColor clearColor];
                transperentSpotlightBtn.tag=maincounter+100;
                [transperentSpotlightBtn addTarget:self action:@selector(SpotlightAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
                [transperentSpotlightBtn setBackgroundImage:imgview.image forState:UIControlStateFocused];
                [self.spotlightScrollview addSubview:transperentSpotlightBtn];
            }else{
             UIButton *transperentBtn= [UIButton buttonWithType:UIButtonTypeSystem];
            transperentBtn.frame=CGRectMake(imageXValue,10, yheightsspotlight-3,self.spotlightScrollview.bounds.size.height-30);

            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.spotlightScrollview addSubview:indicator];

            [imgview removeFromSuperview];
            [imgview setAdjustsImageWhenAncestorFocused:YES];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
                
                [indicator stopAnimating];
            }];
                [imgview setAdjustsImageWhenAncestorFocused:YES];
                [transperentBtn setNeedsFocusUpdate];
                [transperentBtn updateFocusIfNeeded];
            imgview.backgroundColor=[UIColor clearColor];
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=maincounter+100;
            [transperentBtn addTarget:self action:@selector(SpotlightAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
            [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateFocused];
            [self.spotlightScrollview addSubview:transperentBtn];
            }
            imageXValue=imageXValue+yheightsspotlight+50;
            [self.spotlightScrollview addSubview:spotlightLBls];
        }
        
    }
    spotlightScrollview.contentSize= CGSizeMake(self.mainscrollview.bounds.size.width*2-268,200);

    [self.mainscrollview addSubview:spotlightScrollview];
    [self.mainscrollview bringSubviewToFront:spotlightScrollview];

    maincounter=-1;
        if (contiWatchArray!=nil && contiWatchArray.count==0) {
            
        int imageXValues=10;
        int imageXValwidths=self.view.bounds.size.width/2;
        countiuneScrollview.contentSize= CGSizeMake(self.view.bounds.size.width,150);

        for (int count=0; count<[contiWatchArray count]; count++) {
            SeriesVO *slvos=[contiWatchArray objectAtIndex:count];
            NSString *url=[[NSString alloc]init];
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.video_id];
            
            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(imageXValues,10,imageXValwidth-50,self.countiuneScrollview.bounds.size.height-10)];
            UIButton *transperentBtn= [UIButton buttonWithType:UIButtonTypeSystem];
            transperentBtn.frame=CGRectMake(imageXValues,10, imageXValwidth-50,self.countiuneScrollview.bounds.size.height);
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.countiuneScrollview addSubview:indicator];
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
                
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            [imgview setAdjustsImageWhenAncestorFocused:YES];
            [transperentBtn setNeedsFocusUpdate];
            [transperentBtn updateFocusIfNeeded];

            imageXValues=imageXValues+imageXValwidth+10;
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=count+100;
            [transperentBtn addTarget:self action:@selector(ContinueWatAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
            [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateFocused];
            [self.countiuneScrollview addSubview:transperentBtn];
        }

    [self.mainscrollview addSubview:countiuneScrollview];
    [self.mainscrollview bringSubviewToFront:countiuneScrollview];
    }
    
    
    int imageXValus=10;
    int mainconter=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        mainconter++;
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"popular"]){
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            PopularLbl=[[UILabel alloc]initWithFrame:CGRectMake(imageXValus+25,self.countiuneScrollview.bounds.size.height-50,imageXValwidth-50,40)];
            
            PopularLbl=[[UILabel alloc]initWithFrame:CGRectMake(imageXValus+25,self.popularScrollView.bounds.size.height-70,imageXValwidth-50,40)];
            [PopularLbl setBackgroundColor:[UIColor clearColor]];
            [PopularLbl setFont:[UIFont boldSystemFontOfSize: 35]];
            PopularLbl.text=slvos.title;
            PopularLbl.textColor=[UIColor whiteColor];

            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,10,imageXValwidth-50,self.popularScrollView.bounds.size.height-25)];
            UIButton *transperentBtn= [UIButton buttonWithType:UIButtonTypeSystem];
            transperentBtn.frame=CGRectMake(imageXValus,10, imageXValwidth-50, self.popularScrollView.bounds.size.height-25);

            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.popularScrollView addSubview:indicator];
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
                
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            [imgview setAdjustsImageWhenAncestorFocused:YES];
            [transperentBtn setNeedsFocusUpdate];
            [transperentBtn updateFocusIfNeeded];

            imageXValus=imageXValus+imageXValwidth+10;
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=mainconter+100;
            [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateFocused];
            [transperentBtn addTarget:self action:@selector(PopularAction:) forControlEvents:
             UIControlEventPrimaryActionTriggered];
            [transperentBtn setBackgroundColor:[UIColor clearColor]];


            [self.popularScrollView addSubview:transperentBtn];
            [self.popularScrollView addSubview:PopularLbl];
            [self.popularScrollView bringSubviewToFront:PopularLbl];
        }
    }
    [self.mainscrollview addSubview:popularScrollView];
    [self.mainscrollview bringSubviewToFront:popularScrollView];

    
    mainconter=0;
    
    int imageXVals=10;
    int maincoter=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        maincoter++;
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"trending"]){
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            TrendingLbl=[[UILabel alloc]initWithFrame:CGRectMake(imageXVals+25,self.trendingNowScrollview.bounds.size.height-70,imageXValwidth-50,40)];
            [TrendingLbl setBackgroundColor:[UIColor clearColor]];
            [TrendingLbl setFont:[UIFont boldSystemFontOfSize: 35]];
            TrendingLbl.text=slvos.title;
            TrendingLbl.textColor=[UIColor whiteColor];

            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,10,imageXValwidth-50,self.trendingNowScrollview.bounds.size.height-25)];
            UIButton *transperentBtn= [UIButton buttonWithType:UIButtonTypeSystem];
            transperentBtn.frame=CGRectMake(imageXVals,10, imageXValwidth-50, self.trendingNowScrollview.bounds.size.height-25);
            
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.trendingNowScrollview addSubview:indicator];
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
                
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            [imgview setAdjustsImageWhenAncestorFocused:YES];
            [transperentBtn setNeedsFocusUpdate];
            [transperentBtn updateFocusIfNeeded];

            imageXVals=imageXVals+imageXValwidth+10;
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=mainconter+100;
            [transperentBtn addTarget:self action:@selector(TrendingAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
            [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateFocused];
            [self.trendingNowScrollview addSubview:transperentBtn];
            [self.trendingNowScrollview addSubview:TrendingLbl];
        }
    }
    
    [self.mainscrollview addSubview:trendingNowScrollview];
    [self.mainscrollview bringSubviewToFront:trendingNowScrollview];

    
    maincoter=0;
    
    int imageXValss=10;
    int maincounters=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        maincounters++;
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"Feature Doc"]){
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            FeatureLbl=[[UILabel alloc]initWithFrame:CGRectMake(imageXValss+25,self.featureScrollview.bounds.size.height-70,imageXValwidth-50,40)];
            [FeatureLbl setBackgroundColor:[UIColor clearColor]];
            [FeatureLbl setFont:[UIFont boldSystemFontOfSize: 35]];
            FeatureLbl.text=slvos.title;
            FeatureLbl.textColor=[UIColor whiteColor];

            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,10,imageXValwidth-50,self.featureScrollview.bounds.size.height-25)];
            UIButton *transperentBtn= [UIButton buttonWithType:UIButtonTypeSystem];
            transperentBtn.frame=CGRectMake(imageXValss,10, imageXValwidth-50, self.featureScrollview.bounds.size.height-25);
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.featureScrollview addSubview:indicator];
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
                
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            [imgview setAdjustsImageWhenAncestorFocused:YES];
            [transperentBtn setNeedsFocusUpdate];
            [transperentBtn updateFocusIfNeeded];

            imageXValss=imageXValss+imageXValwidth+10;
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=maincounters+100;
            [transperentBtn addTarget:self action:@selector(FeatureAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
            [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateFocused];
            [self.featureScrollview addSubview:transperentBtn];
            [self.featureScrollview addSubview:FeatureLbl];
        }
    }
    [self.mainscrollview addSubview:featureScrollview];
    [self.mainscrollview bringSubviewToFront:featureScrollview];

    
    maincounters=0;
    
    int imgeXValss=10;
    int maincountr=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        maincountr++;
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"Short Doc"]){
            NSString *url=[[NSString alloc]init];
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            
            ShortLbl=[[UILabel alloc]initWithFrame:CGRectMake(imgeXValss+25,self.shortScrollview.bounds.size.height-70,imageXValwidth-50,40)];
            [ShortLbl setBackgroundColor:[UIColor clearColor]];
            [ShortLbl setFont:[UIFont boldSystemFontOfSize: 35]];
            ShortLbl.text=slvos.title;
            ShortLbl.textColor=[UIColor whiteColor];

            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,10,imageXValwidth-50,self.shortScrollview.bounds.size.height-25)];
            UIButton *transperentBtn= [UIButton buttonWithType:UIButtonTypeSystem];
            transperentBtn.frame=CGRectMake(imgeXValss,10, imageXValwidth-50, self.shortScrollview.bounds.size.height-25);
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.shortScrollview addSubview:indicator];
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
                
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            [imgview setAdjustsImageWhenAncestorFocused:YES];
            [transperentBtn setNeedsFocusUpdate];
            [transperentBtn updateFocusIfNeeded];

            imgeXValss=imgeXValss+imageXValwidth+10;
            //[scrollviewImages addObject:imgview];
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=maincountr+100;
            [transperentBtn addTarget:self action:@selector(ShortsAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
            [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateFocused];
            [self.shortScrollview addSubview:transperentBtn];
            [self.shortScrollview addSubview:ShortLbl];
        }
    }
    [self.mainscrollview addSubview:shortScrollview];
    [self.mainscrollview bringSubviewToFront:shortScrollview];

    
    maincountr=0;
    
    int imgXValss=10;
    int maincouters=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        maincouters++;
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"series,primary video"]){
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            SeriesLbl=[[UILabel alloc]initWithFrame:CGRectMake(imgXValss+25,self.seriesScrollview.bounds.size.height-70,imageXValwidth-50,40)];
            [SeriesLbl setBackgroundColor:[UIColor clearColor]];
            [SeriesLbl setFont:[UIFont boldSystemFontOfSize: 35]];
            SeriesLbl.text=slvos.title;
            SeriesLbl.textColor=[UIColor whiteColor];

            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,10,imageXValwidth-50,self.seriesScrollview.bounds.size.height-25)];
            UIButton *transperentBtn= [UIButton buttonWithType:UIButtonTypeSystem];
            transperentBtn.frame=CGRectMake(imgXValss,10, imageXValwidth-50, self.seriesScrollview.bounds.size.height-25);
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.seriesScrollview addSubview:indicator];
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
                
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            [imgview setAdjustsImageWhenAncestorFocused:YES];
            [transperentBtn setNeedsFocusUpdate];
            [transperentBtn updateFocusIfNeeded];

            imgXValss=imgXValss+imageXValwidth+10;
            //[scrollviewImages addObject:imgview];
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=maincouters+100;
            [transperentBtn addTarget:self action:@selector(SeriesAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
            [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateFocused];
            [self.seriesScrollview addSubview:transperentBtn];
            [self.seriesScrollview addSubview:SeriesLbl];
        }
    }
    [self.mainscrollview addSubview:seriesScrollview];
    [self.mainscrollview bringSubviewToFront:seriesScrollview];

    maincouters=0;
    
    int igXVals=10;
    int maincount=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        maincount++;
        
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"Podcast"]){
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            podcastsLbl=[[UILabel alloc]initWithFrame:CGRectMake(igXVals+25,self.seriesScrollview.bounds.size.height-70,imageXValwidth-50,40)];
            [podcastsLbl setBackgroundColor:[UIColor clearColor]];
            [podcastsLbl setFont:[UIFont boldSystemFontOfSize: 35]];
            podcastsLbl.text=slvos.title;
            podcastsLbl.textColor=[UIColor whiteColor];

            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,10,imageXValwidth-50,self.podcastsScrollview.bounds.size.height-25)];
            UIButton *transperentBtn= [UIButton buttonWithType:UIButtonTypeSystem];
            transperentBtn.frame=CGRectMake(igXVals,10, imageXValwidth-50, self.podcastsScrollview.bounds.size.height-25);
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.podcastsScrollview addSubview:indicator];
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
                
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            [imgview setAdjustsImageWhenAncestorFocused:YES];
            [transperentBtn setNeedsFocusUpdate];
            [transperentBtn updateFocusIfNeeded];

            igXVals=igXVals+imageXValwidth+10;
            //[scrollviewImages addObject:imgview];
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=maincount+100;
            [transperentBtn addTarget:self action:@selector(PodcastsAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
            [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateFocused];
            [self.podcastsScrollview addSubview:transperentBtn];
            [self.podcastsScrollview addSubview:podcastsLbl];
        }
    }
    [self.mainscrollview addSubview:podcastsScrollview];
    [self.mainscrollview bringSubviewToFront:podcastsScrollview];

    maincount=0;
    
    int imgXVals=10;
    int maincounts=-1;
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        maincounts++;
        
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"Music"]){
            NSString *url=[[NSString alloc]init];
            
            url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
            
            MusicLbl=[[UILabel alloc]initWithFrame:CGRectMake(imgXVals+25,self.musicScrollview.bounds.size.height-70,imageXValwidth-50,40)];
            [MusicLbl setBackgroundColor:[UIColor clearColor]];
            [MusicLbl setFont:[UIFont boldSystemFontOfSize: 35]];
            MusicLbl.text=slvos.title;
            MusicLbl.textColor=[UIColor whiteColor];

            UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,10,imageXValwidth-50,self.musicScrollview.bounds.size.height-25)];
            UIButton *transperentBtn= [UIButton buttonWithType:UIButtonTypeSystem];
            transperentBtn.frame=CGRectMake(imgXVals,10, imageXValwidth-50, self.musicScrollview.bounds.size.height-25);
            imgview.clipsToBounds = YES;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicator startAnimating];
            [indicator setCenter:imgview.center];
            [self.musicScrollview addSubview:indicator];
            imgview.contentMode = UIViewContentModeScaleAspectFill;
            [imgview removeFromSuperview];
            [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
                
                [indicator stopAnimating];
            }];
            imgview.backgroundColor=[UIColor clearColor];
            [imgview setAdjustsImageWhenAncestorFocused:YES];
            [transperentBtn setNeedsFocusUpdate];
            [transperentBtn updateFocusIfNeeded];
            
            imgXVals=imgXVals+imageXValwidth+10;
            //[scrollviewImages addObject:imgview];
            transperentBtn.backgroundColor=[UIColor clearColor];
            transperentBtn.tag=maincounts+100;
            [transperentBtn addTarget:self action:@selector(MusicAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
            [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateFocused];

            [self.musicScrollview addSubview:transperentBtn];
            [self.musicScrollview bringSubviewToFront:transperentBtn];
            [self.musicScrollview addSubview:MusicLbl];
        }
    }
    [self.mainscrollview addSubview:musicScrollview];
    [self.mainscrollview bringSubviewToFront:musicScrollview];

    maincounts=0;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs stringForKey:@"firstname"]!=nil){
        [SignOut setTitle:@"Sign Out" forState:UIControlStateNormal];
        [SignOut addTarget:self action:@selector(LogOut) forControlEvents:UIControlEventPrimaryActionTriggered];
    }else{
        [SignOut setTitle:@"Sign In" forState:UIControlStateNormal];
        [SignOut addTarget:self action:@selector(SignInAction) forControlEvents:UIControlEventPrimaryActionTriggered];
        
    }
    SignOut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [SignOut setBackgroundColor:[UIColor clearColor]];
    SignOut.titleLabel.font = [UIFont systemFontOfSize: 20];
    [self.mainscrollview addSubview:SignOut];
    
    [msgLbl setFont:[UIFont boldSystemFontOfSize:20.0]];
    msgLbl.lineBreakMode = NSLineBreakByWordWrapping;
    msgLbl.numberOfLines = 0;
    [msgLbl setTextColor:[UIColor whiteColor]];
    NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
    NSString *lastChargoalwght =[prefs objectForKey:@"firstname"];
    NSString *wiglblstr=[prefss objectForKey:@"lastname"];
    NSString* firstBit = @"Signed in As ";
    NSString* firstBits = @"Version .01\nPrivacy Policy";
    NSString *texts;
    if ([prefs objectForKey:@"firstname"]!=nil) {
        texts = [NSString stringWithFormat:@"%@ %@ %@ %@",
                 firstBit,
                 lastChargoalwght,wiglblstr,firstBits];
        msgLbl.text=texts;
    
    }else{
        msgLbl.text=@"Version .01\nPrivacy Policy";
    }
    
    [self.mainscrollview addSubview:msgLbl];

    
}

-(IBAction)featureViewAction{
    FeatureViewController * feature;
        feature = [[FeatureViewController alloc] initWithNibName:@"FeatureViewController" bundle:nil];
    [self.navigationController pushViewController:feature animated:NO];
}
-(IBAction)shortViewAction{
    ShortsViewController * shorts;
        shorts = [[ShortsViewController alloc] initWithNibName:@"ShortsViewController" bundle:nil];
    [self.navigationController pushViewController:shorts animated:NO];
}
-(IBAction)seriesViewAction{
    SeriesViewController * series;
        series = [[SeriesViewController alloc] initWithNibName:@"SeriesViewController" bundle:nil];
    [self.navigationController pushViewController:series animated:NO];
}
-(IBAction)podcastsViewAction{
    PodcastsViewController * podcasts;
        podcasts = [[PodcastsViewController alloc] initWithNibName:@"PodcastsViewController" bundle:nil];
    [self.navigationController pushViewController:podcasts animated:NO];
}
-(IBAction)musicViewAction{
    MusicViewController * music;
        music = [[MusicViewController alloc] initWithNibName:@"MusicViewController" bundle:nil];
    [self.navigationController pushViewController:music animated:NO];
}
-(IBAction)LogOut{
    contiWatchArray=[[NSMutableArray alloc] init];

    NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
    [prefsid removeObjectForKey:@"user_id"];
    [prefss removeObjectForKey:@"firstname"];
    [prefs removeObjectForKey:@"lastname"];
    [self DisplayallView];
    [self overlayDisplay];

}

-(IBAction)SignInAction{
    SignInViewController * signin;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        signin = [[SignInViewController alloc] initWithNibName:@"SignInViewController~ipad" bundle:nil];
        
    }else{
        signin = [[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
    }
    [self.navigationController pushViewController:signin animated:NO];
}
-(IBAction)ContinueWatAction:(UIButton*)button{
    SeriesVO *cwvo=[contiWatchArray objectAtIndex:button.tag-100];
    appDelegate.videoPathStr=[[NSString alloc]init];
    appDelegate.timeStr=[[NSString alloc]init];
    
    PlayViewController * play;
    play = [[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
    appDelegate.videoPathStr=cwvo.video_id;
    appDelegate.timeStr=cwvo.time_paused;
    [self.navigationController pushViewController:play animated:NO];
}
-(IBAction)SpotlightAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
            appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
        
    }else{
                    episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
                    appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
        
    }
    
}
-(IBAction)PopularAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
        
    }else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
        
    }
    
}-(IBAction)TrendingAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
        
    }else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
        
    }
    
}
-(IBAction)FeatureAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
        
    }else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
        
    }
}
-(IBAction)ShortsAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
        
    }else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
        
    }
    
}
-(IBAction)MusicAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
        
    }else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
        
    }
}
-(IBAction)SeriesAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
        
    }else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
        
    }
    
}

-(IBAction)PodcastsAction:(UIButton*)button{
    TagCategoryDataVO *svo=[appDelegate.allTagMainCategoriesArray objectAtIndex:button.tag-100];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:NO];
        
    }else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        [self.navigationController pushViewController:episode animated:NO];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
