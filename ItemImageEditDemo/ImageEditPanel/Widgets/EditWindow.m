//
//  EditWindow.m
//  ItemImageEditDemo
//
//  Created by LF on 15/7/16.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "EditWindow.h"

@implementation EditWindow

- (instancetype)init {
    if (self = [super init]) {
        self.image = [UIImage imageNamed:@"icon_direction-sign_80"];
        self.bounds = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
    }
    return self;

}



- (void)drawRect:(CGRect)rect {
    // Drawing code
}

@end
