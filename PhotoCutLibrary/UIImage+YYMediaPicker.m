//
//  UIImage+YYMediaPicker.m
//  PhotoCut
//
//  Created by 韩亚周 on 15/11/23.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "UIImage+YYMediaPicker.h"

@implementation UIImage (YYMediaPicker)

- (UIImage *)circularImage
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width, self.size.height), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat imageWidth = self.size.width;
    CGFloat imageHeight = self.size.height;
    CGFloat rectWidth = self.size.width;
    CGFloat rectHeight = self.size.height;
    
    CGFloat scaleFactorX = rectWidth/imageWidth;
    CGFloat scaleFactorY = rectHeight/imageHeight;
    
    CGFloat imageCentreX = rectWidth/2;
    CGFloat imageCentreY = rectHeight/2;
    
    CGFloat radius = rectWidth/2;
    CGContextBeginPath (context);
    CGContextAddArc (context, imageCentreX, imageCentreY, radius, 0, 2*M_PI, 0);
    CGContextClosePath (context);
    CGContextClip (context);
    
    CGContextScaleCTM (context, scaleFactorX, scaleFactorY);
    
    CGRect myRect = CGRectMake(0, 0, imageWidth, imageHeight);
    [self drawInRect:myRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
