//
//  PthreadRwLock.m
//  LockDemo
//
//  Created by mlive on 2021/1/29.
//

#import "PthreadRwLock.h"
#import <pthread.h>

@interface PthreadRwLock()
@property (nonatomic,assign)pthread_rwlock_t rwlock;

@end

@implementation PthreadRwLock

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        pthread_rwlock_init(&_rwlock, NULL);
    }
    return self;
}

-(void)otherTest{
    dispatch_queue_t queue = dispatch_queue_create("lock", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            [self read];
        });
        dispatch_async(queue, ^{
            [self read];
        });
        dispatch_async(queue, ^{
            [self read];
        });
        dispatch_async(queue, ^{
            [self write];
        });
        dispatch_async(queue, ^{
            [self write];
        });
        dispatch_async(queue, ^{
            [self write];
        });
    }
}

- (void)read{
    pthread_rwlock_rdlock(&_rwlock);
    sleep(1);
    NSLog(@" ----read ----");
    pthread_rwlock_unlock(&_rwlock);
}

- (void)write{
    pthread_rwlock_wrlock(&_rwlock);
    sleep(1);
    NSLog(@" ---- write ----");
    pthread_rwlock_unlock(&_rwlock);
}

- (void)dealloc{
    pthread_rwlock_destroy(&_rwlock);
}

@end
