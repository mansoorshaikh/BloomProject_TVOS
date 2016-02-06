//
//  EpisodeViewController.m
//  TVOSProject
//
//  Created by arvind on 1/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "EpisodeViewController.h"
#import "TagCategoryDataVO.h"
#import "DetailsViewController.h"
#import "SearchViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "SeriesVO.h"
#import "PlayViewController.h"
@interface EpisodeViewController ()

@end

@implementation EpisodeViewController
@synthesize activityIndicator,episodeTableView,episodeArray,appDelegate,nameLbl,navigationmenuBtn,navigationSearchBtn,bloomimg,mainscrollview,yheight;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate=[[UIApplication sharedApplication] delegate];
    
    [activityIndicator stopAnimating];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
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
    
    episodeArray=[[NSMutableArray alloc]init];
    nameLbl.text=appDelegate.titleStr;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat yheightsspotlight = screenRect.size.width;
    CGFloat finalHeghtspotlight=yheightsspotlight/4*2-150;
    CGFloat yheightsswidth = screenRect.size.height;
    CGFloat finalsswidth =finalHeghtspotlight/2;

    yheight=5;
   NSInteger counts=[appDelegate.allEpisodeArray count];
    mainscrollview.contentSize = CGSizeMake(width,finalHeghtspotlight*counts+400);
    mainscrollview.scrollEnabled=YES;
    for (int count=0; count<[appDelegate.allEpisodeArray count]; count++) {
        TagCategoryDataVO *slvos=[appDelegate.allEpisodeArray objectAtIndex:count];
        NSString *url=[[NSString alloc]init];
        url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",slvos.key];
        
        
        UIImageView *imgview;
        imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,yheight,self.view.bounds.size.width,finalHeghtspotlight)];
        UIButton *transperentBtn= [UIButton buttonWithType:UIButtonTypeSystem];
        transperentBtn.frame=CGRectMake(0,yheight,self.view.bounds.size.width,finalHeghtspotlight);
        transperentBtn.backgroundColor=[UIColor clearColor];
        transperentBtn.tag=count;
        
        
        imgview.clipsToBounds = YES;
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator startAnimating];
        [indicator setCenter:imgview.center];
        [self.mainscrollview addSubview:indicator];
        
        imgview.contentMode = UIViewContentModeScaleAspectFill;
        [imgview removeFromSuperview];
        [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
            
            [indicator stopAnimating];
        }];
        [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateFocused];
        imgview.backgroundColor=[UIColor clearColor];
        [transperentBtn addTarget:self action:@selector(DisplayPlayVideo:) forControlEvents:UIControlEventPrimaryActionTriggered];
        [self.mainscrollview addSubview:transperentBtn];
        UIButton * titleNameBtn= [UIButton buttonWithType:UIButtonTypeSystem];
        titleNameBtn.frame=CGRectMake(10,yheight+finalHeghtspotlight+10,self.view.bounds.size.width,30);
        [titleNameBtn setTitle:slvos.title forState:UIControlStateNormal];
        titleNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [titleNameBtn setBackgroundColor:[UIColor clearColor]];
        [titleNameBtn addTarget:self action:@selector(DisplayEpisodeList:) forControlEvents:UIControlEventPrimaryActionTriggered];
        titleNameBtn.tag=count;
        [titleNameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [titleNameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateFocused];
        titleNameBtn.titleLabel.font = [UIFont boldSystemFontOfSize: 30];
        [self.mainscrollview addSubview:titleNameBtn];
        
        UIButton *iconBtn=[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-45,finalsswidth-45,90, 90)];
        iconBtn.backgroundColor=[UIColor clearColor];
        [iconBtn setBackgroundImage:[UIImage imageNamed:@"playimg_1.png"] forState:UIControlStateNormal];
        [self.mainscrollview addSubview:iconBtn];
        yheight=yheight+finalHeghtspotlight+60;
        finalsswidth=finalHeghtspotlight+finalsswidth;
    }


}
-(void)viewDidAppear:(BOOL)animated{
    nameLbl.text=appDelegate.titleStr;
    
}

-(IBAction)backAction{
    [self.navigationController popViewControllerAnimated:NO];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void) threadStartAnimating:(id)data {
    [activityIndicator removeFromSuperview];
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicator.center=self.view.center;
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
}


