//
//  SplashScreenViewController.m
//  TVOSProject
//
//  Created by arvind on 1/4/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "TagCategoryDataVO.h"
#import "TestViewController.h"
@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

@synthesize tagsArray,appDelegate,activityIndicator,splashImg,window;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    [activityIndicator stopAnimating];
    appDelegate=[[UIApplication sharedApplication] delegate];
    tagsArray=[[NSMutableArray alloc]initWithObjects:@"Spotlight",@"Popular",@"Trending Now",@"Feature Doc",@"Short Doc",@"Series",@"Podcast",@"Music", nil];
    // Do any additional setup after loading the view from its nib.
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    
}

- (void) threadStartAnimating:(id)data {
    [activityIndicator removeFromSuperview];
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicator.center=self.view.center;
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSMutableArray *tagsAccessArray=[[NSMutableArray alloc]initWithObjects:@"Spotlight",@"popular",@"trending",@"Feature Doc",@"Short Doc",@"series,primary video",@"Podcast",@"Music",@"Continue Watching", nil];
    
    for (int tagcount=0; tagcount<[tagsAccessArray count]; tagcount++) {
        
        [self loadAllContentsWithTag:[tagsAccessArray objectAtIndex:tagcount]];
    }
    TestViewController *thvc;
        thvc=[[TestViewController alloc] initWithNibName:@"TestViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:thvc];
    [[[UIApplication sharedApplication] delegate] window].rootViewController=navController;
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];

}


-(void)loadAllContentsWithTag:(NSString*)tagName{
    
    
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
    
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://app.bloomproject.com/api/v1/getVideo.php?tag=%@&limit=3&sort=date&direction=asc",tagName];
    
    
    
    
    
    NSLog(@"string url %@",urlString);
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                         
                                                  length:[mydata length] encoding: NSUTF8StringEncoding];
    NSError *error;
    
    NSDictionary *videosDict=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
    
    NSArray *videosArray = [videosDict objectForKey:@"videos"];
    
    for (int count=0; count<[videosArray count]; count++) {
        
        NSDictionary *videosData=[videosArray objectAtIndex:count];
        
        
        TagCategoryDataVO *tagcatVO=[[TagCategoryDataVO alloc] init];
        
        tagcatVO.status=[[NSString alloc] init];
        tagcatVO.sourceurl=[[NSString alloc] init];
        tagcatVO.descr=[[NSString alloc] init];
        tagcatVO.title=[[NSString alloc] init];
        tagcatVO.views=[[NSString alloc] init];
        tagcatVO.tags=[[NSString alloc] init];
        tagcatVO.sourceformat=[[NSString alloc] init];
        tagcatVO.mediatype=[[NSString alloc] init];
        tagcatVO.custom=[[NSString alloc] init];
        tagcatVO.series_name=[[NSString alloc] init];
        tagcatVO.duration=[[NSString alloc] init];
        tagcatVO.upload_session_id=[[NSString alloc] init];
        tagcatVO.link=[[NSString alloc] init];
        tagcatVO.author=[[NSString alloc] init];
        tagcatVO.key=[[NSString alloc] init];
        tagcatVO.error=[[NSString alloc] init];
        tagcatVO.date=[[NSString alloc] init];
        tagcatVO.md5=[[NSString alloc] init];
        tagcatVO.sourcetype=[[NSString alloc] init];
        tagcatVO.size=[[NSString alloc] init];
        tagcatVO.episodesArray=[[NSMutableArray alloc] init];
        tagcatVO.tagname=[[NSString alloc] init];
        
        
        if ([videosData objectForKey:@"status"] != [NSNull null])
            tagcatVO.status=[videosData objectForKey:@"status"];
        tagcatVO.sourceurl=[videosData objectForKey:@"sourceurl"];
        tagcatVO.descr=[videosData objectForKey:@"description"];
        tagcatVO.title=[videosData objectForKey:@"title"];
        tagcatVO.views=[videosData objectForKey:@"views"];
        tagcatVO.tags=[videosData objectForKey:@"tags"];
        tagcatVO.sourceformat=[videosData objectForKey:@"sourceformat"];
        tagcatVO.mediatype=[videosData objectForKey:@"mediatype"];
        tagcatVO.custom=[videosData objectForKey:@"custom"];
        NSArray *userArrays=[videosData objectForKey:@"custom"];
        if (![userArrays isKindOfClass:[NSArray class]]){
            NSDictionary *activityDatas=[videosData objectForKey:@"custom"];
            tagcatVO.series_name=[activityDatas objectForKey:@"series_name"];
            if(![tagcatVO.series_name isEqualToString:@""]){
                [self getAllEpisodes:tagcatVO.series_name :tagName :tagcatVO.episodesArray];
            }
        }
        tagcatVO.duration=[videosData objectForKey:@"duration"];
        tagcatVO.upload_session_id=[videosData objectForKey:@"upload_session_id"];
        tagcatVO.link=[videosData objectForKey:@"link"];
        tagcatVO.author=[videosData objectForKey:@"author"];
        tagcatVO.key=[videosData objectForKey:@"key"];
        tagcatVO.error=[videosData objectForKey:@"error"];
        tagcatVO.date=[videosData objectForKey:@"date"];
        tagcatVO.md5=[videosData objectForKey:@"md5"];
        tagcatVO.sourcetype=[videosData objectForKey:@"sourcetype"];
        tagcatVO.size=[videosData objectForKey:@"size"];
        tagcatVO.tagname=tagName;
        [appDelegate.allTagMainCategoriesArray addObject:tagcatVO];
    }
    
    [activityIndicator stopAnimating];
    
    
}

