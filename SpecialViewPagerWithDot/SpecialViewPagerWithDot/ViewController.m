//
//  ViewController.m
//  TestSpecViewPager
//
//  Created by 史一峰 on 16/10/20.
//  Copyright © 2016年 史一峰. All rights reserved.
//

#import "ViewController.h"
#import "ViewPager.h"

@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic, strong)ViewPager* viewPager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.viewPager = [[ViewPager alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [self.view addSubview:self.viewPager];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