-(IBAction)SearchAction{
    SearchViewController *search;
    
    search=[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    [self.navigationController pushViewController:search animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [appDelegate.allEpisodeArray count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    
    
    TagCategoryDataVO *serVO=[appDelegate.allEpisodeArray objectAtIndex:indexPath.row];
    NSString *url=[[NSString alloc]init];
    url = [NSString stringWithFormat:@"http://content.jwplatform.com/thumbs/%@.jpg",serVO.key];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat yheightsspotlight = screenRect.size.width;
    CGFloat yheightsswidth = screenRect.size.height;
    CGFloat finalHeghtspotlight=yheightsspotlight/4*2-200;
    CGFloat finalsswidth =finalHeghtspotlight/2;

        UIImageView *imgview;
        imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,finalHeghtspotlight)];
    UIButton *transperentBtn= [UIButton buttonWithType:UIButtonTypeSystem];
    transperentBtn.frame=CGRectMake(0,0,self.view.bounds.size.width,finalHeghtspotlight);
    transperentBtn.backgroundColor=[UIColor clearColor];
    transperentBtn.tag=indexPath.row;
    

        imgview.clipsToBounds = YES;
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator startAnimating];
        [indicator setCenter:imgview.center];
        [cell.contentView addSubview:indicator];
        
        imgview.contentMode = UIViewContentModeScaleAspectFill;
        [imgview removeFromSuperview];
    [imgview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateNormal];
        
        [indicator stopAnimating];
    }];
    [transperentBtn setBackgroundImage:imgview.image forState:UIControlStateFocused];
        imgview.backgroundColor=[UIColor clearColor];
    [transperentBtn addTarget:self action:@selector(DisplayEpisodeList:) forControlEvents:UIControlEventPrimaryActionTriggered];
        [cell.contentView addSubview:transperentBtn];

        UIButton * titleNameBtn= [UIButton buttonWithType:UIButtonTypeSystem];
        titleNameBtn.frame=CGRectMake(49,finalHeghtspotlight+10,self.view.bounds.size.width,30);
        [titleNameBtn setTitle:serVO.title forState:UIControlStateNormal];
        titleNameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [titleNameBtn setBackgroundColor:[UIColor clearColor]];
        [titleNameBtn addTarget:self action:@selector(DisplayEpisodeList:) forControlEvents:UIControlEventPrimaryActionTriggered];
        titleNameBtn.tag=indexPath.row;
        [titleNameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleNameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateFocused];
        titleNameBtn.titleLabel.font = [UIFont boldSystemFontOfSize: 30];
        [cell.contentView addSubview:titleNameBtn];

        UIButton *iconBtn=[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-40,finalsswidth-50,90, 90)];
        iconBtn.backgroundColor=[UIColor clearColor];
        [iconBtn setBackgroundImage:[UIImage imageNamed:@"playimg_1.png"] forState:UIControlStateNormal];
        [cell.contentView addSubview:iconBtn];
    
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat yheightsspotlight = screenRect.size.width;
    CGFloat finalHeghtspotlight=yheightsspotlight/4*2;
    return finalHeghtspotlight-80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    dispatch_async(dispatch_get_main_queue(), ^{
        // your navigation controller action goes here
        PlayViewController *play=[[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
        SeriesVO *svo=[appDelegate.allEpisodeArray objectAtIndex:indexPath.row];
        appDelegate.videoPathStr=[NSString alloc];
        appDelegate.videoPathStr=svo.key;
        [self.navigationController pushViewController:play animated:NO];
    });
}
-(void)DisplayPlayVideo:(UIButton*)button{
    dispatch_async(dispatch_get_main_queue(), ^{
        // your navigation controller action goes here
        PlayViewController *play=[[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
        SeriesVO *svo=[appDelegate.allEpisodeArray objectAtIndex:button.tag];
        appDelegate.videoPathStr=[NSString alloc];
        appDelegate.videoPathStr=svo.key;
        [self.navigationController pushViewController:play animated:NO];
    });
    
}

-(void)DisplayEpisodeList:(UIButton*)button{
    DetailsViewController * details;
    details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
    TagCategoryDataVO *svo=[appDelegate.allEpisodeArray objectAtIndex:button.tag];
    appDelegate.series_name=[[NSString alloc]init];
    appDelegate.keyStr=[[NSString alloc]init];
    appDelegate.descStr=[[NSString alloc]init];
    appDelegate.titleStr=[[NSString alloc]init];
    appDelegate.titleStr=svo.title;
    appDelegate.series_name=svo.series_name;
    appDelegate.descStr=svo.descr;
    appDelegate.keyStr=svo.key;
    appDelegate.countStr=button.tag+1;
    [self.navigationController pushViewController:details animated:NO];
    
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
