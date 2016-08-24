//
//  MBGuideHUD+Factory.m
//  MBGuideHUD
//
//  Created by 罗壮燊 on 16/8/24.
//  Copyright © 2016年 lzs. All rights reserved.
//

#import "MBGuideHUD+Factory.h"
#import "MBGuideView.h"

#define BOTTOM_MARGIN 15
#define LEFT_MARGIN 5
#define HEIGHT 5
#define LINE_HEIGHT 20
#define LINE_WIDTH 2
#define GUIDEVIEW_LEFT_MARGIN 20


@implementation MBGuideHUD (Factory)

+ (instancetype)showText:(NSString *)text view:(UIView *)view visible:(UIView *)visible
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBGuideHUD *hud = [self showHUDAddedTo:view visibleView:visible animated:NO];
    hud.style = MBGuideHUDBackgroundStyleBlur;
    hud.lineWidth = 5;
    hud.margin = 0;
    hud.edgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    hud.cornerRadius = visible.frame.size.width / 2.0;
    hud.alpha = 0.9;
    
    hud.blurColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(hud.lightFrame.origin.x - LEFT_MARGIN, hud.lightFrame.origin.y+ hud.lightFrame.size.height + BOTTOM_MARGIN - HEIGHT)];
    [path addLineToPoint:CGPointMake(hud.lightFrame.origin.x , hud.lightFrame.origin.y+ hud.lightFrame.size.height + BOTTOM_MARGIN)];
    [path addLineToPoint:CGPointMake(hud.lightFrame.origin.x + hud.lightFrame.size.width, hud.lightFrame.origin.y+ hud.lightFrame.size.height + BOTTOM_MARGIN)];
    [path addLineToPoint:CGPointMake(hud.lightFrame.origin.x + hud.lightFrame.size.width + LEFT_MARGIN, hud.lightFrame.origin.y + hud.lightFrame.size.height + BOTTOM_MARGIN - HEIGHT)];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(visible.center.x, hud.lightFrame.origin.y+ hud.lightFrame.size.height + BOTTOM_MARGIN)];
    [path2 addLineToPoint:CGPointMake(visible.center.x, hud.lightFrame.origin.y+ hud.lightFrame.size.height + BOTTOM_MARGIN + GUIDEVIEW_LEFT_MARGIN)];
    
    [path appendPath:path2];
    
    layer.lineWidth = LINE_WIDTH;
    layer.lineCap = @"round";
    layer.lineJoin = @"round";
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    
    [hud.layer addSublayer:layer];
    layer.path = path.CGPath;
    
    MBGuideView *guideview = [MBGuideView viewFromXib];
    guideview.frame = CGRectMake(GUIDEVIEW_LEFT_MARGIN, hud.lightFrame.origin.y+ hud.lightFrame.size.height + BOTTOM_MARGIN + LINE_HEIGHT, hud.frame.size.width - 2 * GUIDEVIEW_LEFT_MARGIN, 0);
     __weak typeof(hud) weakHud = hud;
    [guideview setText:text];
    guideview.confirmBlock = ^{
        [weakHud hide:YES];
    };
    [hud addSubview:guideview];
    
    return hud;
}
+ (instancetype)showText:(NSString *)text visible:(UIView *)visible
{
    return [self showText:text view:nil visible:visible];
}


@end
