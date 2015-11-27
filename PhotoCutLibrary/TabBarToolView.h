//
//  TabBarToolView.h
//  PhotoCut
//
//  Created by 韩亚周 on 15/11/26.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBarToolView;

typedef void (^cancleButtonBlock) (TabBarToolView *tabBarView, UIButton *cancleButton, UIButton *takePhotoButton, UIButton *usePictureButton);
typedef void (^takePhotosButtonBlock) (TabBarToolView *tabBarView, UIButton *cancleButton, UIButton *takePhotoButton, UIButton *usePictureButton);
typedef void (^usePictureButtonBlock) (TabBarToolView *tabBarView, UIButton *cancleButton, UIButton *takePhotoButton, UIButton *usePictureButton);

/*!拍照页面下边的工具栏*/
@interface TabBarToolView : UIView

/*!取消按钮*/
@property (nonatomic, strong, readonly) UIButton       *cancleButton;
/*!拍照按钮*/
@property (nonatomic, strong, readonly) UIButton       *takePhotosButton;
/*!拍照以后使用图片按钮*/
@property (nonatomic, strong, readonly) UIButton       *usePictureButton;

/*!取消按钮的的回调*/
@property (nonatomic, copy) cancleButtonBlock          cancleHandle;
@property (nonatomic, copy) takePhotosButtonBlock      takePhotosHandle;
@property (nonatomic, copy) usePictureButtonBlock      usePictureHandle;

@end
