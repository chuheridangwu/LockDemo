//
//  BarrierDemo.m
//  LockDemo
//
//  Created by mlive on 2021/1/29.
//

#import "BarrierDemo.h"

@interface BarrierDemo ()
@property (nonatomic,strong)dispatch_queue_t queue;
@end

@implementation BarrierDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)otherTest{
    for (int i = 0; i < 10; i++) {
        dispatch_async(_queue, ^{
            [self read];
        });
        dispatch_async(_queue, ^{
            [self read];
        });
        dispatch_async(_queue, ^{
            [self read];
        });
        dispatch_barrier_async(_queue, ^{
            [self write];
        });
        dispatch_barrier_async(_queue, ^{
            [self write];
        });
        dispatch_barrier_async(_queue, ^{
            [self write];
        });
    }
    
}

- (void)read{
    sleep(1);
    NSLog(@" ----read ----");
}

- (void)write{
    sleep(1);
    NSLog(@" ---- write ----");
}


@end
