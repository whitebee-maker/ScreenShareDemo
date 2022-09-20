//
//  BufferUtils.h
//  ScreenShareDemo
//
//  Created by weibin on 2022/9/19.
//

#import <Foundation/Foundation.h>
#import <VideoToolbox/VideoToolbox.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BufferUtils : NSObject

+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth;
+ (size_t)getCMTimeSize;
+ (CVPixelBufferRef)CVPixelBufferRefFromUiImage:(UIImage *)img;
+ (CMSampleBufferRef)sampleBufferFromPixbuffer:(CVPixelBufferRef)pixbuffer time:(CMTime)time;
+ (UIImage *)imageFromBuffer:(CMSampleBufferRef)buffer;

@end

NS_ASSUME_NONNULL_END
