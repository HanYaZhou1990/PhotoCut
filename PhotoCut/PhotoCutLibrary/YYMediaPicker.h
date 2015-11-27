//
//  YYMediaPicker.h
//  PhotoCut
//
//  Created by 韩亚周 on 15/11/23.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIImagePickerController+YYMediaPicker.h"
#import "UIImage+YYMediaPicker.h"

@class YYMediaPicker;

typedef enum {
    YYMediaTypePhoto = 0,
    YYMediaTypeVideo = 1,
    YYMediaTypeAll   = 2
} YYMediaType;

typedef enum {
    YYEditModeStandard = 0,/*矩形,系统自己的剪切形式*/
    YYEditModeCircular = 1,/*圆形*/
    YYEditModeNone     = 2/*无剪切*/
} YYEditMode;

/*!目前只支持取图片*/
@protocol YYMediaPickerDelegate <NSObject>

@end

typedef void (^TakeImageFinish) (YYMediaPicker *mediaPicker,NSDictionary *mediaInfo);

@interface YYMediaPicker : NSObject<YYMediaPickerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (assign, nonatomic) YYMediaType mediaType;
@property (assign, nonatomic) YYEditMode  editMode;

@property (nonatomic, copy) TakeImageFinish finishHandle;

- (void)takePhotoFromPhotoLibrary;

@end
