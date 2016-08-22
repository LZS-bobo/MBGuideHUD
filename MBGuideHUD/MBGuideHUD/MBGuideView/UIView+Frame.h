//
//  UIView+Frame.m
//  SDGuideView
//
//  Created by lzs on 16/8/19.
//  Copyright © 2016年 lzs. All rights reserved.
//

#import <UIKit/UIKit.h>

// @property只会生成get,set方法声明,不会生成实现和下划线成员属性
// 开发规范:自己的分类,尽量添加项目前缀
@interface UIView (Frame)

@property CGFloat lzs_width;
@property CGFloat lzs_height;
@property CGFloat lzs_x;
@property CGFloat lzs_y;
@property CGFloat lzs_centerX;
@property CGFloat lzs_centerY;
@property CGSize lzs_size;
@property CGPoint lzs_origin;
@property(readonly) UIImage *lzs_image;

- (UIView *)viewWithString:(NSString *)string;

@end
