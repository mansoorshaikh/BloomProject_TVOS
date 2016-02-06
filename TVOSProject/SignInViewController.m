//
//  SignInViewController.m
//  TVOSProject
//
//  Created by MWC on 1/6/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "SignInViewController.h"
#import "Reachability.h"
#import "TestViewController.h"
#import "RegisterViewController.h"
#import "MusicViewController.h"
#import "SettingViewController.h"
#import "MusicViewController.h"
#import "SeriesViewController.h"
#import "FeatureViewController.h"
#import "ShortsViewController.h"
#import "PodcastsViewController.h"
#import "SearchViewController.h"
#import "RegisterViewController.h"
#import "MyAccountViewController.h"
@interface SignInViewController ()

@end

@implementation SignInViewController

@synthesize activityIndicator,emailTxt,passwordTxt,appDelegate,signBtn,overlayView,isMenuVisible,menuNameArray,menuNameButton,navigationmenuBtn,navigationSearchBtn,bloomimg;

-(UIView *)preferredFocusedView{
    
    return navigationmenuBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    [activityIndicator stopAnimating];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBarHidden=YES;
    
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
    
    emailTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    passwordTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    
    
    
     CGRect screenRect = [[UIScreen mainScreen] bounds];
     CGFloat screenWidth = screenRect.size.width;
     [signBtn removeFromSuperview];
     [signBtn.titleLabel setFont:[UIFont systemFontOfSize:45]];
     signBtn= [UIButton buttonWithType:UIButtonTypeSystem];
     signBtn.frame=CGRectMake(24,676,screenWidth-50,70);
     [signBtn addTarget:self action:@selector(LoginAction) forControlEvents:UIControlEventPrimaryActionTriggered];
     [[signBtn layer] setBorderWidth:1.0f];
     [signBtn setTitle: @"Sign In" forState: UIControlStateNormal];
     [[signBtn layer] setBorderColor:[UIColor whiteColor].CGColor];
     [signBtn.layer setCornerRadius:5.0];
     [self.view addSubview:signBtn];
     [self.view bringSubviewToFront:signBtn];

     
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:recognizer];

}
- (void)swipeDown:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"It works");
}

-(void)menuButtonAction:(UIButton *)button{
    int tags=button.tag;
    if (tags==0) {
        TestViewController * home;
            home = [[TestViewController alloc] initWithNibName:@"TestViewController" bundle:nil];
        [self.navigationController pushViewController:home animated:NO];
        
        
    }else if (tags==1){
        FeatureViewController * feature;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            feature = [[FeatureViewController alloc] initWithNibName:@"FeatureViewController~ipad" bundle:nil];
            
        }else{
            feature = [[FeatureViewController alloc] initWithNibName:@"FeatureViewController" bundle:nil];
        }
        [self.navigationController pushViewController:feature animated:NO];
    }else if (tags==2){
        ShortsViewController * shorts;
            shorts = [[ShortsViewController alloc] initWithNibName:@"ShortsViewController" bundle:nil];
        [self.navigationController pushViewController:shorts animated:NO];
    }else if (tags==3){
        SeriesViewController * series;
            series = [[SeriesViewController alloc] initWithNibName:@"SeriesViewController" bundle:nil];
        [self.navigationController pushViewController:series animated:NO];
    }else if (tags==4){
        PodcastsViewController * podcasts;
            podcasts = [[PodcastsViewController alloc] initWithNibName:@"PodcastsViewController" bundle:nil];
        [self.navigationController pushViewController:podcasts animated:NO];
    }else if (tags==5){
        MusicViewController * music;
            music = [[MusicViewController alloc] initWithNibName:@"MusicViewController" bundle:nil];
        [self.navigationController pushViewController:music animated:NO];
    }else if (tags==6){
        if(!isMenuVisible)
        {
            overlayView.hidden=false;
            isMenuVisible=true;
            [self.view bringSubviewToFront:overlayView];
            
        }else{
            overlayView.hidden=true;
            isMenuVisible=false;
        }
    }else if (tags==7){
        RegisterViewController * registers;
            registers = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
        [self.navigationController pushViewController:registers animated:NO];
        
    }else if (tags==8){
        SettingViewController * setting;
            setting = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
        [self.navigationController pushViewController:setting animated:NO];
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
        [self.view bringSubviewToFront:overlayView];
        [emailTxt resignFirstResponder];
        [passwordTxt resignFirstResponder];
        
    }else{
        overlayView.hidden=true;
        isMenuVisible=false;
        [emailTxt resignFirstResponder];
        [passwordTxt resignFirstResponder];
        
    }
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.emailTxt) {
        [self.passwordTxt becomeFirstResponder];
    }
    else if (textField == self.passwordTxt) {
        [self.passwordTxt resignFirstResponder];
        [self LoginAction];
    }
    return true;
}
-(IBAction)SearchAction{
    SearchViewController *search;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        search=[[SearchViewController alloc] initWithNibName:@"SearchViewController~ipad" bundle:nil];
        [self.navigationController pushViewController:search animated:NO];
    }else{
        search=[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
        [self.navigationController pushViewController:search animated:NO];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField==emailTxt){
        emailTxt.text=@"";
    }
    else if (textField==passwordTxt){
        passwordTxt.text=@"";
    }
    return YES;
}

- (void) threadStartAnimating:(id)data {
    //[activityIndicator removeFromSuperview];
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicator.center=self.view.center;
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];}

-(void)LoginAction{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
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

        
    }else if([emailTxt.text isEqualToString:@""] || [passwordTxt.text isEqualToString:@""]){
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"BloomProject"
                                                                       message:@"Please fill the values"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction]; // This is what I comment out
        [self presentViewController:alert animated:YES completion:nil];
        [activityIndicator stopAnimating];

    }else{
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://app.bloomproject.com/api/v1/login.php?email=%@&password=%@",emailTxt.text,passwordTxt.text];
        //NSString *urlString = [[NSString alloc]initWithFormat:@"http://app.bloomproject.com/api/v1/login.php?email=danielassael@gmail.com&password=1234"];
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                      length:[mydata length] encoding: NSUTF8StringEncoding];
        if([content isEqualToString:@"false"])
        {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"BloomProject"
                                                                           message:@"This user does not exist please check user name and password !!!"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction]; // This is what I comment out
            [self presentViewController:alert animated:YES completion:nil];
            [activityIndicator stopAnimating];
        }
        else{
            NSString *firstname=[[NSString alloc]init];
            NSString*lastname=[[NSString alloc]init];
            NSString*user_id=[[NSString alloc]init];
            
            NSError *error;
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            user_id=[userDict objectForKey:@"user_id"];
            
            NSUserDefaults *prefsid = [NSUserDefaults standardUserDefaults];
            [prefsid setObject:user_id forKey:@"user_id"];
            [prefsid synchronize];
            
            firstname=[userDict objectForKey:@"user_first_name"];
            lastname=[userDict objectForKey:@"user_last_name"];
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:firstname forKey:@"firstname"];
            [prefs synchronize];
            
            NSUserDefaults *prefss = [NSUserDefaults standardUserDefaults];
            [prefss setObject:lastname forKey:@"lastname"];
            [prefss synchronize];
            
            [activityIndicator stopAnimating];
            TestViewController *testhome;
                testhome=[[TestViewController alloc]initWithNibName:@"TestViewController" bundle:nil];
            [self.navigationController pushViewController:testhome animated:NO];
            
        }
    }
    [activityIndicator stopAnimating];
    
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
