//
//  UIImagePickerController+YYMediaPicker.m
//  PhotoCut
//
//  Created by 韩亚周 on 15/11/23.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "UIImagePickerController+YYMediaPicker.h"
#import "YYMediaPicker.h"

const char * mediaPickerKey;

@implementation UIImagePickerController (YYMediaPicker)

- (void)setMediaPicker:(YYMediaPicker *)mediaPicker
{
    objc_setAssociatedObject(self, &mediaPickerKey, mediaPicker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YYMediaPicker *)mediaPicker
{
    return objc_getAssociatedObject(self, &mediaPickerKey);
}

@end
