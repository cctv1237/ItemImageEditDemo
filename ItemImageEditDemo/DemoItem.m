//
//  DemoItem.m
//  ItemImageEditDemo
//
//  Created by LF on 15/7/15.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "DemoItem.h"

@implementation DemoItem
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(80, 320, 160, 160);
        [self addSubview:self.imageView];
        self.imageView.frame = CGRectMake(0, 0, 160, 160);
        self.imageView.image = [UIImage imageNamed:@"_MG_6752"];
    }
    return self;

}

- (void)replaceImageViewWithImageView:(UIImageView *)imageView {
    self.imageView = imageView;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.borderWidth = 2.f;
        _imageView.layer.borderColor = [[UIColor cyanColor] CGColor];
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}



@end
