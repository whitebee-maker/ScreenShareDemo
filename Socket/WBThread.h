//
//  WBThread.h
//  ScreenShareDemo
//
//  Created by weibin on 2022/9/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^Block)(void);
@interface WBThread : NSObject

- (void)executeTaskWithBlock:(Block)block;
- (void)run;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
