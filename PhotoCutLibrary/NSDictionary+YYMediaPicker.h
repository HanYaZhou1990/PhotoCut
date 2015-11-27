//
//  NSDictionary+YYMediaPicker.h
//  PhotoCut
//
//  Created by 韩亚周 on 15/11/23.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YYMediaPicker.h"

@interface NSDictionary (YYMediaPicker)

@property (readonly, nonatomic) UIImage      *originalImage;
@property (readonly, nonatomic) UIImage      *editedImage;
@property (readonly, nonatomic) NSURL        *mediaURL;
@property (readonly, nonatomic) NSDictionary *mediaMetadata;
@property (readonly, nonatomic) YYMediaType  mediaType;
@property (readonly, nonatomic) UIImage      *circularEditedImage;

@end
