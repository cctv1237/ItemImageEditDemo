//
//  EditWindow.m
//  ItemImageEditDemo
//
//  Created by LF on 15/7/16.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "EditWindow.h"

@interface EditWindow ()

@property (nonatomic, strong) UIImageView *editSign;
@property (nonatomic, strong) UIView *targetItem;

@end

@implementation EditWindow

#pragma mark - life cycle

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderWidth = 2.f;
        self.layer.borderColor = [[UIColor cyanColor] CGColor];

    }
    return self;

}

#pragma mark - public methods

- (void)didDrawWindowBlockWithTargetItem:(UIView *)targetItem {
    self.targetItem = targetItem;
    self.frame = targetItem.frame;
    [self addSubview:self.editSign];
    [self setNeedsDisplay];
    
}

#pragma mark - private methods

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat stepWidth = self.bounds.size.width / 3;
    CGFloat stepHeight = self.bounds.size.height / 3;
    
    CGPoint startPointLeft = CGPointMake(self.targetItem.bounds.origin.x + stepWidth, self.targetItem.bounds.origin.y);
    CGPoint endPointLeft = CGPointMake(self.targetItem.bounds.origin.x + stepWidth, self.targetItem.bounds.origin.y + 3*stepHeight);
    
    CGPoint startPointRight = CGPointMake(self.targetItem.bounds.origin.x + 2*stepWidth, self.targetItem.bounds.origin.y);
    CGPoint endPointRight = CGPointMake(self.targetItem.bounds.origin.x + 2*stepWidth, self.targetItem.bounds.origin.y + 3*stepHeight);
    
    CGPoint startPointTop = CGPointMake(self.targetItem.bounds.origin.x, self.targetItem.bounds.origin.y + stepHeight);
    CGPoint endPointTop = CGPointMake(self.targetItem.bounds.origin.x + 3*stepWidth, self.targetItem.bounds.origin.y + stepHeight);
    
    CGPoint startPointBottom = CGPointMake(self.targetItem.bounds.origin.x, self.targetItem.bounds.origin.y + 2*stepHeight);
    CGPoint endPointBottom = CGPointMake(self.targetItem.bounds.origin.x + 3*stepWidth, self.targetItem.bounds.origin.y + 2*stepHeight);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, startPointLeft.x, startPointLeft.y);
    CGContextAddLineToPoint(context, endPointLeft.x, endPointLeft.y);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 1);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, startPointRight.x, startPointRight.y);
    CGContextAddLineToPoint(context, endPointRight.x, endPointRight.y);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 1);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, startPointTop.x, startPointTop.y);
    CGContextAddLineToPoint(context, endPointTop.x, endPointTop.y);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 1);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, startPointBottom.x, startPointBottom.y);
    CGContextAddLineToPoint(context, endPointBottom.x, endPointBottom.y);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 1);
    CGContextStrokePath(context);
    
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

- (UIImageView *)editSign {
    if (_editSign == nil) {
        _editSign = [[UIImageView alloc] init];
        _editSign.image = [UIImage imageNamed:@"icon_direction-sign_80"];
        _editSign.contentMode = UIViewContentModeCenter;
        _editSign.center = CGPointMake(self.center.x - self.frame.origin.x, self.center.y - self.frame.origin.y);
    }
    return _editSign;
}

@end
