//
//  CameraViewController.m
//  PhotoCut
//
//  Created by 韩亚周 on 15/11/24.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
/*隐藏状态栏*/
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void) embedPreviewInView: (UIView *) aView {
    if (!self.session) return;
    //设置取景
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession: self.session];
    _previewLayer.frame = aView.bounds;
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [aView.layer addSublayer: _previewLayer];
    
    [self add];
}

- (void)add{
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    int position = 0;
    
    if (screenHeight == 568){
        position = 84;
    } else {
        position = 80;
    }
    BOOL isIpad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    
    CGFloat diameter = isIpad ? MAX(self.cameraShowView.frame.size.width, self.cameraShowView.frame.size.height) : MIN(self.self.cameraShowView.frame.size.width, self.cameraShowView.frame.size.height);
    
//    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:
//                                CGRectMake(0.0f, position, diameter, diameter)];
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    CGRect rect = [[UIScreen mainScreen] bounds];
    [circlePath addArcWithCenter:CGPointMake(CGRectGetWidth(rect)/2, (CGRectGetHeight(rect)-80)/2) radius:CGRectGetWidth(rect)/2 startAngle:0 endAngle:2*M_PI clockwise:0];
    [circlePath setUsesEvenOddFillRule:YES];
    [circleLayer setPath:[circlePath CGPath]];
    [circleLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    CGFloat bottomBarHeight = isIpad ? 51 : 80;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, diameter, screenHeight - bottomBarHeight) cornerRadius:0];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.name = @"fillLayer";
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor redColor].CGColor;
    fillLayer.opacity = 0.5;
    [self.view.layer addSublayer:fillLayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSession];
    
    [self.session startRunning];
    
    _pictureImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _pictureImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _pictureImageView.hidden = YES;
    _pictureImageView.backgroundColor = [UIColor yellowColor];
    _pictureImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_pictureImageView];
    
    NavBarToolView *navBarView = [[NavBarToolView alloc] initWithFrame:CGRectZero];
    navBarView.translatesAutoresizingMaskIntoConstraints = NO;
    navBarView.changeCameraHandle = ^(NavBarToolView *navBar, UIButton *sender){
        /*前后摄像头切换*/
        [UIView transitionWithView:self.cameraShowView
                          duration:0.3
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            [self toggleCamera];
                        }
                        completion:^(BOOL finished) {
                            
                        }];
    };
    [self.view addSubview:navBarView];
    
    /*下边的取消，拍照和使用照片按钮*/
    TabBarToolView *tabBarView = [[TabBarToolView alloc] initWithFrame:CGRectZero];
    tabBarView.translatesAutoresizingMaskIntoConstraints = NO;
    tabBarView.cancleHandle = ^(TabBarToolView *tabBarView, UIButton *cancleButton, UIButton *takePhotoButton, UIButton *usePictureButton){
        /*取消拍照*/
        if ([cancleButton.titleLabel.text isEqualToString:@"取消"]) {
            [self.session stopRunning];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            navBarView.hidden = NO;
            [self.session startRunning];
            _pictureImageView.hidden = YES;
            takePhotoButton.hidden = NO;
            usePictureButton.hidden = YES;
        }
    };
    tabBarView.takePhotosHandle = ^(TabBarToolView *tabBarView, UIButton *cancleButton, UIButton *takePhotoButton, UIButton *usePictureButton){
        /*拍照*/
        [self captureimageWithCancle:cancleButton takePhoto:takePhotoButton usePicture:usePictureButton andView:navBarView];
    };
    tabBarView.usePictureHandle = ^(TabBarToolView *tabBarView, UIButton *cancleButton, UIButton *takePhotoButton, UIButton *usePictureButton){
        /*使用照片*/
        [self dismissViewControllerAnimated:YES completion:^{
            UIImage *image = [_pictureImageView.image circularImage];
            _usePictureHandle(self, image);
        }];
    };
    [self.view addSubview:tabBarView];
    
    self.cameraShowView = [[UIView alloc] initWithFrame:CGRectZero];
    _cameraShowView.translatesAutoresizingMaskIntoConstraints = NO;
    _cameraShowView.bounds = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds])-80);
    [self.view addSubview:self.cameraShowView];
    /*将navBarView放到顶层，防止被盖住*/
    [self.view bringSubviewToFront:navBarView];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|[_cameraShowView][tabBarView(==80)]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_cameraShowView,tabBarView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|[navBarView(==40)]"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(navBarView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[navBarView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(navBarView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[_cameraShowView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_cameraShowView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[tabBarView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(tabBarView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|[_pictureImageView]-80-|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_pictureImageView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[_pictureImageView]|"
                               options:1.0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_pictureImageView)]];
    
    [self embedPreviewInView:self.cameraShowView];
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

