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

#define MAX_EDIT_IMAGE_SCALE 3

@interface ImageEditPanel () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *editArea;
@property (nonatomic, strong) EditWindow *editWindow;
@property (nonatomic, strong) UIImageView *editImageView;
@property (nonatomic, strong) DemoItem *targetItem;
@property (nonatomic, strong) BackgroundShade *backgroundShade;

@property (nonatomic, assign) CGFloat imageViewWHRatio;
@property (nonatomic, assign) CGFloat imageWHRatio;

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
    [self buildEditImageView];
    self.editImageView = [self resetEditImageView:self.editImageView];
    [self setZoomScaleForEditArea];
    
    

}

- (void)hide {
    [self.targetItem replaceImageViewWithImageView:self.editImageView contentOffset:self.editArea.contentOffset];
    [self removeFromSuperview];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%f,%f",self.editArea.contentOffset.x,self.editArea.contentOffset.y);
//    NSLog(@"%f,%f",self.editArea.contentSize.width,self.editArea.contentSize.height);
    NSLog(@"%f,%f",self.editImageView.frame.size.width,self.editImageView.frame.size.height);
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.editImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    self.editImageView = [self resetEditImageView:self.editImageView];
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

- (UIImageView *)resetEditImageView:(UIImageView *)imageView {
    
    CGFloat imageViewWidth = imageView.frame.size.width;
    CGFloat imageViewHeight = imageView.frame.size.height;
    CGFloat imageWidth = imageView.image.size.width;
    CGFloat imageHeight = imageView.image.size.height;
    
    CGFloat imageViewWHRatio = imageViewWidth / imageViewHeight;
    CGFloat imageWHRatio = imageWidth / imageHeight;
    
    self.imageViewWHRatio = imageViewWHRatio;
    self.imageWHRatio = imageWHRatio;
    
    CGFloat deltaWidth = 0;
    CGFloat deltaHeight = 0;
    
    CGSize contentSize;
    
    if (imageViewWHRatio < imageWHRatio) {
        deltaWidth = (imageViewHeight * imageWHRatio - imageViewWidth) / 2;
//        imageView.bounds = CGRectMake(0,
//                                      0,
//                                      imageView.bounds.size.height * imageWHRatio,
//                                      imageView.bounds.size.height);
        contentSize = CGSizeMake(imageViewHeight * imageWHRatio, imageViewHeight);
    }
    else if (imageViewWHRatio > imageWHRatio) {
        deltaHeight = (imageViewWidth / imageWHRatio - imageViewHeight) / 2;
//        imageView.bounds = CGRectMake(0,
//                                      0,
//                                      imageView.bounds.size.width,
//                                      imageView.bounds.size.width / imageWHRatio);
        contentSize = CGSizeMake(imageViewWidth, imageViewWidth / imageWHRatio);
    }
    else {
        
    }
    
    self.editArea.contentSize = contentSize;
    
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

- (void)buildEditImageView {
    [self.editArea setContentOffset:CGPointMake(-self.editImageView.frame.origin.x, -self.editImageView.frame.origin.y)];
    [self.editImageView setFrame:self.editImageView.bounds];
    [self.editImageView setImage:self.targetItem.imageView.image];
    self.editImageView.contentMode = UIViewContentModeScaleAspectFill;
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
        _editArea.bounces = NO;
        _editArea.clipsToBounds = NO;
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
