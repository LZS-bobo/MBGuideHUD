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
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;


@property (nonatomic, strong) NSArray *views;
@property (nonatomic, strong) NSArray *texts;

@end

@implementation MiddleViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.views = @[_btn, _btn1, _btn2, _btn3];
    self.texts = @[@"深情吻住了你的嘴",@"却无能停止你的流泪",@"只因和我的心和你一起碎",@"大雨下疯了的长夜"];
    
    [MBGuideHUD showText:@"Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints" visible:_btn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
static int i = -1;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    i++;
    
    if (i >= self.views.count) {
        i = -1;
        return;
    }
    [MBGuideHUD showText:self.texts[i] visible:self.views[i]];
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
