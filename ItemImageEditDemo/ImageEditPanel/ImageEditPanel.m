//
//  ImageEditPanel.m
//  ItemImageEditDemo
//
//  Created by LF on 15/7/15.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "ImageEditPanel.h"
#import "DemoItem.h"
#import "BackgroundShade.h"
#import "EditWindow.h"
#import "UIView+LayoutMethods.h"

@interface ImageEditPanel () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *editArea;
@property (nonatomic, strong) EditWindow *editWindow;
@property (nonatomic, strong) UIImageView *editImageView;
@property (nonatomic, strong) DemoItem *targetItem;
@property (nonatomic, strong) BackgroundShade *backgroundShade;

@end

@implementation ImageEditPanel

#pragma mark - life cycle

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.editArea];
        [self addSubview:self.editWindow];
        [self.editArea addSubview:self.editImageView];
        [self addSubview:self.backgroundShade];
    }
    return self;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - public methods

- (void)showAtItem:(DemoItem *)item inView:(UIView *)view {
    
    self.targetItem = item;
    
    [view addSubview:self];
    [self fill];
    [self setFramesOfWidgets];
    
    self.editImageView = [self resetBoundsforEditImageView:self.editImageView withImage:self.targetItem.imageView.image];
    
    

}

- (void)hide {
    [self.targetItem replaceImageViewWithImageView:self.editImageView];
    [self removeFromSuperview];
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.editImageView;
}

#pragma mark - private methods

- (void)setFramesOfWidgets {
    [self.backgroundShade fill];
    [self.backgroundShade addLayersToBackgroundShadeWithTargetItem:self.targetItem];
    self.editArea.frame = self.targetItem.frame;
    self.editWindow.center = self.targetItem.center;
    self.editImageView.frame = self.targetItem.imageView.frame;
}

- (UIImageView *)resetBoundsforEditImageView:(UIImageView *)imageView withImage:(UIImage *)image {
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    CGFloat imageViewWidth = imageView.bounds.size.width;
    CGFloat imageViewHeight = imageView.bounds.size.height;
    CGFloat imageWidth = imageView.image.size.width;
    CGFloat imageHeight = imageView.image.size.height;
    
    CGFloat imageViewWHRatio = imageViewWidth / imageViewHeight;
    CGFloat imageWHRatio = imageWidth / imageHeight;
    
    CGFloat deltaWidth = 0;
    CGFloat deltaHeight = 0;
    
    if (imageViewWHRatio < imageWHRatio) {
        deltaWidth = (imageView.bounds.size.height * imageWHRatio - imageView.bounds.size.width) / 2;
        imageView.bounds = CGRectMake(0,
                                      0,
                                      imageView.bounds.size.height * imageWHRatio,
                                      imageView.bounds.size.height);
    }
    else if (imageViewWHRatio > imageWHRatio) {
        deltaHeight = (imageView.bounds.size.width / imageWHRatio - imageView.bounds.size.height) / 2;
        imageView.bounds = CGRectMake(0,
                                      0,
                                      imageView.bounds.size.width,
                                      imageView.bounds.size.width / imageWHRatio);
    }
    else {
        
    }
    
    self.editArea.contentSize = imageView.frame.size;
    
    if (imageViewWHRatio < imageWHRatio) {
        self.editArea.contentInset = UIEdgeInsetsMake(0, deltaWidth, 0, -deltaWidth);
    }
    else if (imageViewWHRatio > imageWHRatio) {
        self.editArea.contentInset = UIEdgeInsetsMake(deltaHeight, 0, -deltaHeight, 0);
    }
    else {
        
    }
    
    return imageView;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self)
    {
        return nil;
    }
    else
    {
        return hitView;
    }
}

#pragma mark - getters and setters

- (UIScrollView *)editArea {
    if (_editArea == nil) {
        _editArea = [[UIScrollView alloc] init];
        _editArea.scrollEnabled = YES;
        _editArea.layer.borderWidth = 2.f;
        _editArea.layer.borderColor = [[UIColor cyanColor] CGColor];
        _editArea.bounces = NO;
        _editArea.clipsToBounds = NO;
        _editArea.maximumZoomScale = 3.f;
        _editArea.minimumZoomScale = 1.f;
        _editArea.delegate = self;
    }
    return _editArea;
}

- (EditWindow *)editWindow {
    if (_editWindow == nil) {
        _editWindow = [[EditWindow alloc] init];
        
    }
    return _editWindow;
}

- (UIImageView *)editImageView {
    if (_editImageView == nil) {
        _editImageView = [[UIImageView alloc] init];
        
    }
    return _editImageView;
}

- (UIView *)backgroundShade {
    if (_backgroundShade == nil) {
        _backgroundShade = [[BackgroundShade alloc] init];
        
    }
    return _backgroundShade;
}


@end
