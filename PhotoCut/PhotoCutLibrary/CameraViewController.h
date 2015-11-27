//
//  CameraViewController.h
//  PhotoCut
//
//  Created by 韩亚周 on 15/11/24.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>
#import "NavBarToolView.h"
#import "TabBarToolView.h"
#import "UIImage+YYMediaPicker.h"

@class CameraViewController;

typedef void (^UsePictureBlock) (CameraViewController *cameraVC, UIImage *image);

@interface CameraViewController : UIViewController

/*!AVCaptureSession对象来执行输入设备和输出设备之间的数据传递*/
@property (nonatomic, strong) AVCaptureSession            * session;
/*!AVCaptureDeviceInput对象是输入流*/
@property (nonatomic, strong) AVCaptureDeviceInput        * videoInput;
/*!照片输出流对象，当然我的照相机只有拍照功能，所以只需要这个对象就够了*/
@property (nonatomic, strong) AVCaptureStillImageOutput   * stillImageOutput;
/*!预览图层，来显示照相机拍摄到的画面*/
@property (nonatomic, strong) AVCaptureVideoPreviewLayer  * previewLayer;
/*!放置预览图层的View*/
@property (nonatomic, strong) UIView                      * cameraShowView;
/*!拍照以后，展示图片*/
@property (nonatomic, strong) UIImageView                 * pictureImageView;
/*!点击使用照片的回调*/
@property (nonatomic, copy)   UsePictureBlock               usePictureHandle;
@end
