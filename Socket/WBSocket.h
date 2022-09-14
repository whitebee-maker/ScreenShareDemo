//
//  WBSocket.h
//  ScreenShareDemo
//
//  Created by weibin on 2022/9/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBSocket : NSObject
- (int)createSocket;
- (NSString *)ip;
@property (nonatomic, assign) int sock;
- (BOOL)connect;
- (BOOL)bind;
- (BOOL)listen;
- (void)receive;
- (void)recvData;
- (void)close;
@end

NS_ASSUME_NONNULL_END
