//
//  NSRecursiveLockDemo.m
//  LockDemo
//
//  Created by mlive on 2021/1/28.
//

#import "NSRecursiveLockDemo.h"

@interface NSRecursiveLockDemo()
@property (nonatomic, strong)NSRecursiveLock *recursiveLock;
@end

@implementation NSRecursiveLockDemo
- (instancetype)init
{
    self = [super init];
    if (self) {
        _recursiveLock = [NSRecursiveLock new];
    }
    return self;
}

- (void)otherTest{
    dispatch_queue_t queue = dispatch_queue_create("1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [self test];
    });
    dispatch_async(queue, ^{
        [self test];
    });
}

- (void)test{
    static int index = 0;
    NSLog(@"%@ ---",[NSThread currentThread]);
    [_recursiveLock lock];
    while (index < 10) {
        index += 1;
        NSLog(@"%@ --- %d",[NSThread currentThread],index);
        [self test];
    }
    [_recursiveLock unlock];
}
@end
