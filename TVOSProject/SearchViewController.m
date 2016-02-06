//
//  SearchViewController.m
//  TVOSProject
//
//  Created by arvind on 1/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "SearchViewController.h"
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
#import "SettingViewController.h"
#import "TagCategoryDataVO.h"
#import "Reachability.h"
#import "DetailsViewController.h"
#import "EpisodeViewController.h"
#import "TestViewController.h"
#import "SignInViewController.h"
#import "SeriesVO.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "MyAccountViewController.h"
@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize appDelegate,activityIndicator,SearchTableView,searchArray,SearchBar,overlayView,isMenuVisible,menuNameArray,menuNameButton,SearchText,searchLblinfo,navigationmenuBtn,navigationSearchBtn,bloomimg,mainscrollview;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    [activityIndicator stopAnimating];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBarHidden=YES;
    
    self.SearchBar.backgroundColor = [UIColor clearColor];
    
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
    
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
        [SearchTableView removeFromSuperview];
        SearchTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,150,self.view.bounds.size.width,self.view.bounds.size.height-350)];
        SearchTableView.backgroundColor=[UIColor clearColor];
        [self.view addSubview:SearchTableView];
        [self.view bringSubviewToFront:SearchTableView];
        
        SearchTableView.delegate = self;
    SearchTableView.dataSource = self;
    
    SearchBar.backgroundColor = [UIColor blackColor];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    mainscrollview.contentSize = CGSizeMake(width,height);
    mainscrollview.scrollEnabled=YES;

    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    if (searchArray.count==0) {
        searchLblinfo=[[UILabel alloc] initWithFrame:CGRectMake(50,250,280,60)];
        [searchLblinfo setFont:[UIFont boldSystemFontOfSize:20.0]];
        searchLblinfo.lineBreakMode = NSLineBreakByWordWrapping;
        searchLblinfo.numberOfLines = 0;
        searchLblinfo.text=@"Enter a show or video name to search the Bloom app";
        searchLblinfo.textColor=[UIColor whiteColor];
        [self.view addSubview:searchLblinfo];
        [self.view bringSubviewToFront:searchLblinfo];
    }
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
        
        [self.navigationController pushViewController:home animated:NO];
        
        
    }else if (tags==1){
        FeatureViewController * feature;
            feature = [[FeatureViewController alloc] initWithNibName:@"FeatureViewController" bundle:nil];
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
        SignInViewController * signin;
            signin = [[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
        [self.navigationController pushViewController:signin animated:NO];
        
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
-(IBAction)SearchAction{
    SearchViewController *search=[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    [self.navigationController pushViewController:search animated:NO];
    
}
- (void) threadStartAnimating:(id)data {
    [activityIndicator removeFromSuperview];
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicator.center=self.view.center;
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];}

-(void)getSearchData{
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    searchArray=[[NSMutableArray alloc]init];
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    if(myStatus == NotReachable)
    {
        [activityIndicator stopAnimating];
        
    }else{
        
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://app.bloomproject.com/api/v1/search.php?q=%@&limit=50&sort=date&direction=asc",SearchText.text];
        NSLog(@"string url %@",urlString);
        NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        if (mydata != nil){
            NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                                                          length:[mydata length] encoding: NSUTF8StringEncoding];
            NSError *error;
            NSDictionary *userDict=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
            NSArray *userArray = [userDict objectForKey:@"videos"];
            for (int count=0; count<[userArray count]; count++) {
                
                NSDictionary *activityData=[userArray objectAtIndex:count];
                SeriesVO *csvo=[[SeriesVO alloc] init];
                csvo.status=[[NSString alloc] init];
                csvo.sourceurl=[[NSString alloc] init];
                csvo.descr=[[NSString alloc] init];
                csvo.title=[[NSString alloc] init];
                csvo.views=[[NSString alloc] init];
                csvo.tags=[[NSString alloc] init];
                csvo.sourceformat=[[NSString alloc] init];
                csvo.mediatype=[[NSString alloc] init];
                csvo.custom=[[NSString alloc] init];
                csvo.series_name=[[NSString alloc] init];
                csvo.duration=[[NSString alloc] init];
                csvo.upload_session_id=[[NSString alloc] init];
                csvo.link=[[NSString alloc] init];
                csvo.author=[[NSString alloc] init];
                csvo.key=[[NSString alloc] init];
                csvo.error=[[NSString alloc] init];
                csvo.date=[[NSString alloc] init];
                csvo.md5=[[NSString alloc] init];
                csvo.sourcetype=[[NSString alloc] init];
                csvo.size=[[NSString alloc] init];
                if ([activityData objectForKey:@"status"] != [NSNull null])
                    csvo.status=[activityData objectForKey:@"status"];
                csvo.sourceurl=[activityData objectForKey:@"sourceurl"];
                csvo.descr=[activityData objectForKey:@"description"];
                csvo.title=[activityData objectForKey:@"title"];
                csvo.views=[activityData objectForKey:@"views"];
                csvo.tags=[activityData objectForKey:@"tags"];
                csvo.sourceformat=[activityData objectForKey:@"sourceformat"];
                csvo.mediatype=[activityData objectForKey:@"mediatype"];
                csvo.custom=[activityData objectForKey:@"custom"];
                NSArray *userArrays=[activityData objectForKey:@"custom"];
                if (![userArrays isKindOfClass:[NSArray class]]){
                    NSDictionary *activityDatas=[activityData objectForKey:@"custom"];
                    csvo.series_name=[activityDatas objectForKey:@"series_name"];
                }
                
                csvo.duration=[activityData objectForKey:@"duration"];
                csvo.upload_session_id=[activityData objectForKey:@"upload_session_id"];
                csvo.link=[activityData objectForKey:@"link"];
                csvo.author=[activityData objectForKey:@"author"];
                csvo.key=[activityData objectForKey:@"key"];
                csvo.error=[activityData objectForKey:@"error"];
                csvo.date=[activityData objectForKey:@"date"];
                csvo.md5=[activityData objectForKey:@"md5"];
                csvo.sourcetype=[activityData objectForKey:@"sourcetype"];
                csvo.size=[activityData objectForKey:@"size"];
                [searchArray addObject:csvo];
            }
        }
        [activityIndicator stopAnimating];
    }
    [activityIndicator stopAnimating];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Search Implementation

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    mainscrollview.contentSize = CGSizeMake(width,height);

    if([SearchText.text isEqualToString:@""]){
        SearchText.text=@"Search";
    }else{
        [self getSearchData];
        if (searchArray.count==0) {
            [SearchTableView removeFromSuperview];
            searchLblinfo=[[UILabel alloc] initWithFrame:CGRectMake(50,250,280,60)];
            [searchLblinfo setFont:[UIFont boldSystemFontOfSize:20.0]];
            searchLblinfo.lineBreakMode = NSLineBreakByWordWrapping;
            searchLblinfo.numberOfLines = 0;
            searchLblinfo.text=@"Enter a show or video name to search the Bloom app";
            searchLblinfo.textColor=[UIColor whiteColor];
            [self.view addSubview:searchLblinfo];
            [self.view bringSubviewToFront:searchLblinfo];
        }else{
            [searchLblinfo removeFromSuperview];
            [self.view addSubview:SearchTableView];
            [self.view bringSubviewToFront:SearchTableView];
            [SearchTableView reloadData];
        }
    }
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField==SearchText){
        SearchText.text=@"";
        if (searchArray.count>0) {
            CGFloat height = [UIScreen mainScreen].bounds.size.height;
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            mainscrollview.contentSize = CGSizeMake(width,height+330);
        }

    }
    return YES;
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}
/*-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
 {
 if(searchText.length != 0){
 isSearching = YES;
 [self searchTableList];
 
 }else {
 isSearching = NO;
 filteredContentList=[[NSMutableArray alloc]init];
 filteredContentList=merchantsArray;
 // tblContentList.hidden=YES;
 }
 [merchantTableview reloadData];
 }
 */
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.SearchBar resignFirstResponder];
    [self getSearchData];
    [SearchTableView reloadData];
    
    NSLog(@"Cancel clicked");
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
    [self.SearchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)asearchBar {
    NSLog(@"Search Clicked");
    [self.SearchBar resignFirstResponder];
    if(SearchBar.text  !=nil) {
        [self getSearchData];
    }else {
        // tblContentList.hidden=YES;
    }
    [SearchTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [searchArray count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    
    
    SeriesVO *sVO=[searchArray objectAtIndex:indexPath.row];
    NSString *url=[[NSString alloc]init];
    url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",sVO.key];
    
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
        
        
        UILabel * userLblName=[[UILabel alloc] initWithFrame:CGRectMake(22,finalHeghtspotlight+5,270,30)];
        userLblName.lineBreakMode = NSLineBreakByWordWrapping;
        userLblName.numberOfLines = 0;
        [userLblName setFont:[UIFont boldSystemFontOfSize: 16]];
        userLblName.text=sVO.title;
        userLblName.textColor=[UIColor whiteColor];
        [cell.contentView addSubview:userLblName];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    SeriesVO *svo=[searchArray objectAtIndex:indexPath.row];
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
        [self.navigationController pushViewController:episode animated:NO];
        
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
