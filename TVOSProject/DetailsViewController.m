//
//  DetailsViewController.m
//  TVOSProject
//
//  Created by arvind on 1/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "DetailsViewController.h"
#import "TagCategoryDataVO.h"
#import "SearchViewController.h"
#import "SeriesVO.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "PlayViewController.h"
@interface DetailsViewController ()

@end

@implementation DetailsViewController
@synthesize appDelegate,activityIndicator,userLblName,episodesynopsisLbl,descLbl,episodeNameLbl,episodeguideLbl,playBtn,imgview,transperentBtn,navigationmenuBtn,navigationSearchBtn,bloomimg,mainscrollview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate=[[UIApplication sharedApplication] delegate];
    [activityIndicator stopAnimating];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
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
    
    [navigationmenuBtn addTarget:self action:@selector(backAction)forControlEvents:UIControlEventPrimaryActionTriggered];
    [navigationmenuBtn setBackgroundImage: [UIImage imageNamed:@"arrow_left.png"] forState:UIControlStateNormal];
    [navigationmenuBtn setBackgroundImage: [UIImage imageNamed:@"arrow_left_black.PNG"] forState:UIControlStateFocused];
    [self.view addSubview:navigationmenuBtn];
    
    [navigationSearchBtn addTarget:self action:@selector(SearchAction)forControlEvents:UIControlEventPrimaryActionTriggered];
    [navigationSearchBtn setBackgroundImage: [UIImage imageNamed:@"searchicon.png"] forState:UIControlStateNormal];
    [navigationSearchBtn setBackgroundImage: [UIImage imageNamed:@"search_black.png"] forState:UIControlStateFocused];

    [self.view addSubview:navigationSearchBtn];
    
      
    
    UIButton *PreviewBtn,*AddtoMyListBtn,*ShareIconBtn,*iconBtn;
    NSString *url=[[NSString alloc]init];
    url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",appDelegate.keyStr];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat yheightsspotlight = screenRect.size.width;
    CGFloat finalHeghtspotlight=yheightsspotlight/4*2-150;
    CGFloat finalsswidth =finalHeghtspotlight/2;

        userLblName=[[UILabel alloc] initWithFrame:CGRectMake(10,70,450,40)];
        [userLblName setFont:[UIFont systemFontOfSize:30]];
        imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,120,screenRectwidth.size.width,finalHeghtspotlight)];
        transperentBtn= [UIButton buttonWithType:UIButtonTypeSystem];
        transperentBtn.frame=CGRectMake(0,120,screenRectwidth.size.width, finalHeghtspotlight);


        iconBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRectwidth.size.width/2-30,finalsswidth,90, 90)];
        PreviewBtn=[[UIButton alloc] initWithFrame:CGRectMake(35,finalHeghtspotlight+200,160, 40)];
        AddtoMyListBtn=[[UIButton alloc] initWithFrame:CGRectMake(250,finalHeghtspotlight+200,300, 40)];
        ShareIconBtn=[[UIButton alloc] initWithFrame:CGRectMake(540,finalHeghtspotlight+200, 200, 40)];
        [PreviewBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:35]];
        [AddtoMyListBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:35]];
        [ShareIconBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:35]];
        finalHeghtspotlight=finalHeghtspotlight+300;
        episodesynopsisLbl=[[UILabel alloc] initWithFrame:CGRectMake(20,finalHeghtspotlight,250,30)];
        [episodesynopsisLbl setFont:[UIFont boldSystemFontOfSize:24]];
    finalHeghtspotlight=finalHeghtspotlight+35;
        descLbl=[[UILabel alloc] initWithFrame:CGRectMake(20,finalHeghtspotlight,self.view.bounds.size.width-80,30)];
        [descLbl setFont:[UIFont boldSystemFontOfSize:24]];
    finalHeghtspotlight=finalHeghtspotlight+40;
        episodeguideLbl=[[UILabel alloc] initWithFrame:CGRectMake(20,finalHeghtspotlight,250,30)];
        [episodeguideLbl setFont:[UIFont boldSystemFontOfSize:24]];
        
    
    userLblName.text=appDelegate.titleStr;
    userLblName.textColor=[UIColor whiteColor];
    [self.view addSubview:userLblName];
    
    imgview.clipsToBounds = YES;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator startAnimating];
    [indicator setCenter:imgview.center];
    [self.view addSubview:indicator];
    imgview.contentMode = UIViewContentModeScaleAspectFill;
    [imgview removeFromSuperview];
    [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
        
        [indicator stopAnimating];
    }];
    imgview.backgroundColor=[UIColor clearColor];
    transperentBtn.backgroundColor=[UIColor clearColor];
    [transperentBtn addTarget:self action:@selector(PlayAction) forControlEvents:UIControlEventPrimaryActionTriggered];
    [self.mainscrollview addSubview:transperentBtn];
    [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateFocused];

    iconBtn.backgroundColor=[UIColor clearColor];
    [iconBtn addTarget:self action:@selector(PlayAction) forControlEvents:UIControlEventPrimaryActionTriggered];
    [iconBtn setBackgroundImage:[UIImage imageNamed:@"playimg_1.png"] forState:UIControlStateNormal];
    [self.mainscrollview addSubview:iconBtn];
    
    //[PreviewBtn addTarget:self action:@selector(RegisterAction) forControlEvents:UIControlEventTouchUpInside];
    [PreviewBtn setTitle: @"Preview" forState: UIControlStateNormal];
    [PreviewBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.mainscrollview addSubview:PreviewBtn];
    
    
    //[AddtoMyListBtn addTarget:self action:@selector(RegisterAction) forControlEvents:UIControlEventTouchUpInside];
    [AddtoMyListBtn setTitle: @"Add to My List" forState: UIControlStateNormal];
    [AddtoMyListBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.mainscrollview addSubview:AddtoMyListBtn];
    
    
    //[ShareIconBtn addTarget:self action:@selector(RegisterAction) forControlEvents:UIControlEventTouchUpInside];
    [ShareIconBtn setTitle: @"Share Icon" forState: UIControlStateNormal];
    [ShareIconBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.mainscrollview addSubview:ShareIconBtn];
    
    NSString *episStr=[NSString stringWithFormat:@"Epidode %d - Synopsis",appDelegate.countStr];
    episodesynopsisLbl.text=episStr;
    episodesynopsisLbl.textColor=[UIColor whiteColor];
    [self.mainscrollview addSubview:episodesynopsisLbl];
    
    
    
    descLbl.text=appDelegate.descStr;
    descLbl.lineBreakMode = NSLineBreakByWordWrapping;
    descLbl.numberOfLines = 0;
    descLbl.textColor=[UIColor whiteColor];
    [self.mainscrollview addSubview:descLbl];
    
    
    episodeguideLbl.text=@"Episode Guide";
    episodeguideLbl.textColor=[UIColor whiteColor];
    [self.mainscrollview addSubview:episodeguideLbl];
    
    finalHeghtspotlight=finalHeghtspotlight+60;
    for (int count=0; count<[appDelegate.allEpisodeArray count]; count++) {
        if (count==3) {
            break;
        }
        SeriesVO *svo=[appDelegate.allEpisodeArray objectAtIndex:count];
            episodeNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(30,finalHeghtspotlight,500,30)];
            [episodeNameLbl setFont:[UIFont boldSystemFontOfSize:26]];
            playBtn= [UIButton buttonWithType:UIButtonTypeSystem];
            playBtn.frame=CGRectMake(600,finalHeghtspotlight,400, 30);
            [playBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:26]];
       
        
        NSString *episStr=[NSString stringWithFormat:@"Epidode %d %@",count+1,svo.title];
        episodeNameLbl.text=episStr;
        episodeNameLbl.textColor=[UIColor whiteColor];
        [self.mainscrollview addSubview:episodeNameLbl];
        
        [playBtn addTarget:self action:@selector(playBtnAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
        
        playBtn.tag=count+100;
        [playBtn setTitle: @"Play Button" forState: UIControlStateNormal];
        [playBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [playBtn setTitleColor:[UIColor blackColor] forState:UIControlStateFocused];
        playBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.mainscrollview addSubview:playBtn];
        finalHeghtspotlight=finalHeghtspotlight+50;
        
    }
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    mainscrollview.contentSize = CGSizeMake(width,finalHeghtspotlight+100);
    mainscrollview.scrollEnabled=YES;
    
}
-(IBAction)backAction{
    [self.navigationController popViewControllerAnimated:NO];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(IBAction)SearchAction{
    SearchViewController *search;
        search=[[SearchViewController alloc] initWithNibName:@"SearchViewController~ipad" bundle:nil];
        [self.navigationController pushViewController:search animated:NO];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    appDelegate.shouldRotate=NO;
}



-(IBAction)playBtnAction:(UIButton*)button{
    
    SeriesVO *svo=[appDelegate.allEpisodeArray objectAtIndex:button.tag-100];
    NSString *url=[[NSString alloc]init];
    url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",svo.key];
    appDelegate.keyStr=svo.key;
    UIButton *iconBtn;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect screenRectwidth = [[UIScreen mainScreen] bounds];
    CGFloat yheightsspotlight = screenRectwidth.size.width;
    CGFloat finalHeghtspotlight=yheightsspotlight/4*2;
    CGFloat finalsswidth =finalHeghtspotlight/2;

    imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,120,screenRectwidth.size.width,finalHeghtspotlight)];
    transperentBtn= [UIButton buttonWithType:UIButtonTypeSystem];
    transperentBtn.frame=CGRectMake(0,120,screenRectwidth.size.width, finalHeghtspotlight);
    iconBtn=[[UIButton alloc] initWithFrame:CGRectMake(screenRectwidth.size.width/2-30,finalsswidth,90, 90)];
    
       imgview.clipsToBounds = YES;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [indicator startAnimating];
    [indicator setCenter:imgview.center];
    [self.view addSubview:indicator];
    imgview.contentMode = UIViewContentModeScaleAspectFill;
    [imgview removeFromSuperview];
    [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
        
        [indicator stopAnimating];
    }];
    imgview.backgroundColor=[UIColor clearColor];
        transperentBtn.backgroundColor=[UIColor clearColor];
    [transperentBtn addTarget:self action:@selector(PlayAction) forControlEvents:UIControlEventPrimaryActionTriggered];
    [self.mainscrollview addSubview:transperentBtn];
    [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateFocused];

    iconBtn.backgroundColor=[UIColor clearColor];
    [iconBtn addTarget:self action:@selector(PlayAction) forControlEvents:UIControlEventPrimaryActionTriggered];
    [iconBtn setBackgroundImage:[UIImage imageNamed:@"playimg_1.png"] forState:UIControlStateNormal];
    [self.mainscrollview addSubview:iconBtn];
    
    NSString *episStr=[NSString stringWithFormat:@"Epidode %ld - Synopsis",button.tag-99];
    episodesynopsisLbl.text=episStr;
    descLbl.text=svo.descr;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)PlayAction{
    
    PlayViewController *play=[[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
    appDelegate.videoPathStr=[NSString alloc];
    appDelegate.videoPathStr=appDelegate.keyStr;
    [self.navigationController pushViewController:play animated:NO];
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
