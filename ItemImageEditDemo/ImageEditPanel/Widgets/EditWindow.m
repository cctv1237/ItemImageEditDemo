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

@end

@implementation EditWindow

#pragma mark - life cycle

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.editSign];
    }
    return self;

}

#pragma mark - public methods



#pragma mark - private methods

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

#pragma mark - getters and setters

- (UIImageView *)editSign {
    if (_editSign == nil) {
        _editSign = [[UIImageView alloc] init];
        _editSign.image = [UIImage imageNamed:@"icon_direction-sign_80"];
        _editSign.bounds = CGRectMake(0, 0, _editSign.image.size.width, _editSign.image.size.height);
        _editSign.center = self.center;
    }
    return _editSign;
}

@end
