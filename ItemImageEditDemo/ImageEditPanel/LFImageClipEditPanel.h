//
//  ImageEditPanel.h
//  ItemImageEditDemo
//
//  Created by LF on 15/7/15.
//  Copyright (c) 2015年 Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DemoItem;

@interface LFImageClipEditPanel : UIView

- (void)showAtItem:(DemoItem *)item inView:(UIView *)view;
- (void)hide;

@end
