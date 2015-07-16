//
//  DemoItem.h
//  ItemImageEditDemo
//
//  Created by LF on 15/7/15.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoItem : UIView

@property (nonatomic, strong) UIImageView *imageView;

- (void)replaceImageViewWithImageView:(UIImageView *)imageView;

@end
