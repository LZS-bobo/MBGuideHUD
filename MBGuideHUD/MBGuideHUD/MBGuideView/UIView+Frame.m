//
//  UIView+Frame.m
//  SDGuideView
//
//  Created by lzs on 16/8/19.
//  Copyright © 2016年 lzs. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setLzs_centerX:(CGFloat)lzs_centerX
{
    CGPoint point = self.center;
    point.x = lzs_centerX;
    self.center = point;
}

- (CGFloat)lzs_centerX
{
    return self.center.x;
}

- (void)setLzs_centerY:(CGFloat)lzs_centerY
{
    CGPoint point = self.center;
    point.y = lzs_centerY;
    self.center = point;
}

- (CGFloat)lzs_centerY
{
    return self.center.y;
}

- (void)setLzs_width:(CGFloat)lzs_width{
    CGRect frame = self.frame;
    frame.size.width = lzs_width;
    self.frame = frame;
}

- (CGFloat)lzs_width
{
    return self.frame.size.width;
}

- (void)setLzs_height:(CGFloat)lzs_height
{
    CGRect frame = self.frame;
    frame.size.height = lzs_height;
    self.frame = frame;
}
- (CGFloat)lzs_height
{
     return self.frame.size.height;
}

- (void)setLzs_x:(CGFloat)lzs_x
{
    CGRect frame = self.frame;
    frame.origin.x = lzs_x;
    self.frame = frame;
}

- (CGFloat)lzs_x
{
    return self.frame.origin.x;
}

- (void)setLzs_y:(CGFloat)lzs_y
{
    CGRect frame = self.frame;
    frame.origin.y = lzs_y;
    self.frame = frame;
}

- (CGFloat)lzs_y
{
    return self.frame.origin.y;
}

- (void)setLzs_origin:(CGPoint)lzs_origin
{
    CGRect frame = self.frame;
    frame.origin = lzs_origin;
    self.frame = frame;
}

- (CGPoint)lzs_origin
{
    return self.frame.origin;
}

- (void)setLzs_size:(CGSize)lzs_size
{
    CGRect frame = self.frame;
    frame.size = lzs_size;
    self.frame = frame;
}

- (CGSize)lzs_size
{
    return self.frame.size;
}

// 从view上截图
- (UIImage *)lzs_image {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.lzs_width, self.lzs_height), NO, 1.0);  //NO，YES 控制是否透明
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 生成后的image
    
    return image;
}

- (UIView *)viewWithString:(NSString *)string
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(string)]) {
            return view;
        }
        [view viewWithString:string];
    }
    return nil;
}



@end