-(void)getAllEpisodes:(NSString*)series_name:(NSString*)tagName:(NSMutableArray*)episodesArray{
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://app.bloomproject.com/api/v1/getVideo.php?tag=%@",series_name];
    
    NSLog(@"string url %@",urlString);
    NSData *mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSString *content = [[NSString alloc]  initWithBytes:[mydata bytes]
                         
                                                  length:[mydata length] encoding: NSUTF8StringEncoding];
    NSError *error;
    
    NSDictionary *videosDict=[NSJSONSerialization JSONObjectWithData:mydata options:0 error:&error];
    
    NSArray *videosArray = [videosDict objectForKey:@"videos"];
    
    for (int count=0; count<[videosArray count]; count++) {
        
        NSDictionary *videosData=[videosArray objectAtIndex:count];
        
        
        TagCategoryDataVO *tagcatVO=[[TagCategoryDataVO alloc] init];
        
        tagcatVO.status=[[NSString alloc] init];
        tagcatVO.sourceurl=[[NSString alloc] init];
        tagcatVO.descr=[[NSString alloc] init];
        tagcatVO.title=[[NSString alloc] init];
        tagcatVO.views=[[NSString alloc] init];
        tagcatVO.tags=[[NSString alloc] init];
        tagcatVO.sourceformat=[[NSString alloc] init];
        tagcatVO.mediatype=[[NSString alloc] init];
        tagcatVO.custom=[[NSString alloc] init];
        tagcatVO.series_name=[[NSString alloc] init];
        tagcatVO.duration=[[NSString alloc] init];
        tagcatVO.upload_session_id=[[NSString alloc] init];
        tagcatVO.link=[[NSString alloc] init];
        tagcatVO.author=[[NSString alloc] init];
        tagcatVO.key=[[NSString alloc] init];
        tagcatVO.error=[[NSString alloc] init];
        tagcatVO.date=[[NSString alloc] init];
        tagcatVO.md5=[[NSString alloc] init];
        tagcatVO.sourcetype=[[NSString alloc] init];
        tagcatVO.size=[[NSString alloc] init];
        tagcatVO.episodesArray=[[NSMutableArray alloc] init];
        tagcatVO.tagname=[[NSString alloc] init];
        
        if ([videosData objectForKey:@"status"] != [NSNull null])
            tagcatVO.status=[videosData objectForKey:@"status"];
        tagcatVO.sourceurl=[videosData objectForKey:@"sourceurl"];
        tagcatVO.descr=[videosData objectForKey:@"description"];
        tagcatVO.title=[videosData objectForKey:@"title"];
        tagcatVO.views=[videosData objectForKey:@"views"];
        tagcatVO.tags=[videosData objectForKey:@"tags"];
        tagcatVO.sourceformat=[videosData objectForKey:@"sourceformat"];
        tagcatVO.mediatype=[videosData objectForKey:@"mediatype"];
        tagcatVO.custom=[videosData objectForKey:@"custom"];
        NSArray *userArrays=[videosData objectForKey:@"custom"];
        if (![userArrays isKindOfClass:[NSArray class]]){
            NSDictionary *activityDatas=[videosData objectForKey:@"custom"];
            tagcatVO.series_name=[activityDatas objectForKey:@"series_name"];
            if(![tagcatVO.series_name isEqualToString:@""]){
                
            }
        }
        tagcatVO.duration=[videosData objectForKey:@"duration"];
        tagcatVO.upload_session_id=[videosData objectForKey:@"upload_session_id"];
        tagcatVO.link=[videosData objectForKey:@"link"];
        tagcatVO.author=[videosData objectForKey:@"author"];
        tagcatVO.key=[videosData objectForKey:@"key"];
        tagcatVO.error=[videosData objectForKey:@"error"];
        tagcatVO.date=[videosData objectForKey:@"date"];
        tagcatVO.md5=[videosData objectForKey:@"md5"];
        tagcatVO.sourcetype=[videosData objectForKey:@"sourcetype"];
        tagcatVO.size=[videosData objectForKey:@"size"];
        tagcatVO.tagname=tagName;
        tagcatVO.series_name=series_name;
        [episodesArray addObject:tagcatVO];
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
