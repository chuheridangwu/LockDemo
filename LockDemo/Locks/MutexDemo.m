//
//  MuthexDemo.m
//  LockDemo
//
//  Created by mlive on 2021/1/26.
//

#import "MutexDemo.h"
#import <pthread.h>

@interface MutexDemo()
@property (nonatomic, assign)pthread_mutex_t moneyMutex;
@property (nonatomic, assign)pthread_mutex_t ticketMutex;
@end

@implementation MutexDemo

- (void)__initWithMutex2:(pthread_mutex_t *)mutex{
    // 使用NUll 等同于下面的初始化代码
    pthread_mutex_init(mutex, NULL);
}

- (void)__initWithMutex:(pthread_mutex_t*)mutex{
    pthread_mutexattr_t attr;
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    pthread_mutexattr_init(&attr);
    // 初始化锁
    pthread_mutex_init(mutex, &attr);    
    // 销毁
    pthread_mutexattr_destroy(&attr);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self __initWithMutex2:&_ticketMutex];
        [self __initWithMutex2:&_moneyMutex];
        
    }
    return self;
}

- (void)__saveMoney{
    pthread_mutex_lock(&_moneyMutex);
    [super __saveMoney];
    pthread_mutex_unlock(&_moneyMutex);
}

- (void)__drewMoney{
    pthread_mutex_lock(&_moneyMutex);
    [super __drewMoney];
    pthread_mutex_unlock(&_moneyMutex);
}

- (void)__saleTicket{
    pthread_mutex_lock(&_ticketMutex);
    [super __saleTicket];
    pthread_mutex_unlock(&_ticketMutex);
}

- (void)dealloc{
    // 不使用时应该销毁锁
    pthread_mutex_destroy(&_ticketMutex);
    pthread_mutex_destroy(&_moneyMutex);
}

@end
