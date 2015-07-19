//
//  ViewController.m
//  ItemImageEditDemo
//
//  Created by LF on 15/7/14.
//  Copyright (c) 2015年 Beauty Sight Network Technology Co.,Ltd. All rights reserved.
//

#import "ViewController.h"
#import "DemoItem.h"
#import "LFImageClipEditPanel.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *backScrollView;
@property (nonatomic, strong) DemoItem *demoItem;
@property (nonatomic, strong) UIButton *edit;
@property (nonatomic, strong) UIButton *endEdit;

@property (nonatomic, strong) LFImageClipEditPanel *imageEditPanel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backScrollView];
    [self.backScrollView addSubview:self.demoItem];
    [self.backScrollView addSubview:self.edit];
    [self.backScrollView addSubview:self.endEdit];
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor darkGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event response

- (void)didTappedEditButton {
    [self.imageEditPanel showAtItem:self.demoItem inView:self.backScrollView];
}
- (void)didTappedEndEditButton {
    [self.imageEditPanel hide];
    self.imageEditPanel = nil;
}

#pragma mark - Setters and Getters

- (UIScrollView *)backScrollView {
    if (_backScrollView == nil) {
        _backScrollView = [[UIScrollView alloc] init];
        _backScrollView.frame = self.view.frame;
        _backScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2);
    }
    return _backScrollView;
}

- (UIView *)demoItem {
    if (_demoItem == nil) {
        _demoItem = [[DemoItem alloc] init];
        
    }
    return _demoItem;
}

- (UIButton *)edit {
    if (_edit == nil) {
        _edit = [[UIButton alloc] init];
        _edit.frame = CGRectMake(20, 20, 80, 80);
        _edit.backgroundColor = [UIColor cyanColor];
        [_edit addTarget:self action:@selector(didTappedEditButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _edit;
}

- (UIButton *)endEdit {
    if (_endEdit == nil) {
        _endEdit = [[UIButton alloc] init];
        _endEdit = [[UIButton alloc] init];
        _endEdit.frame = CGRectMake(220, 20, 80, 80);
        _endEdit.backgroundColor = [UIColor blueColor];
        [_endEdit addTarget:self action:@selector(didTappedEndEditButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _endEdit;
}

- (LFImageClipEditPanel *)imageEditPanel {
    if (_imageEditPanel == nil) {
        _imageEditPanel = [[LFImageClipEditPanel alloc] init];
        
    }
    return _imageEditPanel;
}

@end