- (AVCaptureDevice *)backCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

- (void) initialSession
{
    /*一个AVCaptureSession 可以协调多个输入设备及输出设备。通过 AVCaptureSession 的 addInput、addOutput 方法可将输入、输出设备加入 AVCaptureSession 中*/
    /*创建 AVCaptureSession*/
    self.session = [[AVCaptureSession alloc] init];
    /*设置Session 属性*/
    [self.session setSessionPreset:AVCaptureSessionPresetPhoto];
    
    
    /*2.创建、配置输入设备*/
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    /*
#if 1
    int flags = NSKeyValueObservingOptionNew; //监听自动对焦
    [device addObserver:self forKeyPath:@"adjustingFocus" options:flags context:nil];
#endif
    */
    NSError *error;
    _videoInput = [AVCaptureDeviceInput deviceInputWithDevice:[self backCamera] error:&error];
    if (!_videoInput)
        {
        NSLog(@"Error: %@", [error localizedDescription]);
        return;
        }
    [self.session addInput:_videoInput];
    
        //3.创建、配置输出
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    [self.session addOutput:self.stillImageOutput];
}
/*拍照*/
-(void)captureimageWithCancle:(UIButton *)cancle
                    takePhoto:(UIButton *)takePhoto
                   usePicture:(UIButton *)usePicture
                      andView:(UIView *)aView
{
        //get connection
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) { break; }
    }
    
        //get UIImage
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:
     ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
         CFDictionaryRef exifAttachments =
         CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
         if (exifAttachments) {
             // Do something with the attachments.
         }
         
             // Continue as appropriate.
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *t_image = [UIImage imageWithData:imageData];
         
         aView.hidden = YES;
         [self.session stopRunning];
         [cancle setTitle:@"重置" forState:UIControlStateNormal];
         takePhoto.hidden = YES;
         usePicture.hidden = NO;
         _pictureImageView.hidden = NO;
         _pictureImageView.image = t_image;
     }];
}

/*前后摄像头切换*/
- (void)toggleCamera {
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        NSError *error;
        AVCaptureDeviceInput *newVideoInput;
        AVCaptureDevicePosition position = [[_videoInput device] position];
        
        if (position == AVCaptureDevicePositionBack)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:&error];
        else if (position == AVCaptureDevicePositionFront)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:&error];
        else
            return;
        
        if (newVideoInput != nil) {
            /*重设session
             beginConfiguration
             commitConfiguration
             */
            [self.session beginConfiguration];
            [self.session removeInput:self.videoInput];
            if ([self.session canAddInput:newVideoInput]) {
                [self.session addInput:newVideoInput];
                [self setVideoInput:newVideoInput];
            } else {
                [self.session addInput:self.videoInput];
            }
            [self.session commitConfiguration];
        } else if (error) {
            NSLog(@"toggle carema failed, error = %@", error);
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear: animated];
    if (self.session) {
        [self.session stopRunning];
    }
}

- (void) dealloc{
    /*不监听对焦*/
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    [device removeObserver:self forKeyPath:@"adjustingFocus"];
    self.session = nil;
}
/*//对焦回调
 - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
 if( [keyPath isEqualToString:@"adjustingFocus"] ){
 BOOL adjustingFocus = [ [change objectForKey:NSKeyValueChangeNewKey] isEqualToNumber:[NSNumber numberWithInt:1] ];
 NSLog(@"Is adjusting focus? %@", adjustingFocus ? @"YES" : @"NO" );
 NSLog(@"Change dictionary: %@", change);
 }
 }*/

@end
