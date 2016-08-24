//
//  ViewController.m
//  MBGuideHUD
//
//  Created by 罗壮燊 on 16/8/22.
//  Copyright © 2016年 lzs. All rights reserved.
//

#import "ViewController.h"
#import "MBGuideHUD.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate,MBGuideHUDDeledate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *middle1;
@property (weak, nonatomic) IBOutlet UIImageView *middle2;
@property (weak, nonatomic) IBOutlet UIImageView *middle3;
@property (weak, nonatomic) IBOutlet UISearchBar *search;


@property (nonatomic, strong) MBGuideHUD *hud;

@property (nonatomic, strong) NSArray *views;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.views = @[_topImageView,_middle1,_middle2,_middle3,_search];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    MBGuideHUD *hud = [MBGuideHUD showHUDAddedTo:self.tabBarController.view visibleView:self.middle2 animated:NO];
    hud.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    hud.margin = 0;
    hud.delegate = self;
    hud.style = MBGuideHUDBackgroundStyleSolidColor;
    
    self.hud = hud;
    self.hud.alpha = 1;
    self.hud.userInteractionEnabled = YES;
}
#pragma makr - MBGuideHUDDeledate
static int i = -1;
- (void)guideHUDTouchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    i++;
    
    if (i >= self.views.count) {
        [self.hud hide:NO];
        return;
    }
    if (i == 0) { //top
        self.hud.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    } else if (i == 1) {
        self.hud.edgeInsets = UIEdgeInsetsZero;
    } else if (i == 2) {
        self.hud.style = MBGuideHUDBackgroundStyleBlur;
        self.hud.blurStyle = MBGuideHUDBlurStyleDark;
        self.hud.blurColor = [UIColor colorWithWhite:0 alpha:0.8];
    } else if (i == 3) {
        self.hud.alpha = 0.8;
    } else {
        self.hud.style = MBGuideHUDBackgroundStyleSolidColor;
    }
    self.hud.visibleView = self.views[i];
}
#pragma makr - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MBGuideHUDCell"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView *icon = [cell viewWithTag:1001];
    UILabel *des = [cell viewWithTag:1002];
    UIButton *star = [cell viewWithTag:1003];
    [self.tabBarController.view addSubview:self.hud];
    self.hud.style = MBGuideHUDBackgroundStyleBlur;
    if (indexPath.row == 3) {
        self.hud.visibleView = icon;
        return;
    }
    if (indexPath.row == 8) {
        self.hud.visibleView = icon;
        return;
    }
    self.hud.style = MBGuideHUDBackgroundStyleSolidColor;
    if (indexPath.row % 2 == 1) {
        self.hud.cornerRadius = 0;
        self.hud.visibleView = des;
    } else {
        self.hud.visibleView = star;
    }
    
    
    
}
@end
