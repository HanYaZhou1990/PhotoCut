//
//  ViewController.m
//  PhotoCut
//
//  Created by 韩亚周 on 15/11/23.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 80, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetWidth([[UIScreen mainScreen] bounds]))];
    _backGroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_backGroundImageView];
    
    _mediaPicker = [[YYMediaPicker alloc]init];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(40, 400, 120, 60);
    [button setTitle:@"相册" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(photoAblum:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(180, 400, 120, 60);
    [button1 setTitle:@"相机" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor redColor];
    [button1 addTarget:self action:@selector(camera:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}

- (void)photoAblum:(UIButton *)sender {
    [self takePhotoFromPhotoLibrary];
}

- (void)camera:(UIButton *)sender {
    CameraViewController *v = [[CameraViewController alloc] init];
    v.usePictureHandle = ^(CameraViewController *cameraVC, UIImage *image){
        _backGroundImageView.image= image;
    };
    [self presentViewController:v animated:YES completion:nil];
}

- (void)takePhotoFromPhotoLibrary
{
    _mediaPicker.editMode = YYEditModeCircular;
    _mediaPicker.mediaType = YYMediaTypePhoto;
    __weak ViewController *v = self;
    [_mediaPicker takePhotoFromPhotoLibrary];
    _mediaPicker.finishHandle = ^(YYMediaPicker *picker, NSDictionary *info){
        UIImage *image = picker.editMode == YYEditModeCircular? info.circularEditedImage:info.editedImage;
        v.backGroundImageView.image = image;
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
