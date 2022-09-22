//
//  RTCCodecProtocol.h
//  ScreenShareDemo
//
//  Created by weibin on 2022/9/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RTCCodecProtocol <NSObject>

#pragma mark - decoder

/// 获取解码后的数据
/// @param pixelBuffer 解码后的数据
- (void)didGetDecodeBuffer:(CVPixelBufferRef)pixelBuffer;

#pragma mark - encoder

/// sps pps 数据
/// @param sps sps
/// @param pps pps
- (void)spsData:(NSData *)sps ppsData:(NSData *)pps;

/// nalu 数据
/// @param naluData nalu 数据
- (void)naluData:(NSData *)naluData;


@end

NS_ASSUME_NONNULL_END
