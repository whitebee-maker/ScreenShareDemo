//
//  BufferUtils.m
//  ScreenShareDemo
//
//  Created by weibin on 2022/9/19.
//

#import "BufferUtils.h"

@implementation BufferUtils

+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth {
    if (!image) {
        return nil;
    }
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = newImageWidth;
    float height = image.size.height / (image.size.width / width);
    float widthScale = imageWidth / width;
    float heightScale = imageHeight / height;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
}


@end
