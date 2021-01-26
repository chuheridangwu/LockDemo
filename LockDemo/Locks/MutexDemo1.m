//
//  MutexDemo1.m
//  LockDemo
//
//  Created by mlive on 2021/1/26.
//

#import "MutexDemo1.h"
#import <pthread.h>

@interface MutexDemo1 ()
@property (nonatomic,assign)pthread_mutex_t mutex;
@end

@implementation MutexDemo1

- (instancetype)init
{
    self = [super init];
    if (self) {
        pthread_mutexattr_t attr ;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
        
        pthread_mutex_init(&_mutex, &attr);
    }
    return self;
}

static int count = 0;

- (void)otherTest{
    pthread_mutex_lock(&_mutex);
    if (count <= 10) {
        NSLog(@"%s --",__func__);
        count += 1;
        [self otherTest];
    }
    pthread_mutex_unlock(&_mutex);
}

@end
