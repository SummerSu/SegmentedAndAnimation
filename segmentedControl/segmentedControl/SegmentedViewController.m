//
//  SegmentedViewController.m
//  segmentedControl
//
//  Created by sunsu on 15/6/11.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "SegmentedViewController.h"

@interface SegmentedViewController (){
    UIView * firstView;
    UIView * secondView;
    UITableView *displayTableView;
    long tableViewY;
    UILabel * firstLabel;
}

@end

@implementation SegmentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //mainView
    if (_mainView) {
        [_mainView removeFromSuperview];
    }else{
        CGRect mainViewFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _mainView = [[UIView alloc]initWithFrame:mainViewFrame];
        _mainView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_mainView];
    }
    
    //segmented
    CGRect segmentedFrame = CGRectMake(RECTFIX_WIDTH(10), RECTFIX_HEIGHT(40), SCREEN_WIDTH-RECTFIX_WIDTH(10)*2, 40);
    NSArray * segmentedTitleArray = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    DVSwitch * switcher = [[DVSwitch alloc]initWithStringsArray:segmentedTitleArray];
    switcher.frame = segmentedFrame;
    [switcher forceSelectedIndex:0 animated:YES];
    [_mainView addSubview:switcher];
    
    CGFloat y = CGRectGetMaxY(switcher.frame)+RECTFIX_HEIGHT(10);
    
    firstView = [[UIView alloc]initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, SCREEN_HEIGHT-y)];
    firstView.backgroundColor = [UIColor whiteColor];;
    [self initFirstViewUI];
    [_mainView addSubview:firstView];
    

    secondView = [[UIView alloc]initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, SCREEN_HEIGHT-y)];
    secondView.backgroundColor = [UIColor whiteColor];;
    [self initSecondViewUI];
    secondView.hidden = YES;
    [_mainView addSubview:secondView];
    
    //switcher 回调方法
    [switcher setPressedHandler:^(NSUInteger index) {
        switch (index) {
            case 0:
            {
                firstView.hidden = NO;
                secondView.hidden = YES;
            }
                break;
            case 1:
            {
                firstView.hidden   = YES;
                secondView.hidden  = NO;
            }
                break;
                
            default:
                break;
        }
    }];
    
    //createTableView
    tableViewY = 100;
    [self createTableView];
    
    
}

-(void)createTableView{
    displayTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 100, RECTFIX_WIDTH(280), RECTFIX_HEIGHT(320)) style:UITableViewStylePlain];
    displayTableView.delegate = self;
    displayTableView.dataSource = self;
    
    //iOS 适配分割线不全的问题
    if ([IOS_VERSION intValue]>=7) {
        if ([displayTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            if ([IOS_VERSION intValue]>=7.0) {
                [displayTableView setSeparatorInset:UIEdgeInsetsZero];
            }
        }
        if ([displayTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            if ([IOS_VERSION intValue]>=8.0) {
                [displayTableView setLayoutMargins:UIEdgeInsetsZero];
            }
        }
    }
    displayTableView.tag = CITYTABLEVIEW_TAG;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)initFirstViewUI{
    //初始化第一个界面，可以封装好的
    firstLabel  = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 60, 40)];
    firstLabel.text = @"table show";
    firstLabel.layer.cornerRadius = 10;
    firstLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    firstLabel.layer.borderWidth = 1;
    [firstView addSubview:firstLabel];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [firstLabel addGestureRecognizer:tapGesture];
    firstLabel.userInteractionEnabled = YES;
}



-(void)initSecondViewUI{
    UILabel * label  = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 40)];
    label.text = @"this is second label ";
    [secondView addSubview:label];
}


-(void)tapAction:(id)sender{
    UIView * bgView = [APPLICATION.window viewWithTag:BACKBGROUND_TAG];
    if (!bgView) {
        bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        bgView.alpha = 0.5;
        bgView.backgroundColor = [UIColor blackColor];
        bgView.tag = BACKBGROUND_TAG;
        [APPLICATION.window addSubview:bgView];
        [APPLICATION.window addSubview:displayTableView];
        [firstLabel removeFromSuperview];
        [APPLICATION.window addSubview:firstLabel];
        
        displayTableView.frame = CGRectMake(20, tableViewY, displayTableView.frame.size.width, 0);
        [UIView beginAnimations:@"show" context:nil];
        [UIView setAnimationDuration:0.3];
        displayTableView.frame = CGRectMake(20, tableViewY, displayTableView.frame.size.width, RECTFIX_HEIGHT(320));
        firstLabel.frame = CGRectMake(firstLabel.frame.origin.x, CGRectGetMaxY(displayTableView.frame), CGRectGetWidth(firstLabel.frame), CGRectGetHeight(firstLabel.frame));
        firstLabel.text = @"hidden";
        [UIView commitAnimations];
        
    }else{
        [self hideDisplayTable];
    }
    
}

-(void)hideDisplayTable{
    UIView * bgView = [APPLICATION.window viewWithTag:BACKBGROUND_TAG];
    if (bgView) {
        [UIView beginAnimations:@"hide" context:nil];
        [UIView  setAnimationDuration:0.3];
        displayTableView.frame = CGRectMake(20, tableViewY, displayTableView.frame.size.width, 0);
        firstLabel.frame = CGRectMake(firstLabel.frame.origin.x, tableViewY, CGRectGetWidth(firstLabel.frame), CGRectGetHeight(firstLabel.frame));
        firstLabel.text = @"click";
        [UIView setAnimationDidStopSelector:@selector(hideAnimationDidStop)];
        [UIView setAnimationDelegate:self];
        [UIView commitAnimations];
    }
}

-(void)hideAnimationDidStop{
    UIView * bgView = [APPLICATION.window viewWithTag:BACKBGROUND_TAG];
    if (bgView) {
        [bgView removeFromSuperview];
        [firstLabel removeFromSuperview];
        [firstView addSubview:firstLabel];
        //[secondView addSubview:firstLabel];
        firstLabel.frame = CGRectMake(firstLabel.frame.origin.x, 0, CGRectGetWidth(firstLabel.frame), CGRectGetHeight(firstLabel.frame));
        [displayTableView removeFromSuperview];
    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    cell.backgroundColor = [UIColor clearColor];
    NSArray * array = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    // 避免复用
    cell.textLabel.text=@"";
    if (array.count>indexPath.row) {
        cell.textLabel.text = [array objectAtIndex:indexPath.row];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
