//
//  WBSocket.m
//  ScreenShareDemo
//
//  Created by weibin on 2022/9/12.
//

#import "WBSocket.h"

#import <sys/socket.h>

@implementation WBSocket
- (int)createSocket {
    self.sock = socket(AF_INET, SOCK_STREAM, 0);
    if (self.sock == -1) {
        close(self.sock);
        NSLog(@"create socket error: %d", self.sock);
    }
    self
}
@end
