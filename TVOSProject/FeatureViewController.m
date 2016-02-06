//
//  FeatureViewController.m
//  TVOSProject
//
//  Created by arvind on 1/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "FeatureViewController.h"
#import "TagCategoryDataVO.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "AsyncImageView.h"
#import "DetailsViewController.h"
#import "EpisodeViewController.h"
#import "RegisterViewController.h"
#import "MusicViewController.h"
#import "SettingViewController.h"
#import "MusicViewController.h"
#import "SeriesViewController.h"
#import "ShortsViewController.h"
#import "PodcastsViewController.h"
#import "TestViewController.h"
#import "ShortsViewController.h"
#import "SearchViewController.h"
#import "SignInViewController.h"
#import "MyAccountViewController.h"
@interface FeatureViewController ()

@end

@implementation FeatureViewController

@synthesize activityIndicator,featureTableView,featureArray,appDelegate,overlayView,isMenuVisible,menuNameArray,menuNameButton,navigationmenuBtn,navigationSearchBtn,bloomimg;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    
    [activityIndicator stopAnimating];
    UIImageView *titleLabel = [[UIImageView alloc] init];
    [titleLabel setFrame:CGRectMake(50, 5, 170, 33)];
    //[titleLabel setText:@"BLOOM PROJECT"];
    [titleLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Bloom Project_Logo-white.png"]]];    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    
    /* SWRevealViewController *revealController = [self revealViewController];
     [revealController panGestureRecognizer];
     [revealController tapGestureRecognizer];*/
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
    //SeriesTableView.backgroundColor=[UIColor blackColor];
    featureArray=[[NSMutableArray alloc]init];
    
    
    //[self getFeatureData];
    for (int count=0; count<[appDelegate.allTagMainCategoriesArray count]; count++) {
        TagCategoryDataVO *slvos=[appDelegate.allTagMainCategoriesArray objectAtIndex:count];
        if([slvos.tagname isEqualToString:@"Feature Doc"]){
            [featureArray addObject:slvos];
        }
    }
    
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)SearchAction{
    SearchViewController *search;
    
    search=[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    [self.navigationController pushViewController:search animated:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    else
        return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    // Use this to allow upside down as well
    //return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}
-(void)menuButtonAction:(UIButton *)button{
    int tags=button.tag;
    if (tags==0) {
        TestViewController * home;
        home = [[TestViewController alloc] initWithNibName:@"TestViewController" bundle:nil];
        [self.navigationController pushViewController:home animated:YES];
    }else if (tags==1){
        if(!isMenuVisible)
        {
            overlayView.hidden=false;
            isMenuVisible=true;
            [self.view bringSubviewToFront:overlayView];
        }else{
            overlayView.hidden=true;
            isMenuVisible=false;
        }

    }else if (tags==2){
        ShortsViewController * shorts;
        shorts = [[ShortsViewController alloc] initWithNibName:@"ShortsViewController" bundle:nil];
        [self.navigationController pushViewController:shorts animated:YES];

           }else if (tags==3){
        SeriesViewController * series;
        series = [[SeriesViewController alloc] initWithNibName:@"SeriesViewController" bundle:nil];
        [self.navigationController pushViewController:series animated:YES];
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
        [self.navigationController pushViewController:signin animated:NO];
        
    }else if (tags==7){
        RegisterViewController * registers;
        registers = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
        appDelegate.index=0;
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
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(IBAction)menuScreenAction{
    if(!isMenuVisible)
    {
        overlayView.hidden=false;
        isMenuVisible=true;
        [self.view bringSubviewToFront:overlayView];
        
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
    [self.view addSubview:activityIndicator];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [featureArray count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    
    
    TagCategoryDataVO *serVO=[featureArray objectAtIndex:indexPath.row];
    NSString *url=[[NSString alloc]init];
    url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",serVO.key];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat yheightsspotlight = screenRect.size.width;
    CGFloat finalHeghtspotlight=yheightsspotlight/4*2-150;

    UIImageView *imgview;
    imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,finalHeghtspotlight)];
    imgview.clipsToBounds = YES;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator startAnimating];
    [indicator setCenter:imgview.center];
    [cell.contentView addSubview:indicator];
    
    imgview.contentMode = UIViewContentModeScaleAspectFill;
    [imgview removeFromSuperview];
    
    [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [indicator stopAnimating];
    }];

    
    imgview.backgroundColor=[UIColor clearColor];
    [cell.contentView addSubview:imgview];
    
        UILabel * userLblName=[[UILabel alloc] initWithFrame:CGRectMake(22,finalHeghtspotlight+5,400,30)];
        userLblName.lineBreakMode = NSLineBreakByWordWrapping;
        userLblName.numberOfLines = 0;
        [userLblName setFont:[UIFont boldSystemFontOfSize: 20]];
        userLblName.text=serVO.title;
        userLblName.textColor=[UIColor whiteColor];
        [cell.contentView addSubview:userLblName];
        
    
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat yheightsspotlight = screenRect.size.width;
    CGFloat finalHeghtspotlight=yheightsspotlight/4*2;
    return finalHeghtspotlight-100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCategoryDataVO *svo=[featureArray objectAtIndex:indexPath.row];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    DetailsViewController * details;
    EpisodeViewController * episode;
    if ([svo.series_name isEqualToString:@""]) {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController~ipad" bundle:nil];
            
        }else{
            details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
            
        }
        appDelegate.keyStr=[[NSString alloc]init];
        appDelegate.descStr=[[NSString alloc]init];
        appDelegate.titleStr=svo.title;
        appDelegate.keyStr=svo.key;
        appDelegate.descStr=svo.descr;
        appDelegate.countStr=1;
        [self.navigationController pushViewController:details animated:YES];
        
    }else{
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController~ipad" bundle:nil];
        }
        else{
            episode = [[EpisodeViewController alloc] initWithNibName:@"EpisodeViewController" bundle:nil];
            
        }
        appDelegate.titleStr=svo.title;
        appDelegate.series_name=svo.series_name;
        appDelegate.allEpisodeArray=svo.episodesArray;
        
        [self.navigationController pushViewController:episode animated:YES];
        
    }
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
