//
//  MiddleViewController.m
//  MBGuideHUD
//
//  Created by 罗壮燊 on 16/8/24.
//  Copyright © 2016年 lzs. All rights reserved.
//

#import "MiddleViewController.h"
#import "MBGuideHUD+Factory.h"

@interface MiddleViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation MiddleViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBGuideHUD showText:@"爱你苍老的脸上的皱纹" visible:_btn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)dealloc
{
    NSLog(@"%@", @"MiddleViewController 死了");
}

#pragma mark - 事件处理

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
