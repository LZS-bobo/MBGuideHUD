//
//  MBGuideView.m
//  MBGuideHUD
//
//  Created by 罗壮燊 on 16/8/24.
//  Copyright © 2016年 lzs. All rights reserved.
//

#import "MBGuideView.h"
#import "UIView+Frame.h"

@implementation MBGuideView


+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:@"MBGuideView" owner:nil options:nil].firstObject;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self lzs_sizeToFit];
    
}
- (void)lzs_sizeToFit
{
    CGRect rect = [self.title.text boundingRectWithSize:CGSizeMake(self.lzs_width, MAXFLOAT) options:NSStringDrawingUsesDeviceMetrics attributes:nil context:nil];
    CGFloat height = rect.size.height + 16;
    self.lzs_height = height > 60 ? height : 60;
}

- (void)setText:(NSString *)text
{
    self.title.text = text;
    [self layoutSubviews];
}
- (IBAction)confirm:(id)sender {
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}


- (void)dealloc
{
    NSLog(@"MBGuideView.h 释放了");
}

@end
