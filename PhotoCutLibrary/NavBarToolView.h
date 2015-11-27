//
//  NavBarToolView.h
//  PhotoCut
//
//  Created by 韩亚周 on 15/11/26.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NavBarToolView;

typedef void (^changeCameraButtonBlock) (NavBarToolView *, UIButton *);

/*!拍照页面上边的工具栏 */
@interface NavBarToolView : UIView

@property (nonatomic, strong, readonly) UIButton     *switchFlashButton;

@property (nonatomic, strong, readonly) UIButton     *changeCameraButton;

@property (nonatomic, copy) changeCameraButtonBlock  changeCameraHandle;

@end
