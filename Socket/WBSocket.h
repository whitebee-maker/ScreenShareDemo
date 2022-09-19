//
//  WBSocket.h
//  ScreenShareDemo
//
//  Created by weibin on 2022/9/12.
//

#import <Foundation/Foundation.h>
#import <VideoToolbox/VideoToolbox.h>
#import <pthread.h>

NS_ASSUME_NONNULL_BEGIN

#define CONNECT_PORT 8888
#define LOCK(lock) pthread_mutex_lock(&(lock));
#define UNLOCK(lock) pthread_mutex_unlock(&(lock));

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
- (void)setSendbuffer;
- (void)setRecvBuffer;
- (void)setSendingTimeout;
- (void)setRecvTimeout;

@end

NS_ASSUME_NONNULL_END
