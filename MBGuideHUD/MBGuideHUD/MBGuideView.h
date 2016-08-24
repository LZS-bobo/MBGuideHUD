//
//  MBGuideView.h
//  MBGuideHUD
//
//  Created by 罗壮燊 on 16/8/24.
//  Copyright © 2016年 lzs. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MBGuideView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (nonatomic, copy) void(^confirmBlock)();

+ (instancetype)viewFromXib;
- (void)setText:(NSString *)text;

@end
