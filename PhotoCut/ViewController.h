//
//  ViewController.h
//  PhotoCut
//
//  Created by 韩亚周 on 15/11/23.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYMediaPicker.h"
#import "NSDictionary+YYMediaPicker.h"
#import "CameraViewController.h"

@interface ViewController : UIViewController

@property (nonatomic,strong) YYMediaPicker *mediaPicker;
@property (nonatomic,strong) UIImageView   *backGroundImageView;

@end

