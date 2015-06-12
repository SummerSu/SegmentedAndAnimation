//
//  segmentedHeader.h
//  segmentedControl
//
//  Created by sunsu on 15/6/11.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#ifndef segmentedControl_segmentedHeader_h
#define segmentedControl_segmentedHeader_h

#import "DVSwitch.h"
#import "SegmentedViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"

#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)

#define SCALE_WIDTH(w) (SCREEN_WIDTH/320.0*w)
#define SCALE_HEIGHT(h) (SCREEN_HEIGHT/568.0*h)

#define RECTFIX_WIDTH(a) (IS_IPHONE4 ? a : SCALE_WIDTH(a))
#define RECTFIX_HEIGHT(a) (IS_IPHONE4 ? a : SCALE_HEIGHT(a))

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define IS_IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE6_PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define APPLICATION ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define BACKBGROUND_TAG 1008
#define IMAGEVIEW_TAG   1009
#define CITYTABLEVIEW_TAG 1010

#define IOS_VERSION [UIDevice currentDevice].systemVersion


#endif
