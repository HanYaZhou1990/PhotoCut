//
//  NavBarToolView.m
//  PhotoCut
//
//  Created by 韩亚周 on 15/11/26.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "NavBarToolView.h"

@implementation NavBarToolView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _changeCameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _changeCameraButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_changeCameraButton setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [_changeCameraButton addTarget:self action:@selector(changeCameraButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_changeCameraButton];
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|-10-[_changeCameraButton]|"
                              options:1.0
                              metrics:nil
                              views:NSDictionaryOfVariableBindings(_changeCameraButton)]];
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:_changeCameraButton
                             attribute:NSLayoutAttributeRight
                             relatedBy:NSLayoutRelationEqual
                             toItem:self
                             attribute:NSLayoutAttributeRight
                             multiplier:1.0
                             constant:-15]];
    }
    return self;
}
- (void)changeCameraButtonClicked:(UIButton *)sender {
    _changeCameraHandle(self, sender);
}

@end
