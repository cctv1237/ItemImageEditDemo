//
//  ImageEditPanel.m
//  ItemImageEditDemo
//
//  Created by LF on 15/7/15.
//  Copyright (c) 2015年 Fan. All rights reserved.
//

#import "LFImageClipEditPanel.h"
#import "DemoItem.h"
#import "LFImageClipBackgroundShade.h"
#import "LFImageClipEditWindow.h"
#import "UIView+LayoutMethods.h"

#define MAX_EDIT_IMAGE_SCALE 3

@interface LFImageClipEditPanel () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *editArea;
@property (nonatomic, strong) UIImageView *editImageView;
@property (nonatomic, strong) LFImageClipEditWindow *editWindow;
@property (nonatomic, strong) LFImageClipBackgroundShade *backgroundShade;
@property (nonatomic, strong) DemoItem *targetItem;

@property (nonatomic, assign) CGFloat imageViewWHRatio;
@property (nonatomic, assign) CGFloat imageWHRatio;
@property (nonatomic, assign) CGPoint contentOffSetPoint;

@end

@implementation LFImageClipEditPanel

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

#pragma mark - public methods

- (void)showAtItem:(DemoItem *)item inView:(UIView *)view {
    
    self.targetItem = item;
    [view addSubview:self];
    [self fill];
    [self setFramesOfWidgets];
    [self setContentOffSetPoint];
    [self setFrameOfEditImageView];
    [self resetEditAreaContentSizeByImageView:self.editImageView withContentOffSetPoint:self.contentOffSetPoint];
    [self setZoomScaleForEditArea];
    [self.targetItem.imageView removeFromSuperview];
    
}

- (void)hide {
    
    [self.targetItem replaceImageViewWithImageView:self.editImageView contentOffset:self.editArea.contentOffset];
    [self removeFromSuperview];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%f,%f",self.editArea.contentOffset.x,self.editArea.contentOffset.y);
//    NSLog(@"%f,%f",self.editArea.contentSize.width,self.editArea.contentSize.height);
//    NSLog(@"%f,%f",self.editImageView.frame.size.width,self.editImageView.frame.size.height);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.editImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    [self resetEditAreaContentSizeByImageView:self.editImageView];
}

#pragma mark - private methods

- (void)setFramesOfWidgets {
    
    [self.backgroundShade fill];
    [self.backgroundShade addLayersToBackgroundShadeWithTargetItem:self.targetItem];
    self.editArea.frame = self.targetItem.frame;
    [self.editWindow didDrawWindowBlockWithTargetItem:self.targetItem];
    self.editImageView.frame = self.targetItem.imageView.frame;
}

- (void)setZoomScaleForEditArea {
    
    self.editArea.maximumZoomScale = MAX_EDIT_IMAGE_SCALE * self.targetItem.frame.size.width / self.editImageView.frame.size.width;
    self.editArea.minimumZoomScale = self.targetItem.frame.size.width / self.editImageView.frame.size.width;
}

- (void)resetEditAreaContentSizeByImageView:(UIImageView *)imageView withContentOffSetPoint:(CGPoint)contentOffSetPoint{
    
    [self resetEditAreaContentSizeByImageView:imageView];
    [self.editArea setContentOffset:CGPointMake(self.contentOffSetPoint.x, self.contentOffSetPoint.y)];
}

- (void)resetEditAreaContentSizeByImageView:(UIImageView *)imageView {
    
    CGFloat imageViewWidth = imageView.frame.size.width;
    CGFloat imageViewHeight = imageView.frame.size.height;
    CGFloat imageWidth = imageView.image.size.width;
    CGFloat imageHeight = imageView.image.size.height;
    
    CGFloat imageViewWHRatio = imageViewWidth / imageViewHeight;
    CGFloat imageWHRatio = imageWidth / imageHeight;
    
    if (imageViewWHRatio < imageWHRatio) {
        CGFloat deltaWidth = (imageViewHeight * imageWHRatio - imageViewWidth) / 2;
        self.editArea.contentSize = CGSizeMake(imageViewHeight * imageWHRatio, imageViewHeight);
        self.editArea.contentInset = UIEdgeInsetsMake(0, deltaWidth, 0, -deltaWidth);
    }
    else if (imageViewWHRatio > imageWHRatio) {
        CGFloat deltaHeight = (imageViewWidth / imageWHRatio - imageViewHeight) / 2;
        self.editArea.contentSize = CGSizeMake(imageViewWidth, imageViewWidth / imageWHRatio);
        self.editArea.contentInset = UIEdgeInsetsMake(deltaHeight, 0, -deltaHeight, 0);
    }
    else {
        
    }
    
}

- (void)setContentOffSetPoint {
    
    self.contentOffSetPoint = CGPointMake(-self.editImageView.frame.origin.x, -self.editImageView.frame.origin.y);
}

- (void)setFrameOfEditImageView {
    
    [self.editImageView setFrame:self.editImageView.bounds];
    [self.editImageView setImage:self.targetItem.imageView.image];
    self.editImageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        return nil;
    }
    else {
        return hitView;
    }
}

#pragma mark - getters and setters

- (UIScrollView *)editArea {
    if (_editArea == nil) {
        _editArea = [[UIScrollView alloc] init];
        _editArea.bounces = NO;
        _editArea.clipsToBounds = NO;
        _editArea.delegate = self;
    }
    return _editArea;
}

- (LFImageClipEditWindow *)editWindow {
    if (_editWindow == nil) {
        _editWindow = [[LFImageClipEditWindow alloc] init];
        
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
        _backgroundShade = [[LFImageClipBackgroundShade alloc] init];
        
    }
    return _backgroundShade;
}


@end
