//
//  NSDictionary+YYMediaPicker.m
//  PhotoCut
//
//  Created by 韩亚周 on 15/11/23.
//  Copyright (c) 2015年 韩亚周. All rights reserved.
//

#import "NSDictionary+YYMediaPicker.h"

@implementation NSDictionary (YYMediaPicker)

- (UIImage *)originalImage
{
    if ([self.allKeys containsObject:UIImagePickerControllerOriginalImage]) {
        return self[UIImagePickerControllerOriginalImage];
    }
    return nil;
}

- (UIImage *)editedImage
{
    if ([self.allKeys containsObject:UIImagePickerControllerEditedImage]) {
        return self[UIImagePickerControllerEditedImage];
    }
    return nil;
}

- (UIImage *)circularEditedImage
{
    if ([self.allKeys containsObject:@"YYImagePickerControllerCircularEditedImage"]) {
        return self[@"YYImagePickerControllerCircularEditedImage"];
    }
    return nil;
}

- (NSURL *)mediaURL
{
    if ([self.allKeys containsObject:UIImagePickerControllerMediaURL]) {
        return self[UIImagePickerControllerMediaURL];
    }
    return nil;
}

- (NSDictionary *)mediaMetadata
{
    if ([self.allKeys containsObject:UIImagePickerControllerMediaMetadata]) {
        return self[UIImagePickerControllerMediaMetadata];
    }
    return nil;
}

- (YYMediaType)mediaType
{
    if ([self.allKeys containsObject:UIImagePickerControllerMediaType]) {
        NSString *type = self[UIImagePickerControllerMediaType];
        if ([type isEqualToString:(NSString *)kUTTypeImage]) {
            return YYMediaTypePhoto;
        } else if ([type isEqualToString:(NSString *)kUTTypeMovie]) {
            return YYMediaTypeVideo;
        }
    }
    return YYMediaTypePhoto;
}

@end
