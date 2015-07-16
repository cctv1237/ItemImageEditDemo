//
//  ImageEditPanel.m
//  ItemImageEditDemo
//
//  Created by LF on 15/7/15.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "ImageEditPanel.h"
#import "DemoItem.h"
#import "UIView+LayoutMethods.h"

#define EDIT_PADDING 30

@interface ImageEditPanel () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *editWindow;
@property (nonatomic, strong) UIImageView *editImageView;
@property (nonatomic, strong) DemoItem *targetItem;
@property (nonatomic, strong) UIView *backgroundShade;
@property (nonatomic, strong) UIView *touchResponseView;

@end

@implementation ImageEditPanel

#pragma mark - life cycle

- (instancetype)init {
    if (self = [super init]) {
        self.clipsToBounds = NO;
        
        [self addSubview:self.editImageView];
        [self addSubview:self.editWindow];
        [self addSubview:self.backgroundShade];
        [self addSubview:self.touchResponseView];
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
    self.editImageView.image = [self.targetItem getImageViewToEdit].image;
    
    [view addSubview:self];
    [self addSubViewsToView];
    [self addGestureRecognizerToView];
    
    
    
}

- (void)hide {
    [self.targetItem setImageByEditedImageView:self.editImageView];
    [self removeFromSuperview];
}

#pragma mark - event response

- (void)panView:(UIPanGestureRecognizer *)sender {
    
        CGPoint point = [sender translationInView:sender.view];
        
        CGPoint temp = self.touchResponseView.center;
        temp.x += point.x;
        temp.y += point.y;
        
        if (self.touchResponseView.frame.origin.x == self.targetItem.frame.origin.x) {
//            self.touchResponseView.frame = CGRectMake(self.targetItem.frame.origin.x,
//                                                      self.touchResponseView.frame.origin.y,
//                                                      self.touchResponseView.frame.size.width,
//                                                      self.touchResponseView.frame.size.height);
            self.touchResponseView.center = temp;
        }
        else {
            self.touchResponseView.center = temp;
        }
    
        [sender setTranslation:CGPointZero inView:sender.view];
}

- (void)pinchView:(UIPinchGestureRecognizer *)sender {
    self.touchResponseView.transform = CGAffineTransformScale(self.touchResponseView.transform, sender.scale, sender.scale);
    sender.scale = 1.0;
}

#pragma mark - Delegate
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
                                
    return scaledImage;
}

#pragma mark - private

- (void)addSubViewsToView {
    [self fill];
    [self.backgroundShade fill];
    [self addLayersToBackgroundShade];
    self.editWindow.frame = self.targetItem.frame;
    self.editImageView.frame = self.targetItem.frame;
    self.touchResponseView.frame = CGRectMake(self.targetItem.frame.origin.x - EDIT_PADDING,
                                              self.targetItem.frame.origin.y - EDIT_PADDING,
                                              self.targetItem.frame.size.width + 2.f*EDIT_PADDING,
                                              self.targetItem.frame.size.height + 2.f*EDIT_PADDING);
}

- (void)addLayersToBackgroundShade {
    CALayer *topLayer = [CALayer layer];
    CALayer *bottomLayer = [CALayer layer];
    CALayer *leftLayer = [CALayer layer];
    CALayer *rightLayer = [CALayer layer];
    
    topLayer.backgroundColor = [UIColor whiteColor].CGColor;
    bottomLayer.backgroundColor = [UIColor whiteColor].CGColor;
    leftLayer.backgroundColor = [UIColor whiteColor].CGColor;
    rightLayer.backgroundColor = [UIColor whiteColor].CGColor;
    
    topLayer.frame = CGRectMake(self.backgroundShade.origin.x,
                                self.backgroundShade.origin.y,
                                self.backgroundShade.size.width,
                                self.targetItem.frame.origin.y);
    
    bottomLayer.frame = CGRectMake(self.backgroundShade.origin.x,
                                   self.targetItem.frame.origin.y + self.targetItem.frame.size.height,
                                   self.backgroundShade.size.width,
                                   self.backgroundShade.size.height -
                                   (self.targetItem.frame.origin.y + self.targetItem.frame.size.height));
    
    leftLayer.frame = CGRectMake(self.backgroundShade.origin.x,
                                 self.targetItem.origin.y,
                                 self.targetItem.origin.x,
                                 self.targetItem.frame.size.height);
    
    rightLayer.frame = CGRectMake(self.targetItem.origin.x + self.targetItem.size.width,
                                  self.targetItem.origin.y,
                                  self.backgroundShade.size.width -
                                  (self.targetItem.origin.x + self.targetItem.size.width),
                                  self.targetItem.frame.size.height);
    
    [self.backgroundShade.layer addSublayer:topLayer];
    [self.backgroundShade.layer addSublayer:bottomLayer];
    [self.backgroundShade.layer addSublayer:leftLayer];
    [self.backgroundShade.layer addSublayer:rightLayer];
}

- (void)addGestureRecognizerToView {
    UIPanGestureRecognizer  *pan = [[UIPanGestureRecognizer alloc] init];
    [self.touchResponseView addGestureRecognizer:pan];
    [pan addTarget:self action:@selector(panView:)];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] init];
    pinch.delegate = self;
    [self.touchResponseView addGestureRecognizer:pinch];
    [pinch addTarget:self action:@selector(pinchView:)];
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

- (UIImageView *)editWindow {
    if (_editWindow == nil) {
        _editWindow = [[UIImageView alloc] init];
        _editWindow.layer.borderWidth = 2.f;
        _editWindow.layer.borderColor = [[UIColor cyanColor] CGColor];
        _editWindow.image = [UIImage imageNamed:@"icon_direction-sign_80"];
        _editWindow.contentMode = UIViewContentModeCenter;
    }
    return _editWindow;
}

- (UIImageView *)editImageView {
    if (_editImageView == nil) {
        _editImageView = [[UIImageView alloc] init];
        _editImageView.clipsToBounds = NO;
        _editImageView.contentMode = UIViewContentModeScaleAspectFill;
//        _editImageView.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
    }
    return _editImageView;
}

- (UIView *)backgroundShade {
    if (_backgroundShade == nil) {
        _backgroundShade = [[UIView alloc] init];
        _backgroundShade.alpha = 0.5f;
    }
    return _backgroundShade;
}

- (UIView *)touchResponseView {
    if (_touchResponseView == nil) {
        _touchResponseView = [[UIView alloc] init];
        _touchResponseView.backgroundColor = [UIColor purpleColor];
        _touchResponseView.alpha = 0.3f;
    }
    return _touchResponseView;
}


@end
