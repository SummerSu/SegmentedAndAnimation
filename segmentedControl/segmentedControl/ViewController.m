//
//  ViewController.m
//  segmentedControl
//
//  Created by sunsu on 15/6/11.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "ViewController.h"
#import "segmentedHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    btn.backgroundColor =  RGBCOLOR(50, 60, 70);
    [btn addTarget:self action:@selector(Gonext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)Gonext{
    SegmentedViewController * vc = [[SegmentedViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
