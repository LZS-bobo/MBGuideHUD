//
//  SDGuideHUD.m
//  SDGuideView
//
//  Created by lzs on 16/8/19.
//  Copyright © 2016年 lzs. All rights reserved.
//

#import "MBGuideHUD.h"
#import "UIView+Frame.h"

@interface MBGuideHUD ()
{
    BOOL _hidenAnimation;
}

///背景图片
@property (nonatomic, strong) UIImage *backgroundImage;
///背景（毛玻璃的时候才存在）
@property (nonatomic, strong) UIView *backgroundView;
///显示的区域
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
///高亮区域
@property (nonatomic, strong) UIBezierPath *lightPath;

@end

@implementation MBGuideHUD

#pragma mark - Class methods
+ (instancetype)showHUDAddedTo:(UIView *)view visibleView:(UIView *)visibleView animated:(BOOL)animated
{
    MBGuideHUD *hud = [[self alloc] initWithView:view];
    hud.visibleView = visibleView;
    [view addSubview:hud];
    [hud show:animated];
    return hud;
}

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //初始化操作
        self.backgroundColor = [UIColor clearColor];
        self.margin = 10;
        self.cornerRadius = 10;
        self.lineWidth = 5;
        self.lineColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithView:(UIView *)view
{
    
    return [self initWithFrame:view.bounds];
}

#pragma mark - Show & hide
- (void)show:(BOOL)animated
{
    if (animated) {
        CGAffineTransform small = CGAffineTransformMakeScale(0.2f, 0.2f);
        self.transform = small;
        [UIView animateWithDuration:0.3 delay:0.f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.transform = CGAffineTransformIdentity;
        }];
    }
}

- (void)hide:(BOOL)animated
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hide:) object:nil];
    if (animated || _hidenAnimation) {
        CGAffineTransform small = CGAffineTransformMakeScale(0.01f, 0.01f);
        [UIView animateWithDuration:0.25 delay:0.f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.transform = small;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    } else {
        [self removeFromSuperview];
    }
}

- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay
{
    _hidenAnimation = animated;
    [self performSelector:@selector(hide:) withObject:nil afterDelay:delay];
}

#pragma mark - UI
- (void)setupUI
{
    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0) {
        _style = MBGuideHUDBackgroundStyleBlur;
    } else {
        _style = MBGuideHUDBackgroundStyleSolidColor;
    }
    [self updateForBackgroundStyle];
    [self prepare];
}

- (void)prepare
{
    //自定义操作
}

- (void)updateForBackgroundStyle {
    
    MBGuideHUDBackgroundStyle style = self.style;
    self.backgroundColor = [UIColor clearColor];
    if (style == MBGuideHUDBackgroundStyleBlur) {
        [self.backgroundView removeFromSuperview];
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
            
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            [self addSubview:effectView];
            effectView.frame = self.bounds;
            effectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            self.backgroundView = effectView;
            
            
        } else {

            UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
            toolbar.barStyle = UIBarStyleDefault;
            toolbar.translucent = YES;
            toolbar.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [self addSubview:toolbar];
            self.backgroundView = toolbar;
        }
        

    } else {

        [self.backgroundView removeFromSuperview];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(guideHUDTouchesBegan:withEvent:)]) { //告诉代理
        [self.delegate guideHUDTouchesBegan:touches withEvent:event];
    }
    
    if (self.clickBlock) { //执行block
        self.clickBlock();
    }
}
#pragma mark - Properties
- (void)setVisibleView:(UIView *)visibleView
{
    _visibleView = visibleView;
    [self setNeedsDisplay];
}

- (void)setStyle:(MBGuideHUDBackgroundStyle)style
{
    _style = style;
    [self updateForBackgroundStyle];
    [self setNeedsLayout];
}

- (void)setAlpha:(CGFloat)alpha
{
    _alpha = alpha;
    self.backgroundView.alpha = alpha;
}

