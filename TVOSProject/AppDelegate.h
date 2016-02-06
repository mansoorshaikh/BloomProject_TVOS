//
//  AppDelegate.h
//  TVOSProject
//
//  Created by arvind on 1/3/16.
//  Copyright © 2016 arvind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,readwrite) int index,indexs;
@property (nonatomic,retain) NSString *series_name,*descStr,*keyStr,*titleStr,*videoPathStr,*timeStr,*registerStrCheck;
@property(nonatomic,retain) NSMutableArray *allEpisodeArray,*allTagMainCategoriesArray;
@property(nonatomic,readwrite) int countStr;
@property(nonatomic,readwrite) BOOL isLandscapeOK;
@property (assign, nonatomic) BOOL shouldRotate;

@end

