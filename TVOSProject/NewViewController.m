//
//  NewViewController.m
//  TVOSProject
//
//  Created by MWC on 1/5/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController
@synthesize menuNameArray,menuNameButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   /* UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Press Me" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blackColor]];
    
    [button sizeToFit];
    
    // Set a new (x,y) point for the button's center
    button.center = CGPointMake(500, 500);
    [self.view addSubview:button];*/
    
     int yValue=70;
    for( int i = 0; i < 5; i++ ) {
       UIButton *aButton = [UIButton buttonWithType:UIButtonTypeSystem];
        aButton.frame = CGRectMake(17, yValue, self.view.bounds.size.width, 38);
        [aButton setTag:i];
        [aButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [aButton setTitle:@"Press Me" forState:UIControlStateNormal];
        [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [aButton sizeToFit];
        [self.view addSubview:aButton];
        yValue=yValue+150;
    }

    
     /*menuNameArray=[[NSMutableArray alloc]initWithObjects:@"Welcome",@"Feature Documentaries",@"Short Documentaries",@"Series",@"Podcasts",@"Music",@"Sign In",@"Register",@"Settings", nil];
    
    int yValue=70;
    for (int count=0; count<[menuNameArray count]; count++) {
        menuNameButton=[[UIButton alloc] initWithFrame:CGRectMake(17, yValue, self.view.bounds.size.width, 38)];
        [menuNameButton setTitle:[menuNameArray objectAtIndex:count] forState:UIControlStateNormal];
        menuNameButton.tag=count;
        if (count==8) {
            menuNameButton.titleLabel.font= [UIFont fontWithName:@"HelveticaNeue-Light" size:35.0f];
        }else{
            menuNameButton.titleLabel.font= [UIFont fontWithName:@"HelveticaNeue-Light" size:40.0f];
        }
        [menuNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuNameButton setBackgroundColor:[UIColor blackColor]];
        [menuNameButton addTarget:self action:@selector(menuButtonAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
        menuNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
      [self.view addSubview:menuNameButton];
        
        yValue=yValue+80;
    }*/

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
