//
//  SegmentedViewController.h
//  segmentedControl
//
//  Created by sunsu on 15/6/11.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "segmentedHeader.h" 
@interface SegmentedViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIView * mainView;
@end
