//
//  SDGuideHUD.h
//  SDGuideView
//
//  Created by lzs on 16/8/19.
//  Copyright © 2016年 lzs. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, MBGuideHUDBackgroundStyle) {
    /// 纯色背景
    MBGuideHUDBackgroundStyleSolidColor,
    /// 毛玻璃背景
    MBGuideHUDBackgroundStyleBlur
};
typedef NS_ENUM(NSInteger, MBGuideHUDBlurStyle) {
    /// 白色
    MBGuideHUDBlurStyleLight,
    /// 黑色
    MBGuideHUDBlurStyleDark
};

typedef void (^MBGuideHUDClickBlock)();

@protocol MBGuideHUDDeledate <NSObject>

@optional
- (void)guideHUDTouchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end

@interface MBGuideHUD : UIView

///需要高亮的控件
@property (nonatomic, weak) UIView *visibleView;
///高亮区域的偏移量
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
///高亮区域相对于原控件大多少（默认5）
@property (nonatomic, assign) CGFloat margin;
///高亮区域是否是椭圆 （默认为 圆角为10 的矩形）
@property (nonatomic, assign, getter=isOval) BOOL oval;
///背景样式
@property (nonatomic, assign) MBGuideHUDBackgroundStyle style;
///代理
@property (nonatomic, weak) id<MBGuideHUDDeledate> delegate;
///点击的操作
@property (nonatomic, copy) MBGuideHUDClickBlock clickBlock;
///圆角 (默认10)
@property (nonatomic, assign) CGFloat cornerRadius;
///线宽 (默认 5)
@property (nonatomic, assign) CGFloat lineWidth;
///线的颜色（白色）
@property (nonatomic, strong) UIColor *lineColor;
///毛玻璃样式
@property (nonatomic, assign) MBGuideHUDBlurStyle blurStyle;
///自定义毛玻璃颜色，使用blurColor,blurStyle失效(ios 8+)
@property (nonatomic, strong) UIColor *blurColor;
///透明度
@property (nonatomic, assign) CGFloat alpha;
///高亮区域的frame
@property (nonatomic, assign, readonly) CGRect lightFrame;
//自定义UI
- (void)prepare;
+ (instancetype)showHUDAddedTo:(UIView *)view visibleView:(UIView *)visibleView animated:(BOOL)animated;
- (instancetype)initWithView:(UIView *)view;
- (void)hide:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end
