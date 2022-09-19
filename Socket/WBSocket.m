//
//  WBSocket.m
//  ScreenShareDemo
//
//  Created by weibin on 2022/9/12.
//

#import "WBSocket.h"

#import <arpa/inet.h>
#import <netdb.h>
#import <sys/types.h>
#import <sys/socket.h>
#import <ifaddrs.h>

#import "WBThread.h"

@interface WBSocket()

@property(nonatomic, strong)WBThread *recvThread;

@end

@implementation WBSocket

- (int)createSocket {
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    self.sock = sock;
    if (self.sock == -1) {
        close(self.sock);
        NSLog(@"create socket error: %d", self.sock);
    }
    self.recvThread = [[WBThread alloc] init];
    [self.recvThread run];
    return sock;
}

- (void)setSendBuffer {
    int optVal = 1024 * 1024 * 2;
    int optLen = sizeof(int);
    int res = setsockopt(self.sock, SOL_SOCKET, SO_SNDBUF, (char*)&optVal, optLen);
    NSLog(@"set send buffer res: %d", res);
}

- (void)setRecvBuffer{
    int optVal = 1024 * 1024 * 2;
    int optLen = sizeof(int);
    int res = setsockopt(self.sock, SOL_SOCKET,SO_RCVBUF,(char*)&optVal,optLen);
    NSLog(@"set recv buffer:%d", res);
}

- (void)setSendingTimeout{
    struct timeval timeout = {10,0};
    int res = setsockopt(self.sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&timeout, sizeof(int));
    NSLog(@"set send timeout:%d", res);
}

- (void)setRecvTimeout{
    struct timeval timeout = {10,0};
    int  res = setsockopt(self.sock, SOL_SOCKET, SO_RCVTIMEO, (char *)&timeout, sizeof(int));
    NSLog(@"set recv timeout:%d", res);
}

- (BOOL)connect {
    NSString *serverHost = [self ip];
    struct hostent *server = gethostbyname([serverHost UTF8String]);
    if (server == NULL) {
        close(self.sock);
        NSLog(@"connect get host error");
        return NO;
    }
    struct in_addr *remoteAddr = (struct in_addr *)server->h_addr_list[0];
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_addr = *remoteAddr;
    addr.sin_port = htons(CONNECT_PORT);
    int res = connect(self.sock, (struct sockaddr *) &addr, sizeof(addr));
    if (res == -1) {
        close(self.sock);
        NSLog(@"connect error");
        return NO;
    }
    NSLog(@"socket connect to server success");
    return YES;
}

- (BOOL)bind {
    struct sockaddr_in client;
    client.sin_family = AF_INET;
    NSString *ipStr = [self ip];
    if (ipStr.length <= 0) {
        return NO;
    }
    const char *ip = [ipStr cStringUsingEncoding:NSASCIIStringEncoding];
    client.sin_addr.s_addr = inet_addr(ip);
    client.sin_port = htons(CONNECT_PORT);
    int bd = bind(self.sock, (struct sockaddr *) &client, sizeof(client));
    if (bd == -1) {
        close(self.sock);
        NSLog(@"bind error : %d",bd);
        return NO;
    }
    return YES;
}

- (BOOL)listen {
    int ls = listen(self.sock, 128);
    if (ls == -1) {
        close(self.sock);
        NSLog(@"listen error : %d",ls);
        return NO;
    }
    return YES;
}

- (void)receive{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self recvData];
    });
}

- (NSString *)ip{
    NSString *ip = nil;
    struct ifaddrs *addrs = NULL;
    struct ifaddrs *tmpAddrs = NULL;
    BOOL res = getifaddrs(&addrs);
    if (res == 0) {
        tmpAddrs = addrs;
        while (tmpAddrs != NULL) {
            if(tmpAddrs->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                NSLog(@"%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)tmpAddrs->ifa_addr)->sin_addr)]);
                if([[NSString stringWithUTF8String:tmpAddrs->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    ip = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)tmpAddrs->ifa_addr)->sin_addr)];
                }
            }
            tmpAddrs = tmpAddrs->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(addrs);
    NSLog(@"%@",ip);
    return ip;
}


-(void)close{
    int res = close(self.sock);
    NSLog(@"colse : %d",res);
}
- (void)recvData{
    //todo
}
-(void)dealloc{
    [self.recvThread stop];
}

@end