- (void)setOval:(BOOL)oval
{
    _oval = oval;
    [self setNeedsDisplay];
}

- (void)setMargin:(CGFloat)margin
{
    _margin = margin;
    [self setNeedsDisplay];
}
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    [self setNeedsDisplay];
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}
- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}
- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)setBlurStyle:(MBGuideHUDBlurStyle)blurStyle
{
    _blurStyle = blurStyle;
    if (blurStyle == MBGuideHUDBlurStyleLight) {
        if (![self.backgroundView isKindOfClass:[UIToolbar class]]) {
            UIVisualEffectView *effectView = (UIVisualEffectView *)self.backgroundView;
            effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        } else {
            UIToolbar *boolbar = (UIToolbar *)self.backgroundView;
            boolbar.barStyle = UIBarStyleDefault;
        }
    } else {
        if (![self.backgroundView isKindOfClass:[UIToolbar class]]) {
            UIVisualEffectView *effectView = (UIVisualEffectView *)self.backgroundView;
            effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        } else {
            UIToolbar *boolbar = (UIToolbar *)self.backgroundView;
            boolbar.barStyle = UIBarStyleBlack;
        }
    }
}

- (void)setBlurColor:(UIColor *)blurColor
{
    _blurColor = blurColor;
    if (self.blurColor) { //自定义毛玻璃样式
        UIView *view = nil;
        if (![self.backgroundView isKindOfClass:[UIToolbar class]]) {
            view = [self.backgroundView viewWithString:@"_UIVisualEffectFilterView"];
            if (view) {
                view.backgroundColor = self.blurColor;
            }
        }
    }
}


#pragma mark - Lazy
- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
    }
    return _shapeLayer;
}



#pragma mark - DrawRect
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    //透明区域
    CGRect visibleRect = CGRectZero;
    CGRect visibleFrame = self.visibleView.frame;
    //坐标系转换
    CGRect frame = [_visibleView.superview convertRect:visibleFrame toView:self];
    
    if (self.style == MBGuideHUDBackgroundStyleBlur) {
        
        visibleRect = CGRectMake(frame.origin.x + self.edgeInsets.left - self.margin - self.lineWidth, frame.origin.y + self.edgeInsets.top - self.margin - self.lineWidth, frame.size.width - 2 * self.edgeInsets.right + 2 * self.margin + 2 * self.lineWidth, frame.size.height - 2 * self.edgeInsets.bottom + 2 * self.margin + 2 * self.lineWidth);
        
    } else {
        
        visibleRect = CGRectMake(frame.origin.x + self.edgeInsets.left - self.margin, frame.origin.y + self.edgeInsets.top - self.margin, frame.size.width - 2 * self.edgeInsets.right + 2 * self.margin , frame.size.height - 2 * self.edgeInsets.bottom + 2 * self.margin);
    }
    
    UIBezierPath *clearPath = nil;
    if (self.isOval) { //椭圆
        self.lightPath = [UIBezierPath bezierPathWithOvalInRect:visibleRect];
        //取反
        clearPath = [self.lightPath bezierPathByReversingPath];
    } else { //矩形
        self.lightPath = [UIBezierPath bezierPathWithRoundedRect:visibleRect cornerRadius:self.cornerRadius];
        //取反
        clearPath = [self.lightPath bezierPathByReversingPath];
    }
    [path appendPath:clearPath];
    self.lightPath.lineJoinStyle = kCGLineJoinRound;
    self.lightPath.lineCapStyle = kCGLineCapRound;
    self.lightPath.lineWidth = self.lineWidth * 2;
    [self.lineColor set];
    [self.lightPath stroke];
    
    //解决：根据不同情况计算出不同的  visibleRect

    if (self.style == MBGuideHUDBackgroundStyleBlur) {
        self.backgroundView.layer.mask = self.shapeLayer;
    } else {
        self.layer.mask = self.shapeLayer;
    }
    self.shapeLayer.path = path.CGPath;
    
    
}

@end
