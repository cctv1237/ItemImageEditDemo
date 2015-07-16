//
//  ImageEditPanel.h
//  ItemImageEditDemo
//
//  Created by LF on 15/7/15.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DemoItem;

@interface ImageEditPanel : UIView

- (void)showAtItem:(DemoItem *)item inView:(UIView *)view;
- (void)hide;

@end
