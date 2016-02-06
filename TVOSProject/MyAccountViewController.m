//
//  MyAccountViewController.m
//  TVOSProject
//
//  Created by arvind on 1/28/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "MyAccountViewController.h"
#import "RegisterViewController.h"
#import "MusicViewController.h"
#import "SettingViewController.h"
#import "MusicViewController.h"
#import "SeriesViewController.h"
#import "FeatureViewController.h"
#import "ShortsViewController.h"
#import "PodcastsViewController.h"
#import "TestViewController.h"
#import "SearchViewController.h"
#import "SignInViewController.h"
#import "SettingViewController.h"
@interface MyAccountViewController ()

@end

@implementation MyAccountViewController
@synthesize appDelegate,activityIndicator,firstView,secondView,thirdView,fristBtn,secondBtn,thirdBtn,overlayView,isMenuVisible,menuNameArray,menuNameButton,navigationmenuBtn,navigationSearchBtn,bloomimg,continueBtn;
- (void)viewDidLoad  {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    [activityIndicator stopAnimating];
    UIImageView *titleLabel = [[UIImageView alloc] init];
    [titleLabel setFrame:CGRectMake(50, 5, 170, 33)];
    //[titleLabel setText:@"BLOOM PROJECT"];
    [titleLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Bloom Project_Logo-white.png"]]];    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    if ([appDelegate.registerStrCheck isEqualToString:@"Yes"]) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        [continueBtn removeFromSuperview];
        [continueBtn.titleLabel setFont:[UIFont systemFontOfSize:45]];
        continueBtn= [UIButton buttonWithType:UIButtonTypeSystem];
        continueBtn.frame=CGRectMake(24,735,screenWidth-50,70);
        [continueBtn addTarget:self action:@selector(continueAction) forControlEvents:UIControlEventPrimaryActionTriggered];
        [[continueBtn layer] setBorderWidth:1.0f];
        [continueBtn setTitle: @"Continue" forState: UIControlStateNormal];
        [[continueBtn layer] setBorderColor:[UIColor whiteColor].CGColor];
        [continueBtn.layer setCornerRadius:5.0];
        [self.view addSubview:continueBtn];
        [self.view bringSubviewToFront:continueBtn];

        continueBtn.hidden=NO;
        appDelegate.registerStrCheck=@"No";
    }else{
        continueBtn.hidden=YES;
    }

    /*SWRevealViewController *revealController = [self revealViewController];
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
    self.firstView.layer.borderWidth = 2.0f;
    self.firstView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.secondView.layer.borderWidth = 2.0f;
    self.secondView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.thirdView.layer.borderWidth = 2.0f;
    self.thirdView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [fristBtn setTag:0];
    [fristBtn setBackgroundImage:[UIImage imageNamed:@"radioOff.png"] forState:UIControlStateNormal];
    [fristBtn setBackgroundImage:[UIImage imageNamed:@"radioOn.png"] forState:UIControlStateSelected];
    [fristBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventPrimaryActionTriggered];
    
    
    [secondBtn setTag:1];
    [secondBtn setBackgroundImage:[UIImage imageNamed:@"radioOff.png"] forState:UIControlStateNormal];
    [secondBtn setBackgroundImage:[UIImage imageNamed:@"radioOn.png"] forState:UIControlStateSelected];
    [secondBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventPrimaryActionTriggered];
    
    [thirdBtn setTag:2];
    [thirdBtn setBackgroundImage:[UIImage imageNamed:@"radioOff.png"] forState:UIControlStateNormal];
    [thirdBtn setBackgroundImage:[UIImage imageNamed:@"radioOn.png"] forState:UIControlStateSelected];
    [thirdBtn addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventPrimaryActionTriggered];
    // Do any additional setup after loading the view from its nib.
    fristBtn.layer.cornerRadius=12.0;
    secondBtn.layer.cornerRadius=12.0;
    thirdBtn.layer.cornerRadius=12.0;
    
    UIFocusGuide *focusGuide = [[UIFocusGuide alloc]init];
    focusGuide.preferredFocusedView = [self preferredFocusedView];
    [self.view addLayoutGuide:focusGuide];

}
- (UIView *)preferredFocusedView
{
    
    return self.fristBtn.preferredFocusedView;
    
}

-(IBAction)continueAction{
    TestViewController *testhome;
    testhome=[[TestViewController alloc]initWithNibName:@"TestViewController" bundle:nil];
    
    [self.navigationController pushViewController:testhome animated:YES];
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
        FeatureViewController * feature;
        feature = [[FeatureViewController alloc] initWithNibName:@"FeatureViewController" bundle:nil];
        [self.navigationController pushViewController:feature animated:YES];
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
        appDelegate.index=6;
        [self.navigationController pushViewController:signin animated:YES];
    }else if (tags==7){
        RegisterViewController * registers;
        registers = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
        appDelegate.index=0;
        [self.navigationController pushViewController:registers animated:YES];
    }
    else if (tags==8){
        SettingViewController * setting;
        setting = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
        [self.navigationController pushViewController:setting animated:NO];
    }else if (tags==106){
        if(!isMenuVisible)
        {
            overlayView.hidden=false;
            isMenuVisible=true;
            [self.view bringSubviewToFront:overlayView];
            
        }else{
            overlayView.hidden=true;
            isMenuVisible=false;
        }    }
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
-(IBAction)SearchAction{
    SearchViewController *search;
    
    search=[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    [self.navigationController pushViewController:search animated:YES];
    
}
-(void)radiobuttonSelected:(id)sender{
    switch ([sender tag]) {
        case 0:
            if([fristBtn isSelected]==YES)
            {
                [fristBtn setSelected:NO];
                [secondBtn setSelected:NO];
                [thirdBtn setSelected:NO];
                
                
            }
            else{
                [fristBtn setSelected:YES];
                [secondBtn setSelected:NO];
                [thirdBtn setSelected:NO];
            }
            
            break;
        case 1:
            if([secondBtn isSelected]==YES)
            {
                [secondBtn setSelected:NO];
                [fristBtn setSelected:NO];
                [thirdBtn setSelected:NO];
            }
            else{
                [secondBtn setSelected:YES];
                [thirdBtn setSelected:NO];
                [fristBtn setSelected:NO];
                
            }
            
            break;
        case 2:
            if([thirdBtn isSelected]==YES)
            {
                [thirdBtn setSelected:NO];
                [fristBtn setSelected:NO];
                [secondBtn setSelected:NO];
            }
            else{
                [thirdBtn setSelected:YES];
                [fristBtn setSelected:NO];
                [secondBtn setSelected:NO];
                
            }
            
            break;
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
