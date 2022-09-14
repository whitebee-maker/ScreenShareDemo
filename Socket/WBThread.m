//
//  WBThread.m
//  ScreenShareDemo
//
//  Created by weibin on 2022/9/12.
//

#import "WBThread.h"

@interface WBNSThread : NSThread

@end

@implementation WBNSThread

- (void)dealloc{
    NSLog(@"nsthread dealoc");
}

@end

@interface WBThread()

@property(nonatomic, strong)WBNSThread *thread;
@property(nonatomic, assign)BOOL stoped;

@end

@implementation WBThread

- (instancetype)init {
    if (self = [super init]) {
        self.stoped = NO;
        __weak typeof(self) weakSelf = self;
        self.thread = [[WBNSThread alloc] initWithBlock:^{
            [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
            while (weakSelf && !weakSelf.stoped) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }];
    }
    return self;
}

- (void)executeTaskWithBlock:(Block)block {
    if (!self.thread || !block) {
        return;
    }
    [self performSelector:@selector(_excuteTask:) onThread:self.thread withObject:block waitUntilDone:NO];
}

- (void)run {
    [self.thread start];
}

- (void)stop {
    if (!self.thread) {
        return;
    }
    [self performSelector:@selector(_stopRunloop) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)_stopRunloop {
    self.stoped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}

- (void)_excuteTask:(void (^)(void))block {
    block();
}

- (void)dealloc {
    NSLog(@"thread dealloc");
    [self stop];
}

@end
