//
//  BackgroundShade.m
//  ItemImageEditDemo
//
//  Created by LF on 15/7/16.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "BackgroundShade.h"

@implementation BackgroundShade

#pragma mark - life cycle

- (instancetype)init {
    if (self = [super init]) {
        self.alpha = 0.5;
    }
    return self;

}

#pragma mark - public methods

- (void)addLayersToBackgroundShadeWithTargetItem:(UIView *)targetItem {
    CALayer *topLayer = [CALayer layer];
    CALayer *bottomLayer = [CALayer layer];
    CALayer *leftLayer = [CALayer layer];
    CALayer *rightLayer = [CALayer layer];
    
    topLayer.backgroundColor = [UIColor whiteColor].CGColor;
    bottomLayer.backgroundColor = [UIColor whiteColor].CGColor;
    leftLayer.backgroundColor = [UIColor whiteColor].CGColor;
    rightLayer.backgroundColor = [UIColor whiteColor].CGColor;
    
    topLayer.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                self.frame.size.width,
                                targetItem.frame.origin.y);
    
    bottomLayer.frame = CGRectMake(self.frame.origin.x,
                                   targetItem.frame.origin.y + targetItem.frame.size.height,
                                   self.frame.size.width,
                                   self.frame.size.height -
                                   (targetItem.frame.origin.y + targetItem.frame.size.height));
    
    leftLayer.frame = CGRectMake(self.frame.origin.x,
                                 targetItem.frame.origin.y,
                                 targetItem.frame.origin.x,
                                 targetItem.frame.size.height);
    
    rightLayer.frame = CGRectMake(targetItem.frame.origin.x + targetItem.frame.size.width,
                                  targetItem.frame.origin.y,
                                  self.frame.size.width -
                                  (targetItem.frame.origin.x + targetItem.frame.size.width),
                                  targetItem.frame.size.height);
    
    [self.layer addSublayer:topLayer];
    [self.layer addSublayer:bottomLayer];
    [self.layer addSublayer:leftLayer];
    [self.layer addSublayer:rightLayer];
}

#pragma mark - private methods

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


@end
