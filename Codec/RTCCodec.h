//
//  RTCCodec.h
//  ScreenShareDemo
//
//  Created by weibin on 2022/9/22.
//

#import <Foundation/Foundation.h>
#import <VideoToolbox/VideoToolbox.h>

#import "RTCVideoEncoderSettings.h"
#import "RTCCodecProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface RTCCodec : NSObject

// 编解码配置
@property(nonatomic , strong , readonly)RTCVideoEncoderSettings *settings;

// 回调队列
@property(nonatomic , strong , readonly)dispatch_queue_t callbackQueue;

// 代理
@property(nonatomic , weak)id <RTCCodecProtocol> delegate;

/// 使用编解码器之前的配置
/// @param settings 配置
/// @param queue 是否在指定队列里面回调代理方法，如果不传，默认在主线程回调代理方法
- (BOOL)configWithSettings:(RTCVideoEncoderSettings *)settings onQueue:(dispatch_queue_t)queue;

/// 编码
/// @param sampleBuffer 编码 buffer
- (void)encode:(CMSampleBufferRef)sampleBuffer ;

/// 解码
/// @param data 需要解码的数据
-(void)decode:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
