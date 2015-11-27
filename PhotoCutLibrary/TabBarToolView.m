//
//  TabBarToolView.m
//  PhotoCut
//
//  Created by 韩亚周 on 15/11/26.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "TabBarToolView.h"

@implementation TabBarToolView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(cancleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancleButton];
        
        _takePhotosButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _takePhotosButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_takePhotosButton setBackgroundImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateNormal];
        [_takePhotosButton addTarget:self action:@selector(takePhotosButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_takePhotosButton];
        
        _usePictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _usePictureButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_usePictureButton setTitle:@"使用照片" forState:UIControlStateNormal];
        [_usePictureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _usePictureButton.hidden = YES;
        [_usePictureButton addTarget:self action:@selector(usePictureClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_usePictureButton];
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|-20-[_cancleButton]-20-|"
                              options:1.0
                              metrics:nil
                              views:NSDictionaryOfVariableBindings(_cancleButton)]];
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:_cancleButton
                             attribute:NSLayoutAttributeLeft
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeLeft
                             multiplier:1.0
                             constant:15]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:_takePhotosButton
                             attribute:NSLayoutAttributeCenterX
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeCenterX
                             multiplier:1.0
                             constant:0]];
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:_takePhotosButton
                             attribute:NSLayoutAttributeCenterY
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeCenterY
                             multiplier:1.0
                             constant:0]];
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:_takePhotosButton
                             attribute:NSLayoutAttributeWidth
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeWidth
                             multiplier:1.0
                             constant:60]];
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:_takePhotosButton
                             attribute:NSLayoutAttributeHeight
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeHeight
                             multiplier:1.0
                             constant:60]];
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|-20-[_usePictureButton]-20-|"
                              options:1.0
                              metrics:nil
                              views:NSDictionaryOfVariableBindings(_usePictureButton)]];
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:_usePictureButton
                             attribute:NSLayoutAttributeRight
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeRight
                             multiplier:1.0
                             constant:-15]];

        
    }
    return self;
}

/*取消*/
- (void)cancleButtonClicked:(UIButton *)sender {
    _cancleHandle(self, sender, _takePhotosButton, _usePictureButton);
}
/*拍照*/
- (void)takePhotosButtonClicked:(UIButton *)sender {
    _takePhotosHandle(self, _cancleButton, sender, _usePictureButton);
}
/*使用照片*/
- (void)usePictureClicked:(UIButton *)sender {
    _usePictureHandle(self, _cancleButton, _takePhotosButton, sender);
}

@end
