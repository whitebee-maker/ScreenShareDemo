//
//  RTCVideoEncoderSettings.h
//  ScreenShareDemo
//
//  Created by weibin on 2022/9/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTCVideoEncoderSettings : NSObject

@property(nonatomic , copy)NSString *name;
@property(nonatomic , assign)unsigned short width;
@property(nonatomic , assign)unsigned short height;
@property(nonatomic, assign) unsigned int startBitrate;
@property(nonatomic, assign) unsigned int maxBitrate;
@property(nonatomic, assign) unsigned int minBitrate;
@property(nonatomic, assign) uint32_t maxFramerate;

@end

NS_ASSUME_NONNULL_END
