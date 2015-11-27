//
//  UIImagePickerController+YYMediaPicker.h
//  PhotoCut
//
//  Created by 韩亚周 on 15/11/23.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYMediaPicker;

#import <objc/runtime.h>

@interface UIImagePickerController (YYMediaPicker)

@property (strong, nonatomic) YYMediaPicker *mediaPicker;

@end
