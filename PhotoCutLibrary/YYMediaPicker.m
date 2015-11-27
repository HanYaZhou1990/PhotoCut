//
//  YYMediaPicker.m
//  PhotoCut
//
//  Created by 韩亚周 on 15/11/23.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "YYMediaPicker.h"

@implementation YYMediaPicker

- (UIWindow *)currentVisibleWindow
{
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            return window;
        }
    }
    return [[[UIApplication sharedApplication] delegate] window];
}

- (UIViewController *)currentVisibleController
{
    UIViewController *topController = self.currentVisibleWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
}

- (void)takePhotoFromPhotoLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.allowsEditing = _editMode != YYEditModeNone;
        imagePicker.delegate = self;
        /*UIImagePickerControllerSourceTypePhotoLibrary
         UIImagePickerControllerSourceTypeCamera
         */
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        imagePicker.mediaPicker = self;
        [self.currentVisibleController presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:NSClassFromString(@"PLUIImageViewController")] && self.editMode && [navigationController.viewControllers count] == 3) {
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
        UIView *plCropOverlay = [[viewController.view.subviews objectAtIndex:1] subviews][0];
        plCropOverlay.hidden = YES;
        int position = 0;
        
        if (screenHeight == 568){
            position = 124;
        } else {
            position = 80;
        }
        
        BOOL isIpad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
        
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        
        CGFloat diameter = isIpad ? MAX(plCropOverlay.frame.size.width, plCropOverlay.frame.size.height) : MIN(plCropOverlay.frame.size.width, plCropOverlay.frame.size.height);
        
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:
                                    CGRectMake(0.0f, position, diameter, diameter)];
        [circlePath setUsesEvenOddFillRule:YES];
        [circleLayer setPath:[circlePath CGPath]];
        [circleLayer setFillColor:[[UIColor clearColor] CGColor]];
        
        CGFloat bottomBarHeight = isIpad ? 51 : 72;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, diameter, screenHeight - bottomBarHeight) cornerRadius:0];
        [path appendPath:circlePath];
        [path setUsesEvenOddFillRule:YES];
        
        CAShapeLayer *fillLayer = [CAShapeLayer layer];
        fillLayer.name = @"fillLayer";
        fillLayer.path = path.CGPath;
        fillLayer.fillRule = kCAFillRuleEvenOdd;
        fillLayer.fillColor = [UIColor blackColor].CGColor;
        fillLayer.opacity = 0.5;
        [viewController.view.layer addSublayer:fillLayer];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    if ([[info allKeys] containsObject:UIImagePickerControllerEditedImage]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:info];
        dic[@"YYImagePickerControllerCircularEditedImage"] = [dic[UIImagePickerControllerEditedImage] circularImage];
        info = [NSDictionary dictionaryWithDictionary:dic];
    }
    _finishHandle(self, info);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"cancel");
}

@end
